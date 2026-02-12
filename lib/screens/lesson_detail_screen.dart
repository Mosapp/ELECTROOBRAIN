import 'package:flutter/material.dart';
import 'sub_topic_detail_screen.dart'; // On importe le nouvel écran

class LessonDetailScreen extends StatelessWidget {
  final String languageCode;
  final String subjectId;

  const LessonDetailScreen({
    super.key,
    required this.languageCode,
    required this.subjectId,
  });

  // NOUVELLE STRUCTURE : Chaque sujet a une liste de sous-thèmes avec TITRE + CONTENU
  static const Map<String, Map<String, dynamic>> _contentData = {
    's1': {
      'title': 'Technologie Schéma',
      'topics': [
        {
          'title': 'Lecture de schémas électriques',
          'content': """
La lecture de schéma est une compétence essentielle pour tout technicien. Un schéma électrique est un dessin qui représente un circuit électrique de manière normalisée.

**Principe :**
Il utilise des symboles graphiques pour représenter les composants (résistances, bobines, interrupteurs) et des lignes pour représenter les fils de connexion.

**Fonctionnement :**
Pour lire un schéma, on suit le parcours du courant depuis la source d'alimentation (généralement en haut à gauche) vers la masse (en bas). On analyse ensuite chaque branche pour comprendre la fonction de chaque partie du circuit.
          """
        },
        {
          'title': 'Symboles normalisés',
          'content': """
Les symboles normalisés sont des codes graphiques universels définis par des normes (comme la CEI 60617). Ils permettent à des ingénieurs de pays différents de se comprendre sans parler la même langue.

**Exemples courants :**
- Résistance : Un rectangle (ou un zigzag selon l'ancienne norme).
- Générateur : Deux cercles, l'un représentant le '+' et l'autre le '-'.
- Masse : Trois lignes horizontales de taille décroissante.

**Pourquoi c'est important ?**
Si vous voyez un triangle sur un schéma, vous savez immédiatement qu'il s'agit d'un amplificateur opérationnel, sans avoir besoin de lire un texte en anglais ou en chinois.
          """
        },
        {
          'title': 'Schéma développé vs unifilaire',
          'content': """
Il existe deux façons principales de dessiner les connexions.

1. **Schéma Développé (Multifilaire) :** Chaque fil est dessiné individuellement. C'est très clair pour de petits circuits, mais ça devient illisible dès qu'il y a trop de fils qui se croisent.

2. **Schéma Unifilaire :** Au lieu de dessiner 3 fils pour un câble triphasé, on en dessine un seul avec une barre oblique et le chiffre "3". C'est beaucoup plus propre pour les installations industrielles complexes.
          """
        },
        {
          'title': 'Schéma de câblage',
          'content': """
Contrairement au schéma de principe qui montre la logique, le schéma de câblage montre **physiquement** où sont connectés les appareils.

Il ressemble à un plan d'architecte où l'on voit la position des prises, des interrupteurs et des lampes, et le chemin réel des câbles dans les murs ou les gaines.
          """
        },
        {
          'title': 'Repérage des composants',
          'content': """
Pour ne pas se perdre dans un schéma complexe, chaque composant est identifié par un code (ex: R1 pour la première résistance, K1 pour le premier relais).

**Règle de base :**
- Lettre(s) : Type de composant (R= Résistance, C=Condensateur, K=Relais).
- Chiffre : Numéro d'ordre.

Cela permet aussi de faire correspondre le schéma avec le plan de câblage et la nomenclature (la liste des pièces).
          """
        },
        {
          'title': 'Interprétation de plans industriels',
          'content': """
Dans l'industrie, les schémas sont souvent divisés en plusieurs folios (pages).
- Le folio 1 contient l'alimentation.
- Le folio 2 contient la commande.

Des flèches ou des références croisés (ex: "Voir folio 2/3") permettent de naviguer entre les pages pour suivre le signal électrique à travers toute l'installation.
          """
        },
      ],
    },
    // --- Pour les autres sujets (s2 à s14), je laisse la structure simple pour l'instant ---
    // Vous devrez copier le format ci-dessus pour ajouter le vrai contenu.
    's2': {
      'title': 'TP Mesure',
      'topics': [
        {'title': 'Utilisation du multimètre', 'content': 'Contenu à ajouter...'},
        {'title': 'Mesure de tension AC/DC', 'content': 'Contenu à ajouter...'},
        {'title': 'Mesure de courant', 'content': 'Contenu à ajouter...'},
        {'title': 'Mesure de résistance', 'content': 'Contenu à ajouter...'},
        {'title': 'Test de continuité', 'content': 'Contenu à ajouter...'},
        {'title': 'Utilisation de l’oscilloscope', 'content': 'Contenu à ajouter...'},
        {'title': 'Sécurité en laboratoire', 'content': 'Contenu à ajouter...'},
      ],
    },
    's3': {
      'title': 'Mathématiques appliquées',
      'topics': [
        {'title': 'Calcul littéral', 'content': 'Contenu à ajouter...'},
        {'title': 'Équations du 1er et 2e degré', 'content': 'Contenu à ajouter...'},
        {'title': 'Trigonométrie', 'content': 'Contenu à ajouter...'},
        {'title': 'Nombres complexes', 'content': 'Contenu à ajouter...'},
        {'title': 'Puissance et énergie', 'content': 'Contenu à ajouter...'},
        {'title': 'Calculs de circuits', 'content': 'Contenu à ajouter...'},
      ],
    },
    // ... (s4, s5, etc. peuvent être ajoutés sur le même modèle)
  };

  Map<String, dynamic>? _getSubjectData() {
    return _contentData[subjectId];
  }

  @override
  Widget build(BuildContext context) {
    final data = _getSubjectData();

    if (data == null) {
      return Scaffold(
        backgroundColor: const Color(0xFF1CB0F6),
        appBar: AppBar(
          leading: _buildBackButton(context),
          title: const Text("Leçon", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF1CB0F6),
          elevation: 0,
        ),
        body: const Center(
          child: Text(
            "Contenu à venir...",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    }

    String title = data['title'];
    // Note: On récupère une liste d'objets maintenant, pas juste des String
    List<dynamic> topics = data['topics'];

    return Scaffold(
      backgroundColor: const Color(0xFF1CB0F6),
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: const Text("Leçon", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1CB0F6),
        elevation: 0,
      ),
      body: ListView.builder( // On utilise ListView.builder pour pouvoir scroller
        padding: const EdgeInsets.all(20),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: _buildTopicCard(context, topic),
          );
        },
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, Map<String, dynamic> topic) {
    return GestureDetector(
      onTap: () {
        // On ouvre le nouvel écran avec le titre et le contenu
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SubTopicDetailScreen(
              topicTitle: topic['title'],
              topicContent: topic['content'],
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          children: [
            const Icon(Icons.arrow_right, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                topic['title'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
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