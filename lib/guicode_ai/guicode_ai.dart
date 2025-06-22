import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:guicooode/helpe_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class USSDCommand {
  final String service;
  final String serviceType;
  final String paymentMethod;
  final String amount;
  final String code;

  USSDCommand({
    required this.service,
    required this.serviceType,
    required this.paymentMethod,
    required this.amount,
    required this.code,
  });
}

class CommandProcessor {
  // Mots-clés pour détecter les services et sous-services
  static final Map<String, Map<String, List<String>>> serviceKeywords = {
    'balance': {
      'om': [
        'solde orange money',
        'soldes orange money',
        'balance om',
        'solde om',
        'soldes om',
        'compte om',
        'compte orange money',
      ],
      'airtime': [
        'crédits d\'appel',
        'unités appel',
        'unités orange',
        'balance',
        'vérifier mon solde appel',
      ],
      'data': [
        'soldes internet',
        'solde internet',
        'soldes passe',
        'solde passe',
        'solde pass',
        'solde passe',
      ],
      'sms': [
        'soldes sms',
        'solde sms',
        'vérifier solde sms',
        'solde message',
        'solde texto',
        'soldes testo',
        'soldes texto',
        'soldes messages',
      ],
    },
    'credit': {
      'om': [
        'transfert om',
        'argent om',
        'envoyer om',
        'achat crédit orange money',
        'achat crédits orange money',
        'crédit om',
        'crédits om',
        'crédits orange money',
        'unités om',
        'unité om',
        'unités orange money',
        'unité orange money',
        // 'dépot om',
        // 'dépôt om',
        // 'dépots om',
        // 'dépot orange money',
        // 'dépôts orange money'
      ],
      'airtime': [
        // 'recharge', 'crédit', 'ajouter crédit', 'achat crédit'
      ],
    },
    'data': {
      'internet_direct': [
        'forfait internet',
        'acheter pass internet',
        'acheter passe internet',
        'internet direct',
        'passe direct',
      ],
      'internet_om': [
        'forfait internet om',
        'forfait internet orange money',
        'pass internet om',
        'pass internet orange money',
        'passe internet om',
        'passe internet orange money',
        'pass om',
        'pass orange money',
        'passe om',
        'passe orange money',
      ],
    },
    'sms': {
      'airtime': ['sms', 'SMS', 'message', 'texto', 'testo'],
      // 'transfert': ['sms', 'transfert', 'transferer', 'transférer'],
      'swag': ['swag', 'swagg', 'souad', 'soua'],
    },
  };

  // Codes USSD simplifiés pour un seul opérateur
  static final Map<String, Map<String, Map<String, String>>> ussdCodes = {
    'balance': {
      'om': {'aucun_montant': '*144*3#'},
      'airtime': {'aucun_montant': '*124#'},
      'data': {'aucun_montant': '*222*5#'},
      'sms': {'aucun_montant': '*555*3#'},
    },
    'credit': {
      'om': {'aucun_montant': '*144*2*1*1#'},
    },
    'data': {
      'internet_direct': {
        '980': '*222*1*1#',
        '1950': '*222*1*2#',
        '2950': '*222*1*3#',
        '14000': '*222*2#',
      },
      'internet_om': {
        '980': '*144*2*2*1#',
        '1950': '*144*2*2*1#',
        '2950': '*144*2*2*1#',
        '14000': '*144*2*2*2#',
      },
    },
    'sms': {
      'airtime': {'500': '*888*2#', '1500': '*888*1#'},
      'swag': {'400': '*707*3#', '600': '*707*3#', '1100': '*707*3#'},
    },
  };

  static USSDCommand? processCommand(String text) {
    text = text.toLowerCase();

    // Détection du service, type de service et méthode de paiement
    var serviceResult = _findServiceAndType(text);
    String? service = serviceResult?['service'];
    String? serviceType = serviceResult?['type'];
    String? paymentMethod = serviceResult?['paymentMethod'];

    // Détection du montant s'il est requis
    String? amount = _findAmount(text, service);

    if (service != null && serviceType != null && paymentMethod != null) {
      String? code =
          ussdCodes[service]?[serviceType]?[amount ?? 'aucun_montant'];
      if (code != null) {
        return USSDCommand(
          service: service,
          serviceType: serviceType,
          paymentMethod: paymentMethod,
          amount: amount ?? 'aucun_montant',
          code: code,
        );
      }
    }
    return null;
  }

  // Méthode pour détecter le service, le type de service et le mode de paiement
  static Map<String, String>? _findServiceAndType(String text) {
    for (var serviceEntry in serviceKeywords.entries) {
      for (var subServiceEntry in serviceEntry.value.entries) {
        if (subServiceEntry.value.any((keyword) => text.contains(keyword))) {
          // Vérifier la méthode de paiement
          String paymentMethod =
              subServiceEntry.key.contains('om') ? 'om' : 'direct';
          return {
            'service': serviceEntry.key,
            'type': subServiceEntry.key,
            'paymentMethod': paymentMethod,
          };
        }
      }
    }
    return null;
  }

  static String? getCode(String service, String serviceType, String amount) {
    return ussdCodes[service]?[serviceType]?[amount] ??
        ussdCodes[service]?[serviceType]?['aucun_montant'];
  }

  // Extraction du montant pour les services nécessitant un montant
  static String? _findAmount(String text, String? service) {
    if (service == 'balance') return 'aucun_montant';

    final RegExp amountRegex = RegExp(r'\b(\d+)\s*(francs?|f|cfa)?\b');
    final match = amountRegex.firstMatch(text);
    return match?.group(1);
  }
}

// class GuicodeAiHomeScreen extends StatefulWidget {
//   const GuicodeAiHomeScreen({super.key});

//   @override
//   State<GuicodeAiHomeScreen> createState() => _GuicodeAiHomeScreenState();
// }

// class _GuicodeAiHomeScreenState extends State<GuicodeAiHomeScreen> {
//   final SpeechToText _speech = SpeechToText();
//   bool _isListening = false;
//   String _text = '';
//   USSDCommand? _lastCommand;
//   bool _speechInitialized = false;
//   String _errorMessage = ''; // Message d'erreur pour commandes non reconnues

//   @override
//   void initState() {
//     super.initState();
//     _initializeSpeech();
//   }

//   Future<void> _initializeSpeech() async {
//     try {
//       bool available = await _speech.initialize(
//         onError: (error) => log('Erreur de reconnaissance vocale: $error'),
//         onStatus: (status) {
//           log('Status: $status');
//           if (status == 'notListening') {
//             setState(() {
//               _isListening = false;
//             });
//           }
//         },
//       );
//       setState(() {
//         _speechInitialized = available;
//       });
//     } catch (e) {
//       log('Erreur d\'initialisation: $e');
//       setState(() {
//         _speechInitialized = false;
//       });
//     }
//   }

//   Future<void> _startListening() async {
//     if (!_speechInitialized) {
//       await _initializeSpeech();
//       if (!_speechInitialized) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('La reconnaissance vocale n\'est pas disponible'),
//           ),
//         );
//         return;
//       }
//     }

//     if (!_isListening) {
//       try {
//         setState(() {
//           _isListening = true;
//         });

//         await _speech.listen(
//           onResult: (result) {
//             setState(() {
//               _text = result.recognizedWords;
//               if (_text.isNotEmpty) {
//                 _lastCommand = CommandProcessor.processCommand(_text);
//               }
//             });

//             if (_lastCommand != null) {
//               _errorMessage =
//                   ''; // Réinitialiser l'erreur si la commande est reconnue
//               _executeUSSDCode(_lastCommand!);
//             } else if (!_isListening && _text.isNotEmpty) {
//               _errorMessage =
//                   'Commande non reconnue. Voici des suggestions :\n\n${_generateSuggestions(_text, _lastCommand?.amount ?? '1000')}';
//             }
//           },
//           listenFor: const Duration(seconds: 30),
//           pauseFor: const Duration(seconds: 3),
//           localeId: 'fr_FR',
//           cancelOnError: true,
//           partialResults: true,
//           onDevice: true,
//         );
//       } catch (e) {
//         log('Erreur lors de l\'écoute: $e');
//         setState(() {
//           _isListening = false;
//         });
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Erreur: $e')));
//       }
//     } else {
//       setState(() {
//         _isListening = false;
//       });
//       await _speech.stop();
//     }
//   }

//   void _executeUSSDCode(USSDCommand command) {
//     // Implémenter l'exécution du code USSD ici
//     log("Exécution du code USSD : ${command.code}");

//     FlutterPhoneDirectCaller.callNumber(command.code);
//   }

//   // Méthode pour générer des suggestions basées sur la commande non reconnue
//   String _generateSuggestions(String userInput, String montant) {
//     // Extraire des mots-clés à partir de la commande
//     List<String> suggestions = [];

//     // Rechercher les mots-clés dans la commande
//     if (userInput.contains("recharge") || userInput.contains("crédit")) {
//       suggestions.add("Essayer : \"recharge $montant francs\"");
//     }
//     if (userInput.contains("money") || userInput.contains("om")) {
//       suggestions.add("Essayer : \"om 500 orange\"");
//     }
//     if (userInput.contains("internet") || userInput.contains("data")) {
//       suggestions.add(
//         "Essayer : \"pass 9000 francs orange\" ou \"internet 980 francs orange\"",
//       );
//     }
//     if (userInput.contains("sms") || userInput.contains("message")) {
//       suggestions.add(
//         "Essayer : \"sms 500 francs orange\" ou \"message 1500 orange\"",
//       );
//     }

//     // Proposer des suggestions en fonction des montants
//     RegExp amountRegex = RegExp(r'\b(\d+)\s*(francs?|f|cfa)?\b');
//     var match = amountRegex.firstMatch(userInput);
//     if (match != null) {
//       String? amount = match.group(1);
//       suggestions.add(
//         "Essayer : \"recharge $amount orange\" ou \"om $amount mtn\"",
//       );
//     }

//     if (suggestions.isEmpty) {
//       suggestions.add("Désolé, aucune suggestion disponible.");
//     }

//     return suggestions.join("\n");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Guicode AI')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // État du système
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         children: [
//                           Icon(
//                             _isListening ? Icons.mic : Icons.mic_none,
//                             size: 48,
//                             color:
//                                 _speechInitialized
//                                     ? (_isListening ? Colors.red : Colors.blue)
//                                     : Colors.grey,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             _speechInitialized
//                                 ? (_isListening
//                                     ? 'Écoute en cours...'
//                                     : 'Appuyez pour parler')
//                                 : 'Initialisation...',
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 24),

//               // Texte reconnu
//               if (_text.isNotEmpty)
//                 Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Commande reconnue :',
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(_text),
//                       ],
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 16),

//               // Détails de la commande
//               if (_lastCommand != null)
//                 Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Détails de la commande :',
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                         const SizedBox(height: 8),
//                         // Text('Opérateur : ${_lastCommand!.operator}'),
//                         Text('Service : ${_lastCommand!.service}'),
//                         Text('Montant : ${_lastCommand!.amount} GNF'),
//                         Text('Code USSD : ${_lastCommand!.code}'),
//                       ],
//                     ),
//                   ),
//                 ),

//               // Afficher un message d'erreur si la commande n'est pas reconnue
//               if (_errorMessage.isNotEmpty)
//                 Card(
//                   color: Colors.red[100],
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Erreur :',
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(_errorMessage),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _speechInitialized ? _startListening : null,
//         tooltip: _isListening ? 'Arrêter l\'écoute' : 'Commencer l\'écoute',
//         child: Icon(_isListening ? Icons.stop : Icons.mic),
//       ),
//     );
//   }
// }

//!-----------------------------------------------------------------------------

class GeminiUSSDService {
  static const String _apiKey = ' ';
  late final GenerativeModel _model;

  GeminiUSSDService() {
    _model = GenerativeModel(model: 'gemini-1.5-pro-latest', apiKey: _apiKey);
  }

  Future<String> transcribeAudio(String audioPath) async {
    final file = File(audioPath);
    final bytes = await file.readAsBytes();
    final audioPart = DataPart('audio/mp3', bytes);

    try {
      final prompt =
          "Transcris précisément ce message audio en texte. Ne fais aucune interprétation, juste une transcription exacte:";
      final content = Content.multi([TextPart(prompt), audioPart]);

      final response = await _model.generateContent([content]);
      return response.text ?? '';
    } catch (e) {
      log('Erreur de transcription Gemini: $e');
      throw Exception('Erreur de transcription Gemini: $e');
    }
  }

  Future<USSDCommand?> interpretCommand(String text) async {
    final prompt = '''
    Analyse cette demande de service mobile et retourne un JSON strictement formaté comme ceci:
    {
      "service": "balance|credit|data|sms",
      "serviceType": "om|airtime|internet_direct|internet_om",
      "amount": "montant_numérique|aucun_montant",
      "paymentMethod": "om|direct"
    }

    Exemples:
    - "Je veux vérifier mon solde Orange Money" → {"service": "balance", "serviceType": "om", "amount": "aucun_montant", "paymentMethod": "om"}
    - "Acheter un forfait internet de 1000 francs" → {"service": "data", "serviceType": "internet_direct", "amount": "1000", "paymentMethod": "direct"}

    Demande à analyser: "$text"
    ''';

    try {
      final response = await _model.generateContent(
        [Content.text(prompt)],
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

      final jsonString =
          response.text
              ?.replaceFirst('```json', '')
              .replaceAll('```', '')
              .trim() ??
          '';
      final jsonData = jsonDecode(jsonString);
      log('JSON data: $jsonData');
      return USSDCommand(
        service: jsonData['service'],
        serviceType: jsonData['serviceType'],
        paymentMethod: jsonData['paymentMethod'],
        amount: jsonData['amount'],
        code:
            CommandProcessor.getCode(
              jsonData['service'],
              jsonData['serviceType'],
              jsonData['amount'],
            )!,
      );
    } catch (e) {
      log('Erreur d\'interprétation Gemini: $e');
      return null;
    }
  }
}

class GuicodeAiHomeScreen2 extends StatefulWidget {
  const GuicodeAiHomeScreen2({super.key});

  @override
  State<GuicodeAiHomeScreen2> createState() => _GuicodeAiHomeScreen2State();
}

class _GuicodeAiHomeScreen2State extends State<GuicodeAiHomeScreen2>
    with TickerProviderStateMixin {
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isOnline = false;

  bool _isProcessing = false;
  String _errorMessage = '';
  String _recognizedText = '';
  USSDCommand? _lastCommand;
  String _currentMode = '';
  double _recordingProgress = 0.0;
  Timer? _progressTimer;

  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  final _hybridService = HybridSpeechService();

  @override
  void initState() {
    super.initState();
    _hybridService.initialize();
    _initConnectivity();
    _setupConnectivityListener();
    _initAnimations();
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _waveController, curve: Curves.easeInOut),
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _connectivitySubscription?.cancel();
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  void _executeUSSDCode(USSDCommand command) {
    log("Exécution du code USSD : ${command.code}");
    setState(() => _lastCommand = command);
    FlutterPhoneDirectCaller.callNumber(command.code);
  }

  Future<void> _initConnectivity() async {
    _isOnline = await NetworkService.isOnline;
    setState(() {
      _currentMode =
          _isOnline
              ? 'Mode en ligne - Traitement avancé'
              : 'Mode hors ligne - Reconnaissance basique';
    });
  }

  void _setupConnectivityListener() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) async {
      final newStatus = await NetworkService.isOnline;
      if (newStatus != _isOnline) {
        setState(() {
          _isOnline = newStatus;
          _currentMode =
              _isOnline
                  ? 'Mode en ligne - Traitement avancé'
                  : 'Mode hors ligne - Reconnaissance basique';
        });
      }
    });
  }

  void _startProgressTimer() {
    const totalSeconds = 5;
    var elapsed = 0;

    _progressTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      elapsed++;
      setState(() {
        _recordingProgress = elapsed / totalSeconds;
      });

      if (elapsed >= totalSeconds) {
        timer.cancel();
      }
    });
  }

  Future<void> _startListening() async {
    setState(() {
      _isProcessing = true;
      _currentMode = 'Détection connexion...';
      _errorMessage = '';
      _recognizedText = '';
      _recordingProgress = 0.0;
    });

    _waveController.repeat();
    _startProgressTimer();

    setState(() {
      _currentMode =
          _isOnline
              ? 'Mode en ligne - Traitement avancé'
              : 'Mode hors ligne - Reconnaissance basique';
    });

    try {
      final command = await _hybridService.processVoiceCommand();

      if (command != null) {
        _executeUSSDCode(command);
      } else {
        setState(
          () =>
              _errorMessage = 'Commande non reconnue.\n Essayez de reformuler.',
        );
      }
    } catch (e) {
      setState(() => _errorMessage = 'Erreur: ${e.toString()}');
    } finally {
      _progressTimer?.cancel();
      _waveController.stop();
      setState(() => _isProcessing = false);
    }
  }

  Widget _buildVoiceVisualizer() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors:
              _isProcessing
                  ? [
                    Colors.blue.withOpacity(0.3),
                    Colors.purple.withOpacity(0.3),
                    Colors.pink.withOpacity(0.3),
                  ]
                  : [
                    Colors.grey.withOpacity(0.1),
                    Colors.grey.withOpacity(0.2),
                  ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color:
                _isProcessing
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Cercles d'onde animés pendant l'enregistrement
          if (_isProcessing)
            ...List.generate(3, (index) {
              return AnimatedBuilder(
                animation: _waveAnimation,
                builder: (context, child) {
                  final scale =
                      1.0 + (_waveAnimation.value * (index + 1) * 0.3);
                  final opacity = (1.0 - _waveAnimation.value) * 0.6;
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.blue.withOpacity(opacity),
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),

          // Cercle principal avec icône
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _isProcessing ? 1.0 : _pulseAnimation.value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors:
                          _isProcessing
                              ? [
                                const Color(0xFF667EEA),
                                const Color(0xFF764BA2),
                              ]
                              : [
                                const Color(0xFF4facfe),
                                const Color(0xFF00f2fe),
                              ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color:
                            _isProcessing
                                ? Colors.purple.withOpacity(0.4)
                                : Colors.blue.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child:
                      _isProcessing
                          ? Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: _recordingProgress,
                                strokeWidth: 4,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                              const Icon(
                                Icons.graphic_eq,
                                size: 40,
                                color: Colors.white,
                              ),
                            ],
                          )
                          : const Icon(
                            Icons.mic,
                            size: 50,
                            color: Colors.white,
                          ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isOnline ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isOnline ? Icons.cloud_done : Icons.cloud_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'État du système',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isProcessing ? _currentMode : 'Prêt à écouter',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildVoiceVisualizer(),
          const SizedBox(height: 24),
          if (_isProcessing)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'En écoute...',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResultsCard() {
    if (_recognizedText.isEmpty &&
        _lastCommand == null &&
        _errorMessage.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.insights, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 8),
              Text(
                'Résultats',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_recognizedText.isNotEmpty) ...[
            _buildResultItem(
              icon: Icons.record_voice_over,
              title: 'Texte reconnu',
              content: _recognizedText,
              color: Colors.green,
            ),
            const SizedBox(height: 12),
          ],

          if (_lastCommand != null) ...[
            _buildCommandResult(_lastCommand!),
            const SizedBox(height: 12),
          ],

          if (_errorMessage.isNotEmpty) _buildErrorResult(_errorMessage),
        ],
      ),
    );
  }

  Widget _buildResultItem({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, color: color),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommandResult(USSDCommand command) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.withOpacity(0.1),
            Colors.purple.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: Colors.blue, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.blue.shade600, size: 20),
              const SizedBox(width: 8),
              Text(
                'Commande exécutée',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  'Service',
                  command.service,
                  Icons.sim_card,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildInfoChip(
                  'Type',
                  command.serviceType,
                  Icons.category,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildInfoChip(
                  'Montant',
                  command.amount,
                  Icons.attach_money,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: _buildInfoChip('Code', command.code, Icons.code)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorResult(String error) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: Colors.red, width: 4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Erreur',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  error,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'GuiCode AI',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildResultsCard(),
            const SizedBox(height: 100), // Espace pour le FAB
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors:
                _isProcessing
                    ? [Colors.red.shade400, Colors.red.shade600]
                    : [const Color(0xFF667EEA), const Color(0xFF764BA2)],
          ),
          boxShadow: [
            BoxShadow(
              color: (_isProcessing ? Colors.red : Colors.blue).withOpacity(
                0.3,
              ),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          onPressed: _isProcessing ? null : _startListening,
          backgroundColor: Colors.transparent,
          elevation: 0,
          icon: Icon(
            _isProcessing ? Icons.stop : Icons.mic,
            color: Colors.white,
          ),
          label: Text(
            _isProcessing ? 'Arrêter' : 'Parler',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class NetworkService {
  static Future<bool> get isOnline async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();

      // Vérification plus robuste de la connectivité
      if (connectivityResult.isEmpty) return false;

      // Cas où on a une connexion active
      if (connectivityResult.contains(ConnectivityResult.mobile)) return true;
      if (connectivityResult.contains(ConnectivityResult.wifi)) return true;
      if (connectivityResult.contains(ConnectivityResult.ethernet)) return true;

      // Pour les autres types de connexion (VPN, etc.)
      // On peut vérifier si on a vraiment accès à internet
      return await _checkRealInternetConnection();
    } catch (e) {
      print('Erreur de détection de connexion: $e');
      return false;
    }
  }

  static Future<bool> _checkRealInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}

class HybridSpeechService {
  final _speech = SpeechToText();
  final _record = AudioRecorder();
  final _geminiService = GeminiUSSDService(); // Votre service Gemini existant
  bool _isInitialized = false;

  Future<void> initialize() async {
    _isInitialized = await _speech.initialize();
  }

  Future<USSDCommand?> processVoiceCommand() async {
    try {
      final isOnline = await NetworkService.isOnline;

      if (isOnline) {
        // Mode Gemini avec traitement avancé
        // return await _processWithGemini();
        return await _processLocally();
      } else {
        // Mode local basique
        return await _processLocally();
      }
    } catch (e) {
      log('Erreur traitement vocal: $e');
      return null;
    }
  }

  Future<USSDCommand?> _processWithGemini() async {
    final tempDir = await getTemporaryDirectory();
    final audioPath = '${tempDir.path}/recording.mp3';

    await _record.start(
      RecordConfig(encoder: AudioEncoder.aacLc),
      path: audioPath,
    );

    await Future.delayed(const Duration(seconds: 5)); // Enregistrement 5s
    final path = await _record.stop();

    if (path == null) return null;

    final transcription = await _geminiService.transcribeAudio(path);
    return await _geminiService.interpretCommand(transcription);
  }

  Future<USSDCommand?> _processLocally() async {
    if (!_isInitialized) await initialize();

    Completer<USSDCommand?> completer = Completer();

    _speech.listen(
      onResult: (result) {
        if (result.finalResult && result.recognizedWords.isNotEmpty) {
          final command = CommandProcessor.processCommand(
            result.recognizedWords,
          );
          completer.complete(command);
        }
      },
      listenFor: const Duration(seconds: 10),
      localeId: 'fr_FR',
      cancelOnError: true,
    );

    return completer.future;
  }
}
