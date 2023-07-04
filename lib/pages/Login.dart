import 'dart:io';

import 'package:billeteramovil/routes/route_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../faceModule/error_snackbar.dart';
import '../services/imagens.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // final SignInController controller = Get.find<SignInController>();

  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  File? imgn;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Text(
          "Ingreso",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(""),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: email,
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.email)),
        ),
        SizedBox(height: 10),
        TextField(
          controller: pass,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.vpn_key),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final img = await getImage();
            setState(() {
              imgn = File(img!.path);
            });
            signIn();
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            primary: Color(0xff368983),
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(onPressed: () {}, child: Text("Olvido su password?"));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Aún no eres usuario? "),
        TextButton(
          onPressed: () {
            signIn1();
          },
          child: Text(
            "Registrate",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  void signIn() {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          final String name = email.text;
          uploadImage(imgn!, name);
          //comparar(name);
          await _auth.signInWithEmailAndPassword(
            email: email.text.trim(),
            password: pass.text,
          );
          Get.offNamed(RouteNames.home);
        } on FirebaseAuthException catch (e) {
          Get.showSnackbar(ErrorSnackbar(e.message ?? e.code));
        }
      },
    );
  }

  void signIn1() {
    Get.offNamed(RouteNames.registro);
  }
}

Future<String> comparar(String s) async {
  final response = Dio().get("http://127.0.0.1:5000/compare/$s");
  return "true";
}
