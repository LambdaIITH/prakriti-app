import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  String username = "";
  String email = "";
  String role = "";

  final _firebaseAuth = FirebaseAuth.instance;
  bool isAdmin = false;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String passwd,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: passwd,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String passwd,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: passwd,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
