import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/components/text_field.dart';
import 'package:todo/screens/auth/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:todo/screens/home_screen.dart';
import 'package:todo/utils/toast.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<dynamic> login() async {
    try {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        var loginBody = {
          "email": emailController.text,
          "password": passwordController.text,
        };

        Utils.showToast("Logging in...");

        var response = await http.post(
          Uri.parse("http://172.26.83.58:3001/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(loginBody),
        );

        if (response.statusCode == 200) {
          var myToken = jsonDecode(response.body)["token"];
          Utils.showToast("Logged in successfully");
          prefs.setString("token", myToken);
          Navigator.pushReplacement(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        token: myToken,
                      )));
        } else {}
      } else {
        return "Please fill all the fields";
      }
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login',
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
              onPressed: login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: Text(
                    ' Register',
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
