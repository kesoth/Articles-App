import 'package:articles_app/models/user.dart';
import 'package:articles_app/utils/app_images.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMethods {
  Future<String?> addUserData(String email, String name) async {
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      DocumentReference ref = await usersCollection.add({
        'email': email,
        'name': name,
        'profile': kAppLogo,
      });
      return ref.id;
    } catch (e) {
      return null;
    }
  }

  Future<LocalUser?> getUserByEmail(String email) async {
    try {
      final CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first;
        if (userData != null) {
          LocalUser user = LocalUser(
            email: userData['email'],
            id: querySnapshot.docs.first.id,
            name: userData['name'],
            profile: userData['profile'],
          );
          return user;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProfile(String userId, String newProfile) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'profile': newProfile});
    } catch (e) {
      throw Exception("Error updating profile: $e");
    }
  }
}
