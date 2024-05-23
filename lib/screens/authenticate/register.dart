import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/services/auth.dart';
import 'package:flutter_project/models/login_user.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  const Register({super.key, this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _showHide = true;
  bool _showAnimation = false;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _globalKey =
      GlobalKey<FormState>(); // inisialisasi pengiriman data
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      autofocus: false,
      validator: (value) {
        if (value!.contains('@') && value!.endsWith('.com')) {
          return null;
        }
        return 'Invalid Email!';
      },
    );

    final passwordField = TextFormField(
      obscureText: _showHide,
      controller: _password,
      decoration: InputDecoration(
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: Icon(
                _showHide ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _showHide = !_showHide;
                });
              })),
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty || value == null) {
          return 'Invalid Password!';
        }
        return null;
      },
    );

    final txtButton = TextButton(
      onPressed: () {
        widget.toggleView!();
      },
      child: Text(
        "Switch To Login",
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
    );

    final registerEmailPasswordButton = ElevatedButton(
      onPressed: () async {
        if (_globalKey.currentState!.validate()) {
          dynamic result = await _authService.registerEmailPassword(
              LoginUser(email: _email.text, password: _password.text));
          if (result.uid == null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(result.code),
                );
              },
            );
          } else {
            setState(() {
              _showAnimation = true;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Lottie.asset('assets/animation/checkmark2.json'),
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Text('Registered Successfully! UID: ${result.uid}'),
                      ],
                    ),
                  );
                }).then((_) async {
              await Future.delayed(Duration(seconds: 1));
              setState(() {
                _showAnimation = false;
              });
            });
          }
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromARGB(255, 200, 230, 255), // Warna blok tombol
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 13),
      ),
      child: Text(
        "Register",
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'REGISTER',
            style:
                TextStyle(height: 3, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Form(
            key: _globalKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emailField,
                  SizedBox(height: 10),
                  passwordField,
                  SizedBox(height: 10),
                  txtButton,
                  SizedBox(height: 8),
                  registerEmailPasswordButton,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
