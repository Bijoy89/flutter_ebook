import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ebook/Config/Messages.dart';
import 'package:flutter_ebook/Pages/HomePage/Homepage.dart';
import 'package:flutter_ebook/Pages/WelcomePage.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final auth=FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    isLoading.value = true;
    try {
      // Pass Web Client ID from Firebase Console
      await GoogleSignIn.instance.initialize(
        serverClientId: '100999325622-3t6tfj19m96f1k4n9taljuc320ich4ga.apps.googleusercontent.com',
      ).then((_) {
        print("GoogleSignIn initialized");
      });

      final GoogleSignInAccount account = await GoogleSignIn.instance.authenticate();

      final authClient = account.authorizationClient;
      final authorization = await authClient.authorizationForScopes(['email', 'profile']);

      if (authorization == null) {
        print('Authorization failed.');
        return null;
      }

      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
        accessToken: authorization.accessToken,
      );

      await auth.signInWithCredential(credential);
      successMessage('Login Success');
      Get.offAll(HomePage()); // Navigate to home page after successful login
    } catch (e) {
      print("Google Sign-In failed: $e");
      errorMessage("Error !Try Again");
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      await auth.signOut();
      successMessage('Logout Success');
      Get.offAll(Welcomepage()); // Navigate to home page after successful logout
    } catch (e) {
      print("Sign out failed: $e");
      errorMessage("Error !Try Again");
    }
  }
}
