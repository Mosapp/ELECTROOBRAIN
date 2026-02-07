import 'package:flutter/material.dart';
import 'level_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

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
                child: const Text(
                  "Bienvenue !",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1CB0F6),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "Choisissez votre langue",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 0)
                  ],
                ),
              ),

              const SizedBox(height: 50),

              _buildLanguageButton(
                context: context,
                flag: "🇫🇷",
                text: "Français",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LevelScreen(languageCode: 'fr')),
                  );
                },
              ),

              const SizedBox(height: 30),

              _buildLanguageButton(
                context: context,
                flag: "🇬🇧",
                text: "English",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LevelScreen(languageCode: 'en')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required String flag,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 8), blurRadius: 0),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: const TextStyle(fontSize: 40)),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}