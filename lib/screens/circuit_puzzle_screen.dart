import 'package:flutter/material.dart';

class CircuitPuzzleScreen extends StatefulWidget {
  const CircuitPuzzleScreen({super.key});

  @override
  State<CircuitPuzzleScreen> createState() => _CircuitPuzzleState();
}

class _CircuitPuzzleState extends State<CircuitPuzzleScreen> {
  // Grille 5x5
  final List<String> _gridType = List.filled(25, 'empty');
  final List<int> _gridRotation = List.filled(25, 0);

  // Bornes
  final int _startIndex = 2;
  final int _endIndex = 22;

  @override
  void initState() {
    super.initState();
    _initLevel();
  }

  void _initLevel() {
    _gridType[_startIndex] = 'start';
    _gridType[_endIndex] = 'end';

    // Chemin vertical simple (Haut vers Bas)
    _gridType[7] = 'vertical';
    _gridType[12] = 'vertical';
    _gridType[17] = 'vertical';

    // On mélange les rotations
    _gridRotation[7] = 90;
    _gridRotation[12] = 180;
    _gridRotation[17] = 270;
  }

  void _rotatePipe(int index) {
    if (_gridType[index] == 'empty') return;
    if (_gridType[index] == 'start') return;
    if (_gridType[index] == 'end') return;

    setState(() {
      _gridRotation[index] = (_gridRotation[index] + 90) % 360;
    });

    _checkWinCondition();
  }

  void _checkWinCondition() {
    if (_gridRotation[7] == 0 && _gridRotation[12] == 0 && _gridRotation[17] == 0) {
      _showWinDialog();
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 3),
        ),
        backgroundColor: Colors.yellow,
        title: const Text("Circuit Fermé !", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black)),
        content: const Text("Le courant peut passer ! Continuité OK.", style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Continuer", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black))
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: const Text("Circuit Puzzle", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "Cliquez sur les câbles pour les connecter à la masse",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                // COULEUR BEIGE PLAQUETTE CORRIGÉE
                color: const Color(0xFFF5DEB3),
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: const Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1,
                ),
                itemCount: 25,
                itemBuilder: (context, index) {
                  return _buildBreadboardCell(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadboardCell(int index) {
    return GestureDetector(
      onTap: () => _rotatePipe(index),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5DEB3),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        ),
        child: _getIconForCell(index),
      ),
    );
  }

  Widget _getIconForCell(int index) {
    String type = _gridType[index];
    int rotation = _gridRotation[index];

    if (type == 'empty') {
      return const Icon(Icons.circle, size: 10, color: Colors.black);
    }
    if (type == 'start') {
      return const Icon(Icons.battery_charging_full, size: 30, color: Colors.blue);
    }
    if (type == 'end') {
      return const Icon(Icons.lightbulb, size: 30, color: Colors.yellow);
    }

    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: 30,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: const Center(
          child: SizedBox(
            width: 2,
            height: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
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
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
    );
  }
}