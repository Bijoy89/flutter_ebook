import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ebook/Config/Messages.dart';
import 'package:flutter_ebook/Pages/HomePage/Homepage.dart';
import 'package:flutter_ebook/Pages/WelcomePage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    isLoading.value = true;
    try {
      await googleSignIn.signOut();
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        errorMessage("Google Sign-In cancelled");
        return null;
      }

      final googleAuth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCred = await auth.signInWithCredential(credential);
      final doc = await firestore.collection('users').doc(userCred.user!.uid).get();

      if (!doc.exists) {
        final adminQuery = await firestore.collection('users').where('role', isEqualTo: 'admin').get();
        final role = adminQuery.docs.isEmpty ? 'admin' : 'user';

        await firestore.collection('users').doc(userCred.user!.uid).set({
          'name': userCred.user!.displayName ?? '',
          'email': userCred.user!.email ?? '',
          'role': role,
          'isSubscribed': false,
          'readBooks': [],
        });
      }

      successMessage("Login Successful");
      await _goToHome(userCred.user!.uid);
      return userCred;
    } catch (e) {
      errorMessage("Google login failed: $e");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerWithEmail(String name, String email, String password, String role) async {
    isLoading.value = true;
    try {
      if (role == 'admin') {
        final query = await firestore.collection('users').where('role', isEqualTo: 'admin').get();
        if (query.docs.isNotEmpty) {
          errorMessage("Admin already exists. Only one admin is allowed.");
          return;
        }
      }

      final userCred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      await firestore.collection('users').doc(userCred.user!.uid).set({
        'name': name,
        'email': email,
        'role': role,
        'isSubscribed': false,
        'readBooks': [],
      });

      successMessage("Registration successful. Please login.");
      Get.back();
    } catch (e) {
      errorMessage("Registration failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> loginWithEmail(String email, String password, String selectedRole) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Fetch user role from Firestore
      final userDoc = await firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        await auth.signOut();
        Get.snackbar("Error", "User data not found.");
        isLoading.value = false;
        return;
      }

      String actualRole = userDoc.data()?['role'] ?? 'user';

      if (actualRole != selectedRole) {
        await auth.signOut();
        Get.snackbar("Role Mismatch", "You are not registered as $selectedRole.");
        isLoading.value = false;
        return;
      }

      // Proceed to homepage with correct role
      Get.offAll(() => HomePage(role: actualRole));

    } on FirebaseAuthException catch (e) {
      Get.snackbar("Login Failed", e.message ?? "An error occurred");
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> _goToHome(String uid) async {
    final doc = await firestore.collection('users').doc(uid).get();
    if (!doc.exists) {
      errorMessage("User data not found.");
      await auth.signOut();
      return;
    }

    final role = doc.data()?['role'] ?? 'user';
    Get.offAll(() => HomePage(role: role));
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await auth.signOut();
      successMessage("Signed out successfully.");
      Get.offAll(() => Welcomepage());
    } catch (e) {
      errorMessage("Sign out failed: $e");
    }
  }
}
