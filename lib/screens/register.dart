// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:gthr/wids/button_style.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void register() async {
    final useremail = emailController.text;
    // final username = usernameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (confirmPassword != password) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('passwords not matching')));
      return;
    }

    final res = await supabase.auth.signUp(useremail, password);
    // final user = res.data?.user;
    final error = res.error;

    if (!mounted) {
      return;
    }

    if (error != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GTHR - register'),
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
                  labelText: "enter email",
                ),
              ),
            ),
            // * username input
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "enter username",
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
                  labelText: "enter password",
                ),
              ),
            ),
            // * confirm password input
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "confirm password",
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            // * register button
            TextButton(
                style: myButtonStyle,
                onPressed: register,
                child: const Text(
                  "REGISTER",
                  style: TextStyle(fontSize: 22),
                )),
            const Divider(
              thickness: 2,
            ),
            TextButton(
                style: myButtonStyle,
                child: const Text(
                  "LOGIN PAGE",
                  style: TextStyle(fontSize: 22),
                ),
                onPressed: () => {Navigator.pop(context)}),
            const Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
