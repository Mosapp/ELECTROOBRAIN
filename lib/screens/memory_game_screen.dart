import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGameScreen> {
  // --- DONNÉES DU JEU (UNIQUEMENT DES IMAGES) ---
  final List<Map<String, dynamic>> _gameItems = const [
    // On met la même image deux fois pour créer la paire
    {'id': 1, 'image': 'assets/images/games/resistance.png'},
    {'id': 1, 'image': 'assets/images/games/resistance.png'},

    {'id': 2, 'image': 'assets/images/games/condensateur.png'},
    {'id': 2, 'image': 'assets/images/games/condensateur.png'},

    {'id': 3, 'image': 'assets/images/games/diode.png'},
    {'id': 3, 'image': 'assets/images/games/diode.png'},

    {'id': 4, 'image': 'assets/images/games/transistor.png'},
    {'id': 4, 'image': 'assets/images/games/transistor.png'},

    {'id': 5, 'image': 'assets/images/games/batterie.png'},
    {'id': 5, 'image': 'assets/images/games/batterie.png'},

    {'id': 6, 'image': 'assets/images/games/masse.png'},
    {'id': 6, 'image': 'assets/images/games/masse.png'},

    {'id': 7, 'image': 'assets/images/games/led.png'},
    {'id': 7, 'image': 'assets/images/games/led.png'},

    {'id': 8, 'image': 'assets/images/games/fusible.png'},
    {'id': 8, 'image': 'assets/images/games/fusible.png'},
  ];

  late List<Map<String, dynamic>> _cards;
  List<int> _flippedCards = [];
  List<int> _matchedCards = [];
  bool _isLocked = false;
  int _moves = 0;

  @override
  void initState() {
    super.initState();
    _restartGame();
  }

  void _restartGame() {
    setState(() {
      _cards = List.from(_gameItems);
      _cards.shuffle(Random());
      _flippedCards = [];
      _matchedCards = [];
      _moves = 0;
      _isLocked = false;
    });
  }

  void _onCardTap(int index) {
    if (_isLocked) return;
    if (_flippedCards.contains(index) || _matchedCards.contains(index)) return;

    setState(() {
      _flippedCards.add(index);
    });

    if (_flippedCards.length == 2) {
      _checkForMatch();
    }
  }

  void _checkForMatch() async {
    setState(() {
      _isLocked = true;
      _moves++;
    });

    int index1 = _flippedCards[0];
    int index2 = _flippedCards[1];

    if (_cards[index1]['id'] == _cards[index2]['id']) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _matchedCards.add(index1);
        _matchedCards.add(index2);
        _flippedCards.clear();
        _isLocked = false;
      });

      if (_matchedCards.length == _cards.length) {
        _showVictoryDialog();
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _flippedCards.clear();
        _isLocked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: const Text("Memory Élec", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text("Coups: $_moves", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                return _buildGameCard(index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _restartGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.black, width: 2),
                  ),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                child: const Text("Réinitialiser", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGameCard(int index) {
    bool isFlipped = _flippedCards.contains(index) || _matchedCards.contains(index);

    return GestureDetector(
      onTap: () => _onCardTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isFlipped ? Colors.white : Colors.yellow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2.5),
          boxShadow: [
            if (!isFlipped) const BoxShadow(color: Colors.black, offset: Offset(0, 4))
          ],
        ),
        child: Center(
          child: isFlipped
              ? _getCardContent(index)
              : const Icon(Icons.help_outline, size: 35, color: Color(0xFF1CB0F6)),
        ),
      ),
    );
  }

  // --- SIMPLIFICATION : TOUJOURS UNE IMAGE ---
  Widget _getCardContent(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        _cards[index]['image'], // On affiche l'image liée à la carte
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.warning, color: Colors.red),
      ),
    );
  }

  void _showVictoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        backgroundColor: Colors.yellow,
        title: const Text("Bravo !", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Colors.black)),
        content: Text("Tu as terminé en $_moves coups.", style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                _restartGame();
              },
              child: const Text("Rejouer", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black))
          )
        ],
      ),
    );
  }
}