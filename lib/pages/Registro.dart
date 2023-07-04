import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/imagens.dart';
import 'package:billeteramovil/routes/route_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../faceModule/error_snackbar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Registro extends StatefulWidget {
  const Registro({Key? key}) : super(key: key);

  @override
  State<Registro> createState() => _RegisterState();
}

class _RegisterState extends State<Registro> {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final firebase = FirebaseFirestore.instance;
  File? imgn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            TextField(
              controller: nombre,
              decoration: InputDecoration(
                  hintText: "Nombre",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.credit_card)),
            ),
            SizedBox(height: 8),
            TextField(
              controller: apellido,
              decoration: InputDecoration(
                  hintText: "Apellidos",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none),
                  fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.credit_card)),
            ),
            SizedBox(height: 10),
            TextField(
              controller: telefono,
              decoration: InputDecoration(
                hintText: "Telefono",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none),
                fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.email),
              ),
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
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            imgn != null
                ? Image.file(imgn!)
                : Container(
                    height: 150,
                    width: 150,
                    color: Colors.grey,
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                  ),
            SizedBox(height: 10),
            InkWell(
              onTap: () async {
                final img = await getImage();
                setState(() {
                  imgn = File(img!.path);
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.camera,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Register();
                },
                child: const Text('Registrar')),
          ],
        ),
      ),
    );
  }

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = (await picker.pickImage(source: ImageSource.camera));
    return image;
  }

  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  saveuser() async {
    try {
      await firebase.collection('users').doc().set({
        "nombre": nombre.text,
        "apellidos": apellido.text,
        "telefono": telefono.text,
        "email": email.text,
        "password": pass.text,
      });
      print(' registro exitoso');
      Get.offNamed(RouteNames.signIn);
    } catch (e) {
      print(e);
      print('Algo salio mal');
    }
  }

  void Register() {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          await _auth.createUserWithEmailAndPassword(
            email: email.text.trim(),
            password: pass.text,
          );
          uploadImage(imgn!, email.text);
          saveuser();

          Get.offNamed(RouteNames.signIn);
        } on FirebaseAuthException catch (e) {
          Get.showSnackbar(ErrorSnackbar(e.message ?? e.code));
        }
      },
    );
  }
}
