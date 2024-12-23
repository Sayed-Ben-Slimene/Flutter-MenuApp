import 'package:cloud_firestore/cloud_firestore.dart';

class Recette {
  String id;
  String name;
  String description;
  String category;
  String imagePath;

  Recette({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.imagePath,
  });

  factory Recette.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Recette(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      imagePath: data['imagePath'] ?? 'lib/images/plats.jpg',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'imagePath': imagePath,
    };
  }
}