import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> saveProgress(String topicId, int score) async {
    final uid = currentUserId;
    if (uid == null) return; // Cannot save if not logged in

    try {
      final docRef = _firestore.collection('progress').doc(uid);
      
      // We use set with merge: true to avoid overwriting other topics
      // and only update if the new score is higher.
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        
        if (!snapshot.exists) {
           transaction.set(docRef, {topicId: score});
        } else {
           final data = snapshot.data();
           final currentScore = (data?[topicId] as num?)?.toInt() ?? 0;
           
           if (score > currentScore) {
             transaction.update(docRef, {topicId: score});
           }
        }
      });
    } catch (e) {
      print('Error saving progress: $e');
    }
  }

  Future<int> getProgress(String topicId) async {
    final uid = currentUserId;
    if (uid == null) return 0;

    try {
      final docSnapshot = await _firestore.collection('progress').doc(uid).get();
      if (docSnapshot.exists && docSnapshot.data() != null) {
         return (docSnapshot.data()![topicId] as num?)?.toInt() ?? 0;
      }
    } catch (e) {
      print('Error getting progress for $topicId: $e');
    }
    return 0;
  }

  Future<void> resetProgress(String topicId) async {
     final uid = currentUserId;
     if (uid == null) return;

     try {
       await _firestore.collection('progress').doc(uid).set({
         topicId: 0
       }, SetOptions(merge: true));
     } catch (e) {
       print('Error resetting progress: $e');
     }
  }

  // Singleton pattern
  static final ProgressService _instance = ProgressService._internal();
  factory ProgressService() => _instance;
  ProgressService._internal();
}
