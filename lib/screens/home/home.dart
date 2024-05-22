import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final signOutButton = ElevatedButton(
      onPressed: () async {
        await authService.signOut();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 118, 135, 143),
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
      child: Text(
        "Login Page",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(" "),
      ),
      body: Center(
        child: signOutButton,
      ),
    );
  }
}
