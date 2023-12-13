import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleAuthProvider googleProvider = GoogleAuthProvider();
      return _auth.signInWithProvider(googleProvider);
    } catch (error) {
      //print('Error during Google sign in: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}