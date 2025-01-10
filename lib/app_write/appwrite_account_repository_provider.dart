import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'package:appwrite/enums.dart';
import 'package:appwrite/models.dart';
import 'package:dhruvi_todo_task/app_write/app_write_client.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'app_write_repo.dart';

final accountRepositoryProvider = AccountRepositoryProvider();

class AccountRepositoryProvider {
  AccountRepositoryProvider();

  Future<supa.User?> createNewAccount(
      String userId, String email, String password, String name) async {
    try {
      supa.AuthResponse user = await supabase.auth.signUp(
        password: password,
        email: email,
        data: {'first_name': name},
      );

      return user.user;
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<String?> sendVerificationEmail() async {
    /*try {
      await _account.createVerification(
          url: 'https://verification.codewithbisky.com/verifyEmail');
      return null;
    } on AppwriteException catch (e) {
      print(e);
      return e.message;
    }*/
  }



  Future<dynamic> getCurrentUserFromSession() async {
    try {
      supa.User? user = supabase.auth.currentUser;
      if (user != null) {
        final users =
            await supabase.from('users').select().eq('id', user.id).single();
        return users;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<String?> login(String email, String password) async {
    /* try {
      await _account.createEmailPasswordSession(
          email: email, password: password);
      return null;
    } on AppwriteException catch (e) {
      print(e);

      return e.message;
    }*/
  }

  Future<supa.AuthResponse?> supaBaseLogin(
      String email, String password) async {
    try {
      return supabase.auth.signInWithPassword(password: password, email: email);
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<String?> validateEmail(String userId, String secret) async {
    /* try {
      await _account.updateVerification(userId: userId, secret: secret);
      return null;
    } on AppwriteException catch (e) {
      print(e);

      return e.message;
    }*/
  }

  Future<supa.AuthResponse?> supaBaseGoogleSignIn() async {
    try {
      const webClientId =
          '95311063821-oii05ecfav4nid65kac9914soohpeghg.apps.googleusercontent.com';

      /// TODO: update the iOS client ID with your own.
      ///
      /// iOS Client ID that you registered with Google Cloud.
      const iosClientId = 'my-ios.apps.googleusercontent.com';

      // Google sign in on Android will work without providing the Android
      // Client ID registered on Google Cloud.

      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: webClientId,
      );
      log("googleSignIn ;${googleSignIn.currentUser}");
      final googleUser = await googleSignIn.signIn();

      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;
      log("accessToken :$googleUser || $googleAuth");
      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      return supabase.auth.signInWithIdToken(
        provider: supa.OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } on supa.Supabase catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
