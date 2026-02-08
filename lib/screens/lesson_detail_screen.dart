import 'package:flutter/material.dart';

class LessonDetailScreen extends StatelessWidget {
  final String languageCode;
  final String chapterKey; // Recevra 'c1', 'c2', etc.

  const LessonDetailScreen({
    super.key,
    required this.languageCode,
    required this.chapterKey,
  });

  // --- BASE DE DONNÉES DU CONTENU DES COURS ---
  static const Map<String, Map<String, Map<String, String>>> _contentData = {
    'c1': {
      'fr': {
        'title': 'Chapitre 1 : Lois Fondamentales',
        'content': """
L'électricité est le mouvement des électrons dans un conducteur. Pour comprendre comment elle fonctionne, il faut maîtriser trois concepts clés :

1. La Tension (U) : Mesurée en Volts (V), c'est la "pression" qui pousse les électrons. C'est la différence de potentiel entre deux points d'un circuit.

2. L'Intensité (I) : Mesurée en Ampères (A), c'est le débit du courant électrique, c'est-à-dire le nombre d'électrons qui passent en une seconde.

3. La Résistance (R) : Mesurée en Ohms (Ω), c'est la difficulté que les électrons rencontrent pour passer dans le matériau.

La Loi d'Ohm est la base de l'électronique :
U = R x I
(Tension = Résistance x Intensité)
        """
      },
      'en': {
        'title': 'Chapter 1: Fundamental Laws',
        'content': """
Electricity is the movement of electrons in a conductor. To understand how it works, we must master three key concepts:

1. Voltage (U): Measured in Volts (V), it is the "pressure" pushing the electrons. It is the potential difference between two points in a circuit.

2. Current (I): Measured in Amperes (A), it is the flow rate of the electric current, i.e., the number of electrons passing per second.

3. Resistance (R): Measured in Ohms (Ω), it is the difficulty the electrons encounter to pass through the material.

Ohm's Law is the basis of electronics:
U = R x I
(Voltage = Resistance x Current)
        """
      },
    },
    // --- Chapitres suivants (Placeholders) ---
    'c2': {
      'fr': {'title': 'Composants Passifs', 'content': 'Contenu sur les résistances et condensateurs... À compléter.'},
      'en': {'title': 'Passive Components', 'content': 'Content about resistors and capacitors... To be completed.'},
    },
    'c3': {
      'fr': {'title': 'Architecture de l\'Info', 'content': 'Contenu sur le binaire et l\'hexadécimal... À compléter.'},
      'en': {'title': 'Computer Architecture', 'content': 'Content about binary and hexadecimal... To be completed.'},
    },
    'c4': {
      'fr': {'title': 'Logique Combinatoire', 'content': 'Contenu sur les portes logiques... À compléter.'},
      'en': {'title': 'Combinatorial Logic', 'content': 'Content about logic gates... To be completed.'},
    },
    'c5': {
      'fr': {'title': 'Microcontrôleurs', 'content': 'Contenu sur les PIC et Arduino... À compléter.'},
      'en': {'title': 'Microcontrollers', 'content': 'Content about PIC and Arduino... To be completed.'},
    },
    'c6': {
      'fr': {'title': 'Lecture de Schémas', 'content': 'Contenu sur les symboles... À compléter.'},
      'en': {'title': 'Reading Schematics', 'content': 'Content about symbols... To be completed.'},
    },
    'c7': {
      'fr': {'title': 'CAN & CNA', 'content': 'Contenu sur la conversion... À compléter.'},
      'en': {'title': 'ADC & DAC', 'content': 'Content about conversion... To be completed.'},
    },
    'c8': {
      'fr': {'title': 'Capteurs & Actionneurs', 'content': 'Contenu sur l\'interfaçage... À compléter.'},
      'en': {'title': 'Sensors & Actuators', 'content': 'Content about interfacing... To be completed.'},
    },
  };

  String _getLessonInfo(String type) {
    if (!_contentData.containsKey(chapterKey)) {
      return languageCode == 'fr' ? "Contenu non disponible" : "Content not available";
    }
    final chapter = _contentData[chapterKey]!;
    return chapter[languageCode]?[type] ?? chapter['fr']![type]!;
  }

  @override
  Widget build(BuildContext context) {
    String title = _getLessonInfo('title');
    String content = _getLessonInfo('content');

    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: GestureDetector(
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
        ),
        title: const Text(
          "Leçon",
          style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 4,
                    color: Colors.yellow,
                    margin: const EdgeInsets.only(bottom: 20),
                  ),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}