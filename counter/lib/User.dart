import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final Map<dynamic, dynamic> count;

  User({
    this.id,
    this.count,
  });

  factory User.fromDoc(DocumentSnapshot doc) {
    if (doc == null) {
      return User(
        id: '',
        count: Map(),
      );
    }
    return User(
      id: doc.documentID ?? '',
      count: doc['count'] ?? Map(),
    );
  }
}
