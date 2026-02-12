import 'dart:math';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGameScreen> {
  // --- DONNÉES DU JEU ---
  final List<Map<String, dynamic>> _gameItems = const [
    {'id': 1, 'name': 'Résistance', 'icon': Icons.memory, 'color': Colors.blue},
    {'id': 1, 'name': 'Resistor', 'icon': Icons.memory, 'color': Colors.blue},
    {'id': 2, 'name': 'Condensateur', 'icon': Icons.battery_charging_full, 'color': Colors.green},
    {'id': 2, 'name': 'Capacitor', 'icon': Icons.battery_charging_full, 'color': Colors.green},
    {'id': 3, 'name': 'Diode', 'icon': Icons.electric_bolt, 'color': Colors.red},
    {'id': 3, 'name': 'Diode', 'icon': Icons.electric_bolt, 'color': Colors.red},
    {'id': 4, 'name': 'Transistor', 'icon': Icons.settings_input_component, 'color': Colors.orange},
    {'id': 4, 'name': 'Transistor', 'icon': Icons.settings_input_component, 'color': Colors.orange},
    {'id': 5, 'name': 'Batterie', 'icon': Icons.battery_std, 'color': Colors.grey},
    {'id': 5, 'name': 'Battery', 'icon': Icons.battery_std, 'color': Colors.grey},
    {'id': 6, 'name': 'Masse', 'icon': Icons.remove_circle_outline, 'color': Colors.black},
    {'id': 6, 'name': 'Ground', 'icon': Icons.remove_circle_outline, 'color': Colors.black},
    {'id': 7, 'name': 'Led', 'icon': Icons.lightbulb, 'color': Colors.yellow},
    {'id': 7, 'name': 'LED', 'icon': Icons.lightbulb, 'color': Colors.yellow},
    {'id': 8, 'name': 'Interrupteur', 'icon': Icons.toggle_on, 'color': Colors.purple},
    {'id': 8, 'name': 'Switch', 'icon': Icons.toggle_on, 'color': Colors.purple},
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
    _cards = List.from(_gameItems);
    _cards.shuffle(Random());
    _flippedCards = [];
    _matchedCards = [];
    _moves = 0;
    _isLocked = false;
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
    setState(() => _isLocked = true);
    setState(() => _moves++);

    int index1 = _flippedCards[0];
    int index2 = _flippedCards[1];

    if (_cards[index1]['id'] == _cards[index2]['id']) {
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

  void _showVictoryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.black, width: 3),
          ),
          backgroundColor: Colors.yellow,
          title: const Text(
            "Bravo !",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          content: Text(
            "Tu as retrouvé tous les composants\nen $_moves coups !",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartGame();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Text(
                "Rejouer",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: const Text("Memory", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                "Coups: $_moves",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          bool isFlipped = _flippedCards.contains(index) || _matchedCards.contains(index);
          bool isMatched = _matchedCards.contains(index);
          return _buildGameCard(index, isFlipped, isMatched);
        },
      ),
    );
  }

  Widget _buildGameCard(int index, bool isFlipped, bool isMatched) {
    bool showText = index % 2 != 0;
    Widget cardContent;

    if (isFlipped || isMatched) {
      if (showText) {
        cardContent = Text(
          _cards[index]['name'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: _cards[index]['color'],
          ),
        );
      } else {
        cardContent = Icon(
          _cards[index]['icon'],
          color: _cards[index]['color'],
          size: 40,
        );
      }
    } else {
      cardContent = const Icon(
        Icons.help_outline,
        size: 40,
        color: Color(0xFF1CB0F6),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: isFlipped || isMatched ? Colors.white : Colors.yellow,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 3), blurRadius: 0)
        ],
      ),
      child: Center(child: cardContent),
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