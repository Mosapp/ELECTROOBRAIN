import 'package:flutter/material.dart';

class SubTopicDetailScreen extends StatelessWidget {
  final String topicTitle;
  final String topicContent;

  const SubTopicDetailScreen({
    super.key,
    required this.topicTitle,
    required this.topicContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: const Text("Cours", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Titre du sous-thème
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 3),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(0, 4), blurRadius: 0),
                ],
              ),
              child: Text(
                topicTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Contenu du cours
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3),
              ),
              child: Text(
                topicContent,
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.6, // Espacement aéré pour la lecture
                  color: Colors.black87,
                ),
              ),
            ),
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