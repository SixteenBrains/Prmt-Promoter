import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/promoter.dart';
import '/models/failure.dart';
import '/config/paths.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'base_auth_repo.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection(Paths.promoters);

  Promoter? _promoter(User? user) {
    if (user == null) return null;
    print('user phone number -- ${user.phoneNumber}');
    return Promoter(
      promoterId: user.uid,
      name: user.displayName,
      phoneNumber: user.phoneNumber,
    );
  }

  @override
  Stream<Promoter?> get onAuthChanges =>
      _firebaseAuth.userChanges().map((user) => _promoter(user));

  @override
  Future<Promoter?> get currentUser async =>
      _promoter(_firebaseAuth.currentUser);

  String? get userImage => _firebaseAuth.currentUser?.photoURL;

  String? get userId => _firebaseAuth.currentUser?.uid;

  @override
  Future<Promoter?> loginInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    try {
      if (email != null && password != null) {
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        return _promoter(userCredential.user);
      }
      return null;
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } catch (error) {
      throw const Failure(message: 'Something went wrong.Try again');
    }
  }

  @override
  Future<Promoter?> signUpWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    try {
      if (email != null && password != null) {
        final userCredentail = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        return _promoter(userCredentail.user);
      }
      return null;
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } catch (error) {
      throw const Failure(message: 'Something went wrong.Try again');
    }
  }

  @override
  Future<void>? forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } on PlatformException catch (error) {
      print(error.toString());
      throw Failure(code: error.code, message: error.message!);
    } catch (error) {
      throw const Failure(message: 'Something went wrong.Try again');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
