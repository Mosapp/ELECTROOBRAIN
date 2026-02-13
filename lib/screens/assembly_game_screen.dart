import 'package:flutter/material.dart';

class AssemblyGameScreen extends StatefulWidget {
  const AssemblyGameScreen({super.key});

  @override
  State<AssemblyGameScreen> createState() => _AssemblyGameState();
}

class _AssemblyGameState extends State<AssemblyGameScreen> {
  // Score
  int _score = 0;

  // Liste des composants à trier
  final List<Map<String, String>> _items = [
    {'name': 'resistance', 'type': 'resistance'},
    {'name': 'condensateur', 'type': 'condensateur'},
    {'name': 'diode', 'type': 'diode'},
    {'name': 'resistance', 'type': 'resistance'},
    {'name': 'condensateur', 'type': 'condensateur'},
    {'name': 'diode', 'type': 'diode'},
    {'name': 'resistance', 'type': 'resistance'},
    {'name': 'condensateur', 'type': 'condensateur'},
    {'name': 'diode', 'type': 'diode'},
  ];

  // Messages de feedback
  String _feedbackMessage = "Trie les composants !";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: const Text("Tri Composants", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text("Score: $_score", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // --- LES 3 BOÎTES CIBLES ---
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTargetBin('resistance', Colors.red),
                _buildTargetBin('condensateur', Colors.green),
                _buildTargetBin('diode', Colors.blue),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // MESSAGE
          Text(
            _feedbackMessage,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),

          const SizedBox(height: 10),

          // --- LISTE DES COMPOSANTS À TRIER ---
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return _buildDraggableItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- CIBLE (Où on pose le composant) ---
  Widget _buildTargetBin(String type, Color color) {
    return DragTarget<String>(
      // --- CORRECTION ICI : onAccept au lieu de onAcceptWithDetails ---
      onAccept: (String data) {
        if (data == type) {
          // BON TRI
          setState(() {
            _score += 10;
            _feedbackMessage = "Bravo ! +10 points";
          });
        } else {
          // MAUVAIS TRI
          setState(() {
            _feedbackMessage = "Non, ça va ailleurs !";
          });
        }
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: candidateData != null ? Colors.yellow : Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(0, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                type == 'resistance' ? Icons.memory : type == 'condensateur' ? Icons.battery_charging_full : Icons.electric_bolt,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 5),
              Text(
                type.toUpperCase(),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- ITEM QU'ON ATTRAPE (DRAGGABLE) ---
  Widget _buildDraggableItem(int index) {
    final item = _items[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Draggable<String>(
        // Les données qu'on transporte
        data: item['type']!,
        feedback: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Icon(
            item['type'] == 'resistance' ? Icons.memory : item['type'] == 'condensateur' ? Icons.battery_charging_full : Icons.electric_bolt,
            size: 40,
            color: Colors.black,
          ),
        ),
        childWhenDragging: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.black, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(0, 2),
                blurRadius: 0,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                item['type'] == 'resistance' ? Icons.memory : item['type'] == 'condensateur' ? Icons.battery_charging_full : Icons.electric_bolt,
                color: Colors.blue,
                size: 30,
              ),
              const SizedBox(width: 15),
              Text(
                "Composant ${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
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