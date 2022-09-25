// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    final username = emailController.text;
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fields can't be empty")));
      return;
    }

    if (supabase.auth.user() != null) {
      Navigator.popAndPushNamed(context, '/home');
      return;
    }

    final res = await supabase.auth.signIn(email: username, password: password);
    final error = res.error;

    if (error != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GTHR - login'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // * email input
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "email",
                ),
              ),
            ),
            // * password input
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "password",
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            // * login button
            TextButton(
              onPressed: login,
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.blue[200]),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: const Text(
                "LOGIN",
                style: TextStyle(fontSize: 22),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            // * register button
            TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.blue[200]),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: const Text(
                  "REGISTER PAGE",
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                }),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
