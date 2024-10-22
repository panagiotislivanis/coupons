import 'package:coupons/AdminHomePage.dart';
import 'package:coupons/user_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void handleLogin() async {
    final response = await http.post(
      Uri.parse("${Config.serverIP}/login"),
      headers: {
        'Content-Type': 'application/json', // Ορισμός του σωστού content type
      },
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    final responseData = json.decode(response.body);

    if (responseData['success']) {
      bool role = responseData['role'];
      if (role == true) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserHomePage()),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(responseData['message']),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
