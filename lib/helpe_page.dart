import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int activeCategory = 0;

  final List<Map<String, dynamic>> categories = [
    {
      'id': 'balance',
      'title': 'Vérifier Soldes',
      'icon': Icons.account_balance_wallet,
      'gradient': [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
      'examples': [
        {'text': 'Solde Orange Money', 'command': '*144*3#'},
        {'text': 'Solde crédit', 'command': '*124#'},
        {'text': 'Solde internet', 'command': '*222*5#'},
        {'text': 'Solde SMS', 'command': '*555*3#'},
      ],
    },
    {
      'id': 'credit',
      'title': 'Acheter Crédit',
      'icon': Icons.add_card,
      'gradient': [Color(0xFF66BB6A), Color(0xFF4CAF50)],
      'examples': [
        {'text': 'Crédit Orange Money', 'command': '*144*2*1*1#'},
        {'text': 'Transfert OM', 'command': '*144*2*1*1#'},
        {'text': 'Unités OM', 'command': '*144*2*1*1#'},
      ],
    },
    {
      'id': 'data',
      'title': 'Forfaits Internet',
      'icon': Icons.wifi,
      'gradient': [Color(0xFFAB47BC), Color(0xFF9C27B0)],
      'examples': [
        {'text': 'Pass 980 GNF', 'command': '*222*1*1#'},
        {'text': 'Pass 1950 GNF', 'command': '*222*1*2#'},
        {'text': 'Pass 2950 GNF', 'command': '*222*1*3#'},
        {'text': 'Pass 14000 GNF', 'command': '*222*2#'},
      ],
    },
    {
      'id': 'sms',
      'title': 'Services SMS',
      'icon': Icons.message,
      'gradient': [Color(0xFFFF7043), Color(0xFFFF5722)],
      'examples': [
        {'text': 'Envoyer SMS', 'command': 'SMS'},
        {'text': 'Service Swag', 'command': 'Swag'},
        {'text': 'Texto', 'command': 'Message'},
      ],
    },
  ];

  final List<String> tips = [
    'Parlez clairement et distinctement',
    'Attendez la tonalité avant de parler',
    'Utilisez des mots simples comme dans les exemples',
    'Répétez si l\'IA n\'a pas compris',
  ];

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
            const SizedBox(width: 12),
            const Text(
              'Guide d\'utilisation',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey.shade700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildIntroCard(),
            const SizedBox(height: 20),
            _buildCategoryTabs(),
            const SizedBox(height: 20),
            _buildExamplesCard(),
            const SizedBox(height: 20),
            _buildTipsCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Comment utiliser GuiCode AI',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Appuyez sur le microphone et énoncez votre demande. L\'IA composera automatiquement le code USSD approprié.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isActive = index == activeCategory;
          final category = categories[index];

          return GestureDetector(
            onTap: () {
              setState(() {
                activeCategory = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient:
                    isActive
                        ? LinearGradient(colors: category['gradient'])
                        : null,
                color: isActive ? null : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border:
                    isActive ? null : Border.all(color: Colors.grey.shade300),
                boxShadow:
                    isActive
                        ? [
                          BoxShadow(
                            color: category['gradient'][0].withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                        : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    category['icon'],
                    color: isActive ? Colors.white : Colors.grey.shade600,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category['title'],
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey.shade600,
                      fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExamplesCard() {
    final currentCategory = categories[activeCategory];

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: currentCategory['gradient']),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(currentCategory['icon'], color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  currentCategory['title'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children:
                  currentCategory['examples']
                      .map<Widget>((example) => _buildExampleItem(example))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleItem(Map<String, String> example) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: categories[activeCategory]['gradient'][0],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dites: "${example['text']}"',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Code: ${example['command']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.amber.shade700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Conseils d\'utilisation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...tips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade600,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
