import 'package:flutter/material.dart';
import 'lesson_detail_screen.dart'; // <--- IMPORTANT

class LessonsScreen extends StatelessWidget {
  final String languageCode;
  final String userLevel;

  const LessonsScreen({super.key, required this.languageCode, required this.userLevel});

  static const Map<String, Map<String, String>> _lessonTranslations = {
    'fr': {
      'appBar': 'Mes Leçons',
      'c1_title': 'Lois Fondamentales',
      'c1_desc': 'Tension, Courant, Loi d\'Ohm et Puissance.',
      'c2_title': 'Composants Passifs',
      'c2_desc': 'Résistances, Condensateurs, Bobines.',
      'c3_title': 'Architecture de l\'Info',
      'c3_desc': 'Binaire, Hexadécimal, Codage de l\'information.',
      'c4_title': 'Logique Combinatoire',
      'c4_desc': 'Fonctions logiques, Tables de vérité.',
      'c5_title': 'Microcontrôleurs',
      'c5_desc': 'Introduction aux PIC/Arduino, Ports E/S.',
      'c6_title': 'Lecture de Schémas',
      'c6_desc': 'Symboles normalisés, Analyse de circuits.',
      'c7_title': 'CAN & CNA',
      'c7_desc': 'Conversion Analogique/Numérique.',
      'c8_title': 'Capteurs & Actionneurs',
      'c8_desc': 'Interfaçage avec le monde réel.',
    },
    'en': {
      'appBar': 'My Lessons',
      'c1_title': 'Fundamental Laws',
      'c1_desc': 'Voltage, Current, Ohm\'s Law and Power.',
      'c2_title': 'Passive Components',
      'c2_desc': 'Resistors, Capacitors, Inductors.',
      'c3_title': 'Computer Architecture',
      'c3_desc': 'Binary, Hexadecimal, and Information Coding.',
      'c4_title': 'Combinatorial Logic',
      'c4_desc': 'Logic gates, Truth tables, Boolean Algebra.',
      'c5_title': 'Microcontrollers',
      'c5_desc': 'Intro to PIC/Arduino, I/O Ports.',
      'c6_title': 'Reading Schematics',
      'c6_desc': 'Standard symbols, PCB circuit analysis.',
      'c7_title': 'ADC & DAC',
      'c7_desc': 'Analog/Digital Conversion.',
      'c8_title': 'Sensors & Actuators',
      'c8_desc': 'Interfacing with the real world.',
    },
  };

  String _getText(String key) {
    return _lessonTranslations[languageCode]?[key] ?? _lessonTranslations['fr']![key]!;
  }

  final List<Map<String, dynamic>> _allChapters = const [
    {
      'icon': Icons.bolt,
      'titleKey': 'c1_title',
      'descKey': 'c1_desc',
      'level': 'BT',
    },
    {
      'icon': Icons.category,
      'titleKey': 'c2_title',
      'descKey': 'c2_desc',
      'level': 'BT',
    },
    {
      'icon': Icons.memory,
      'titleKey': 'c3_title',
      'descKey': 'c3_desc',
      'level': 'BT',
    },
    {
      'icon': Icons.grid_on,
      'titleKey': 'c4_title',
      'descKey': 'c4_desc',
      'level': 'BTS',
    },
    {
      'icon': Icons.developer_board,
      'titleKey': 'c5_title',
      'descKey': 'c5_desc',
      'level': 'BTS',
    },
    {
      'icon': Icons.description,
      'titleKey': 'c6_title',
      'descKey': 'c6_desc',
      'level': 'BTS',
    },
    {
      'icon': Icons.swap_horiz,
      'titleKey': 'c7_title',
      'descKey': 'c7_desc',
      'level': 'BTS',
    },
    {
      'icon': Icons.sensors,
      'titleKey': 'c8_title',
      'descKey': 'c8_desc',
      'level': 'BTS',
    },
  ];

  List<Map<String, dynamic>> get _chapters {
    return _allChapters.where((chapter) => chapter['level'] == userLevel).toList();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          _getText('appBar'),
          style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _chapters.length,
        itemBuilder: (context, index) {
          final chapter = _chapters[index];
          return _buildChapterCard(context, chapter);
        },
      ),
    );
  }

  Widget _buildChapterCard(BuildContext context, Map<String, dynamic> chapter) {
    return GestureDetector(
      onTap: () {
        // EXTRACTION DE L'ID : 'c1_title' -> 'c1'
        String chapterId = chapter['titleKey'].toString().split('_')[0];

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LessonDetailScreen(
              languageCode: languageCode,
              chapterKey: chapterId,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black, width: 3),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(0, 6), blurRadius: 0),
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
              child: Icon(
                chapter['icon'],
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getText(chapter['titleKey']),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _getText(chapter['descKey']),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 30, color: Colors.black),
          ],
        ),
      ),
    );
  }
}