import 'package:cloud_firestore/cloud_firestore.dart';
import 'Category.dart';
import 'Recette.dart';

class MenuService {
  final CollectionReference menuCollection = FirebaseFirestore.instance.collection('Recettes');
  final CollectionReference categoryCollection = FirebaseFirestore.instance.collection('Categories');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRecette(Recette item) {
    return menuCollection.add(item.toMap());
  }

  Future<void> updateRecette(Recette item) {
    return menuCollection.doc(item.id).update(item.toMap());
  }

  Future<void> deleteRecette(String id) {
    return menuCollection.doc(id).delete();
  }

  Stream<List<Recette>> getRecettes() {
    return menuCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Recette.fromFirestore(doc)).toList();
    });
  }

  Stream<Recette> getRecetteById(String id) {
    return menuCollection.doc(id).snapshots().map((doc) => Recette.fromFirestore(doc));
  }

  Future<void> addCategory(Category category) {
    return categoryCollection.add(category.toMap());
  }

  Future<void> updateCategory(Category category) {
    return categoryCollection.doc(category.id).update(category.toMap());
  }

  Future<void> deleteCategory(String id) {
    return categoryCollection.doc(id).delete();
  }

  Stream<List<Category>> getCategories() {
    return categoryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
    });
  }

  Stream<List<Category>> getCategoriesCards() {
    return _firestore.collection('Categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
    });
  }

  Stream<List<Recette>> getRecettesByCategory(String category) {
    return _firestore
        .collection('Recettes')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Recette.fromFirestore(doc)).toList();
    });
  }

}