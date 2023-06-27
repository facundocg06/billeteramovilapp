import 'dart:io';
import 'package:billeteramovil/routes/route_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import '../faceModule/error_snackbar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class RegistroPage extends StatelessWidget {
  TextEditingController ci = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController telf = TextEditingController();
  File? imgn;
  final firebase = FirebaseFirestore.instance;
  String imagn1 = "images";

  saveuser() async {
    try {
      await firebase.collection('users').doc().set({
        "ci": ci.text,
        "telefono": telf.text,
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
          "Registro",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(""),
      ],
    );
  }

  opciones(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      //uploadImage(getImage(ImageSource.camera), '12')
                      final pic = getImage(ImageSource.camera);
                      // setState((){}),
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '',
                            style: TextStyle(fontSize: 16),
                          )),
                          Icon(
                            Icons.camera,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '',
                            style: TextStyle(fontSize: 16),
                          )),
                          Icon(
                            Icons.image_search,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 1, color: Colors.grey))),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            '',
                            style: TextStyle(fontSize: 16),
                          )),
                          Icon(
                            Icons.cancel,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: ci,
          decoration: InputDecoration(
              hintText: "Cedula de Identidad",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.credit_card)),
        ),
        SizedBox(height: 10),
        TextField(
          controller: telf,
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
        ElevatedButton(
          onPressed: () {
            opciones(context);
          },
          child: const Text('Subir Imagen'),
        ),
        ElevatedButton(
          onPressed: () {
            Register();
          },
          child: Text(
            "Registrar",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(onPressed: () {}, child: Text(""));
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(" "), TextButton(onPressed: () {}, child: Text(""))],
    );
  }

  void dispose() {
    email.dispose();
    pass.dispose();
    //super.dispose();
  }

  void Register() {
    Get.showOverlay(
      asyncFunction: () async {
        try {
          await _auth.createUserWithEmailAndPassword(
            email: email.text.trim(),
            password: pass.text,
          );
          comparar(imagn1);
          saveuser();
          Get.offNamed(RouteNames.signIn);
        } on FirebaseAuthException catch (e) {
          Get.showSnackbar(ErrorSnackbar(e.message ?? e.code));
        }
      },
    );
  }

  Future<XFile?> getImage(ImageSource camera) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  final FirebaseStorage storage = FirebaseStorage.instance;
  Future<bool> uploadImage(File image, String name) async {
    final String namefile = name; //image.path.split("/").last;
    Reference ref = storage.ref().child("images").child(namefile);
    final UploadTask uploadTask = ref.putFile(image);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final String url = await snapshot.ref.getDownloadURL();
    if (snapshot.state == TaskState.success) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> comparar(String s) async {
    final response = Dio().get("http://127.0.0.1:5000/compare/$s");

    return "true";
  }
}
