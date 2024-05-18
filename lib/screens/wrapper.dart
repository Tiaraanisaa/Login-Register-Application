import 'package:flutter/material.dart';
import 'package:flutter_project/models/firebase_user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/screens/authenticate/handler.dart';
import 'package:flutter_project/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);

    if (user == null) {
      return Handler();
    } else {
      return Home();
    }
  }
}
