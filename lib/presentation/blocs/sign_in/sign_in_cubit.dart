import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;

import 'package:bloc/bloc.dart';
import 'package:objectid/objectid.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../app_write/app_write_repo.dart';
import '../../../app_write/appwrite_account_repository_provider.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  supa.User? user;
  String? imageUrl;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();


  //signup
  void createAccount(context) async {
    supa.User? user = await accountRepositoryProvider.createNewAccount(
        ObjectId().hexString,
        emailController.text,
        passwordController.text,
        nameController.text);
    if (user == null) {

      log("user : $user");

      log("Failed to create an account, please try again later");
      return;
    } else {
      await supabase.from('users').insert({
        'email': user.email,
        'name': nameController.text,
        'password': passwordController.text,
        "id": user.id
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text("We have send you verification link on your given email")));
    }
  }


  //upload profile image
  Future<void> onUpload(String url, context) async {
    try {
      final userId = supabase.auth.currentUser!.id;
      log("userId :$userId");

      await supabase.from('users').upsert({
        'avatar_url': imageUrl,
      }).eq('id', userId);
      const SnackBar(
        content: Text('Updated your profile image!'),
      );
    } on PostgrestException catch (error) {
      context.showSnackBar(error.message, isError: true);
    } catch (error) {
      context.showSnackBar('Unexpected error occurred', isError: true);
    }

  }

//get current user info
  Future<dynamic> getUser() async {
    return await accountRepositoryProvider.getCurrentUserFromSession();
  }

  //login
  login(String email, String password, context) async {
    try {
      supa.AuthResponse? message =
          await accountRepositoryProvider.supaBaseLogin(email, password);
      if (message != null && message.session != null) {
        log("message.session!.user.id;${message.session!.user!.id}");
        await supabase
            .from('users')
            .update({'isVerify': true}).eq('id', message.user!.id);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login Successfully")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //sign in with google
  void signinWithGoogle(context) async {
    try {
      supa.AuthResponse? response =
          await accountRepositoryProvider.supaBaseGoogleSignIn();
      if (response != null) {
        supa.User? user = response.user;

        if (user != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successfully")));
        } else {
          log('Failed to login, please try again later');
        }
      }
    } catch (e) {
      print("kdfg :$e");
    }
  }

  //logout
  void logout() async {
    await accountRepositoryProvider.logout();
    getUser();
  }
}
