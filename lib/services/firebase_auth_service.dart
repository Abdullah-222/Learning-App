import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_learning_app/services/auth_service.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? get currentUserEmail => _auth.currentUser?.email;

  @override
  String? get currentUserName => _auth.currentUser?.displayName;

  @override
  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  @override
  Future<bool> register(String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final uid = userCredential.user?.uid;
      if (uid != null) {
        await userCredential.user?.updateDisplayName(name);
        
        final firestore = FirebaseFirestore.instance;
        
        // 1. Create the user document per Project.md spec
        // We don't await this so the UI doesn't hang if Firestore DB isn't created in the console yet
        firestore.collection('users').doc(uid).set({
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        }).catchError((e) => print('Error creating user doc: $e'));
        
        // 2. Initialize the empty progress document
        firestore.collection('progress').doc(uid).set({
          'buffer_overflow': 0,
          'memory_leak': 0,
          'pointer_misuse': 0,
          'integer_overflow': 0,
          'null_pointer': 0,
          'input_validation': 0,
          'unsafe_functions': 0,
        }).catchError((e) => print('Error creating progress doc: $e'));
      }
      
      return true;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<bool> isLoggedIn() async {
    final user = await _auth.authStateChanges().first;
    return user != null;
  }
}
