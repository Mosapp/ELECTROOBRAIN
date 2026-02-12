import 'package:flutter/material.dart';
import 'lessons_screen.dart'; // Écran des matières
import 'mini_games_screen.dart'; // Écran des jeux (NOUVEAU)

class DashboardScreen extends StatelessWidget {
  final String languageCode;
  final String userLevel;

  const DashboardScreen({super.key, required this.languageCode, required this.userLevel});

  // --- TRADUCTIONS ---
  static const Map<String, Map<String, String>> _translations = {
    'fr': {
      'appBar': 'Tableau de bord',
      'lessons': 'Leçons',
      'quiz': 'Quiz',
      'games': 'Mini-Jeux',
      'videos': 'Vidéos',
      'challenge': 'Défi du Jour',
      'opening': 'Ouverture de : ',
    },
    'en': {
      'appBar': 'Dashboard',
      'lessons': 'Lessons',
      'quiz': 'Quiz',
      'games': 'Mini-Games',
      'videos': 'Videos',
      'challenge': 'Daily Challenge',
      'opening': 'Opening: ',
    },
  };

  String _getText(String key) {
    return _translations[languageCode]?[key] ?? _translations['fr']![key]!;
  }

  // --- LISTE DES MODULES ---
  List<Map<String, dynamic>> _getModules() {
    return [
      {
        'title': _getText('lessons'),
        'icon': Icons.menu_book,
        'color': Colors.blue,
        'bg': Colors.white,
      },
      {
        'title': _getText('quiz'),
        'icon': Icons.quiz,
        'color': Colors.green,
        'bg': Colors.white,
      },
      {
        'title': _getText('games'),
        'icon': Icons.sports_esports,
        'color': Colors.purple,
        'bg': Colors.white,
      },
      {
        'title': _getText('videos'),
        'icon': Icons.play_circle_outline,
        'color': Colors.red,
        'bg': Colors.white,
      },
      {
        'title': _getText('challenge'),
        'icon': Icons.flag,
        'color': Colors.orange,
        'bg': Colors.white,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final modules = _getModules();

    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: Text(
          _getText('appBar'),
          style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemCount: modules.length,
          itemBuilder: (context, index) {
            final module = modules[index];
            return _buildModuleCard(context, module);
          },
        ),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, Map<String, dynamic> module) {
    return GestureDetector(
      onTap: () {
        String title = module['title'];

        // LOGIQUE DE NAVIGATION
        if (title.contains('Leçons') || title.contains('Lessons')) {
          // On va vers l'écran des matières avec la langue et le niveau
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LessonsScreen(
                languageCode: languageCode,
                userLevel: userLevel,
              ),
            ),
          );
        } else if (title.contains('Jeux') || title.contains('Games')) {
          // On va vers l'écran des jeux
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MiniGamesScreen(),
            ),
          );
        } else {
          // Pour les autres (Quiz, Vidéos...), on garde le message temporaire
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${_getText('opening')} $title"),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: module['bg'],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: module['color'].withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                module['icon'],
                size: 50,
                color: module['color'],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              module['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 2), blurRadius: 0)
          ],
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Color(0xFF1CB0F6),
        ),
      ),
    );
  }
}