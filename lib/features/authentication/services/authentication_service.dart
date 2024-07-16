import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //code to provide the value of isLoading
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  User? _user;

  User? get user => _user;

  AuthenticationService() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? user) async {
    _user = user;
    notifyListeners();
  }

  /// SIGN IN METHOD
  Future<String?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      _setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _setLoading(false);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      print(e.message);
      return (e.message);
    } catch (e) {
      _setLoading(false);
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Sign Up with Email and Password
  Future<String?> signUpWithEmail(
      {required String name,
      required String email,
      required String password}) async {
    try {
      _setLoading(true);
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //send verification email
      await userCredential.user!.sendEmailVerification();

      //Create User Data in FIRESTORE
      createUserData(name: name, email: email, uid: userCredential.user!.uid);
      _setLoading(false);
      return "Sign up successful! Please verify your email.";
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      print(e.message);
      return (e.message);
    } catch (e) {
      _setLoading(false);
      throw Exception('An unknown error occurred: $e');
    }
  }

  //CREATE USER DATA FIRESTORE
  Future<void> createUserData(
      {required String name,
      required String email,
      required String uid}) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'uid': uid,
        'created_at': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error creating user data: $e");
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Sign In with Google
  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _setLoading(false);
        return 'User canceled the sign in'; // user canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authCredential =
          await _auth.signInWithCredential(credential);
      final additionalUserInfo = authCredential.additionalUserInfo;
      if (additionalUserInfo != null && additionalUserInfo.isNewUser) {
        createUserData(
            name: googleUser.displayName!,
            email: googleUser.email,
            uid: authCredential.user!.uid);
      }

      _setLoading(false);
      return 'Sign in successful';
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      return e.message;
    } catch (e) {
      _setLoading(false);
      return 'An unknown error occurred: $e';
    }
  }

  Future<String?> sendVerificationEmail() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      return "Verification email sent.";
    } catch (e) {
      return "Some error occured.";
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Sign Out from Google
  Future<void> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Reset Password
  Future<String?> resetPassword(String email) async {
    try {
      _setLoading(true);
      await _auth.sendPasswordResetEmail(email: email);
      _setLoading(false);
      return "Password reset email sent";
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      return e.message;
    }
  }
}
