import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_screen.dart';

class LevelScreen extends StatelessWidget {
  final String languageCode;

  const LevelScreen({super.key, required this.languageCode});

  Future<void> _saveLevelAndNavigate(BuildContext context, String level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_level', level);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DashboardScreen(
          languageCode: languageCode,
          userLevel: level,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(0, 6), blurRadius: 0),
                  ],
                ),
                child: Text(
                  languageCode == 'fr' ? "Votre niveau ?" : "Your level?",
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1CB0F6),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              _buildLevelButton(
                context: context,
                title: languageCode == 'fr' ? "Niveau BT" : "BT Level",
                subtitle: languageCode == 'fr' ? "Débutant / Fondamentaux" : "Beginner / Basics",
                levelCode: "BT",
                color: Colors.lightBlue,
              ),

              const SizedBox(height: 30),

              _buildLevelButton(
                context: context,
                title: languageCode == 'fr' ? "Niveau BTS" : "BTS Level",
                subtitle: languageCode == 'fr' ? "Avancé / Architecture" : "Advanced / Architecture",
                levelCode: "BTS",
                color: Colors.deepOrange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String levelCode,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => _saveLevelAndNavigate(context, levelCode),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 8), blurRadius: 0),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}