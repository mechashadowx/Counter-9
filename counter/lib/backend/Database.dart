import 'package:cloud_firestore/cloud_firestore.dart';
import '../User.dart';

final firestore = Firestore.instance;
final usersRef = firestore.collection('/users');

class Database {
  static void updateUser(User user) {
    usersRef.document(user.id).updateData({
      'count': user.count,
    });
  }
}
