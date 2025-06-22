import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:guicooode/options/apropos.dart';
import 'package:guicooode/options/qui_suis_je.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Options extends StatefulWidget {
  const Options({super.key});

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        title: Text(
          'Options',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 18,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header avec icône de l'app
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            theme.primaryColor,
                            theme.primaryColor.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: theme.primaryColor.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'GuiCode',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gérez vos préférences',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            isDark
                                ? Colors.white.withOpacity(0.7)
                                : Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Options cards
              _buildOptionCard(
                context: context,
                icon: Icons.info_outline,
                title: 'À Propos',
                subtitle: 'Informations sur l\'application',
                onTap: () => _navigateToPage(context, const APropos()),
                delay: 100,
              ),

              const SizedBox(height: 12),

              _buildOptionCard(
                context: context,
                icon: Icons.share_outlined,
                title: 'Partager l\'application',
                subtitle: 'Recommandez à vos amis',
                onTap: () => _shareApp(),
                delay: 200,
              ),

              const SizedBox(height: 12),

              _buildOptionCard(
                context: context,
                icon: Icons.star_outline,
                title: 'Noter l\'application',
                subtitle: 'Votre avis nous aide à améliorer',
                onTap: () => _showRatingDialog(context),
                delay: 300,
              ),

              const SizedBox(height: 12),

              _buildOptionCard(
                context: context,
                icon: Icons.person_outline,
                title: 'Qui suis-je ?',
                subtitle: 'À propos du développeur',
                onTap: () => _navigateToPage(context, const Qui_Suis_Je()),
                delay: 400,
              ),

              const SizedBox(height: 40),

              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Divider(
                      color:
                          isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.black12,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color:
                            isDark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black38,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '© 2024 GuiCode. Tous droits réservés.',
                      style: TextStyle(
                        color:
                            isDark
                                ? Colors.white.withOpacity(0.5)
                                : Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required int delay,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.black.withAlpha(77) // 0.3 * 255 ≈ 77
                      : Colors.black.withAlpha(20), // 0.08 * 255 ≈ 20
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              onTap();
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: theme.primaryColor, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                isDark
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color:
                          isDark
                              ? Colors.white.withOpacity(0.7)
                              : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _shareApp() async {
    HapticFeedback.mediumImpact();

    // Afficher un indicateur de chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pop(context);
    await SharePlus.instance.share(
      ShareParams(
        text:
            'Téléchargez GuiCode et gagnez du temps en trouvant instantanément les codes Orange, MTN et Celcom dont vous avez besoin !'
            'https://play.google.com/store/apps/details?id=com.guicode',
      ),
    );
  }

  void _showRatingDialog(BuildContext context) {
    HapticFeedback.mediumImpact();

    showDialog(
      barrierDismissible: true,
      context: context,
      builder:
          (BuildContext context) => RatingDialog(
            initialRating: 4.0,
            title: const Text(
              'GuiCode',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            message: const Text(
              "Appuyez sur l'étoile pour définir votre note.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            submitButtonText: 'Noter',
            commentHint: 'Ajoutez votre avis ici',
            onCancelled: () => log('cancelled'),
            onSubmitted: (response) async {
              log('rating: ${response.rating}, comment: ${response.comment}');

              if (response.rating < 3.0) {
                // Pour les notes faibles, rediriger vers un formulaire de feedback
                _showFeedbackDialog(context);
              } else {
                final inAppReview = InAppReview.instance;

                if (await inAppReview.isAvailable()) {
                  log('request actual review from store');
                  inAppReview.requestReview();
                } else {
                  log('open actual store listing');
                  inAppReview.openStoreListing(
                    appStoreId: '5172574618966502885',
                    microsoftStoreId: '<your microsoft store id>',
                  );
                }
              }
            },
          ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Merci pour votre retour !'),
            content: const Text(
              'Nous sommes désolés que l\'application ne réponde pas à vos attentes. '
              'Voulez-vous nous envoyer vos suggestions par email ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Plus tard'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _sendFeedbackEmail();
                },
                child: const Text('Envoyer un email'),
              ),
            ],
          ),
    );
  }

  void _sendFeedbackEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'andersongoumou10@gmail.com',
      query:
          'subject=Feedback GuiCode App&body=Bonjour,%0A%0AJe souhaite partager mon retour sur l\'application GuiCode:%0A%0A',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }
}
