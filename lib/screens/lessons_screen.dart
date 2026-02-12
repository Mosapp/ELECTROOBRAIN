import 'package:flutter/material.dart';
import 'lesson_detail_screen.dart';

class LessonsScreen extends StatelessWidget {
  final String languageCode;
  final String userLevel;

  const LessonsScreen({super.key, required this.languageCode, required this.userLevel});

  static const Map<String, Map<String, String>> _subjectTranslations = {
    // Matières BT
    's1': {'fr': '1. Technologie Schéma', 'en': '1. Technology & Schematics'},
    's2': {'fr': '2. TP Mesure', 'en': '2. Lab Measurements'},
    's3': {'fr': '3. Mathématiques appliquées', 'en': '3. Applied Math'},
    's4': {'fr': '4. Sciences Physiques', 'en': '4. Physical Sciences'},
    's8': {'fr': '8. Dessin Industriel', 'en': '8. Industrial Drawing'},
    's13': {'fr': '13. RTV / CMC', 'en': '13. RTV / CMC'},
    's14': {'fr': '14. EDHC', 'en': '14. EDHC'},

    // Matières BTS
    's5': {'fr': '5. Électronique Analogique', 'en': '5. Analog Electronics'},
    's6': {'fr': '6. Électronique Numérique', 'en': '6. Digital Electronics'},
    's7': {'fr': '7. Informatique', 'en': '7. Computer Science'},
    's9': {'fr': '9. Téléphonie', 'en': '9. Telephony'},
    's10': {'fr': '10. Maintenance Atelier', 'en': '10. Workshop Maintenance'},
    's11': {'fr': '11. Anglais Technique', 'en': '11. Technical English'},
    's12': {'fr': '12. Technique d’Expression', 'en': '12. Expression Techniques'},
  };

  String _getText(String key) {
    return _subjectTranslations[key]?[languageCode] ?? _subjectTranslations[key]!['fr']!;
  }

  final List<Map<String, dynamic>> _allSubjects = const [
    // --- BT ---
    {
      'id': 's1',
      'icon': Icons.architecture,
      'level': 'BT',
    },
    {
      'id': 's2',
      'icon': Icons.speed,
      'level': 'BT',
    },
    {
      'id': 's3',
      'icon': Icons.calculate,
      'level': 'BT',
    },
    {
      'id': 's4',
      'icon': Icons.science,
      'level': 'BT',
    },
    {
      'id': 's8',
      'icon': Icons.brush,
      'level': 'BT',
    },
    {
      'id': 's13',
      'icon': Icons.work, // Icône corrigée
      'level': 'BT',
    },
    {
      'id': 's14',
      'icon': Icons.volunteer_activism,
      'level': 'BT',
    },

    // --- BTS ---
    {
      'id': 's5',
      'icon': Icons.memory,
      'level': 'BTS',
    },
    {
      'id': 's6',
      'icon': Icons.laptop_mac,
      'level': 'BTS',
    },
    {
      'id': 's7',
      'icon': Icons.computer,
      'level': 'BTS',
    },
    {
      'id': 's9',
      'icon': Icons.phone_in_talk,
      'level': 'BTS',
    },
    {
      'id': 's10',
      'icon': Icons.build,
      'level': 'BTS',
    },
    {
      'id': 's11',
      'icon': Icons.translate,
      'level': 'BTS',
    },
    {
      'id': 's12',
      'icon': Icons.slideshow, // Icône corrigée
      'level': 'BTS',
    },
  ];

  List<Map<String, dynamic>> get _subjects {
    return _allSubjects.where((subject) => subject['level'] == userLevel).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: Text(
          languageCode == 'fr' ? "Mes Matières" : "My Subjects",
          style: const TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _subjects.length,
        itemBuilder: (context, index) {
          final subject = _subjects[index];
          return _buildSubjectCard(context, subject);
        },
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

  Widget _buildSubjectCard(BuildContext context, Map<String, dynamic> subject) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LessonDetailScreen(
              languageCode: languageCode,
              subjectId: subject['id'],
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
              child: Icon(subject['icon'], color: Colors.black, size: 30),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                _getText(subject['id']),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 30, color: Colors.black),
          ],
        ),
      ),
    );
  }
}