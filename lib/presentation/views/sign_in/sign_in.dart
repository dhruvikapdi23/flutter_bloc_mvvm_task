import 'dart:developer';

import 'package:dhruvi_todo_task/constants/extension/widget_extension.dart';
import 'package:dhruvi_todo_task/presentation/blocs/sign_in/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'avatar.dart';

class SignIn extends StatefulWidget {

  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final signIn = context.read<SignInCubit>();
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (_, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(signIn.user != null
                    ? 'Logged in as ${signIn.user!.email}'
                    : 'Not logged in'),
                FutureBuilder(
                    future: signIn.getUser(),
                    builder: (_, snapshot) {
                      log("snapshot.data :${snapshot.data}");
                      return snapshot.data == null ?Container(): Avatar(
                        imageUrl: snapshot.data == null
                            ? null
                            : snapshot.data['avatar_url'],
                        onUpload: (p0) => signIn.onUpload(p0, context),
                      );
                    }),
                TextField(
                  controller: signIn.emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: signIn.passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: signIn.nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                Wrap(
                  spacing: 16,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        signIn.login(signIn.emailController.text,
                            signIn.passwordController.text, context);
                      },
                      child: const Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn.createAccount(context);
                      },
                      child: const Text('Register'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn.signinWithGoogle(context);
                      },
                      child: const Text('Google'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signIn.logout();
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
                FutureBuilder(
                  future: signIn.getUser(),
                  builder: (_, snapshot) {
                    return snapshot.data == null
                        ? const Text("NOT SIGNED IN")
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("NAME : ${snapshot.data!['name']}"),
                              Text("EMAIL : ${snapshot.data!['email']}"),
                            ],
                          );
                  },
                )
              ],
            ).paddingDirectional(horizontal: 20, vertical: 60),
          ),
        );
      },
    );
  }
}
