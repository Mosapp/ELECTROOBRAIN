import 'package:flutter/material.dart';
import 'memory_game_screen.dart';

class MiniGamesScreen extends StatelessWidget {
  const MiniGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: const Text(
          "Mini-Jeux",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 1, // Une seule colonne pour l'instant
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2.5, // Rectangles horizontaux
          children: [
            // --- JEU 1 : MÉMOIRE ---
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const MemoryGameScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 3),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 8),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: const Icon(Icons.games, size: 40, color: Colors.black),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        "Le Composant Mystery\n(Jeu de Mémoire)",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // --- ESPACE POUR AJOUTER D'AUTRES JEUX PLUS TARD ---
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
        child: const Icon(Icons.arrow_back, color: Color(0xFF1CB0F6)),
      ),
    );
  }
}