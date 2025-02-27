import 'package:authenticate_module/feature/home_screen.dart';
import 'package:authenticate_module/service/auth_service.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void _login() {
    if (_formKey.currentState!.validate()) {
      try {
        bool result = authService.login(
          emailController.text,
          passwordController.text,
        );
        if (result) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomeScreen()));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              validator: (value) => value!.isEmpty ? 'Enter email' : null,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) => value!.isEmpty ? 'Enter password' : null,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
