import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService authService = new AuthService();

  @override
  Widget build(BuildContext context) {
    final signOut = Material(
      child: MaterialButton(
        onPressed: () async {
          await authService.signOut();
        },
        child: Text("Ke Halaman Login"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: signOut,
      ),
    );
  }
}
