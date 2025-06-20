import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData(String name) async {
    User? user = _auth.currentUser;

    if (user != null) {
      String uid = user.uid;

      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': user.email,
      });
    }
  }

  Future<String?> getUserName() async {
    User? user = _auth.currentUser;

    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot docSnapshot =
      await _firestore.collection('users').doc(uid).get();

      if (docSnapshot.exists) {
        Map<String, dynamic> userData =
        docSnapshot.data() as Map<String, dynamic>;
        return userData['name'] as String?;
      }
    }
    return null;
  }
}