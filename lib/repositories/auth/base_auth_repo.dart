import '/models/promoter.dart';

abstract class BaseAuthRepository {
  Future<Promoter?> get currentUser;
  Stream<Promoter?> get onAuthChanges;
  Future<void>? forgotPassword(String email);
  Future<Promoter?> signUpWithEmailAndPassword({
    required String? email,
    required String? password,
  });
  Future<Promoter?> loginInWithEmailAndPassword({
    required String? email,
    required String? password,
  });
  Future<void> signOut();
}
