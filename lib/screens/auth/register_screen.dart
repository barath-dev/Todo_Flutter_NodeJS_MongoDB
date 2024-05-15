// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo/components/text_field.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/auth/login_screen.dart';
import 'package:todo/utils/toast.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  Future<dynamic> _register() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regBody = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      var response = await http.post(
        Uri.parse('http://172.26.83.58:3001/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Utils.showToast("Registered successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register',
              style: TextStyle(color: Colors.white, fontSize: 24)),
          backgroundColor: Colors.black,
          toolbarHeight: 60,
        ),
        body: Column(
          children: [
            const Spacer(),
            TextInput(
              controller: emailController,
              label: "Email",
            ),
            TextInput(
              controller: passwordController,
              label: "Password",
              isPass: true,
            ),
            ElevatedButton(
              onPressed: () {
                var res = _register();
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  },
                  child: Text(
                    ' Login',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ));
  }
}
