import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/route_names.dart';


FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVecino() async {
  List vecinos = [];
  CollectionReference colectionReferenceUser = db.collection('vecinos');
  QuerySnapshot qusers = await colectionReferenceUser.get();
  qusers.docs.forEach((docu) {
    vecinos.add(docu.data());
  });

  return vecinos;
}


Future<void> addVecino(List vecinos) async {
  await db.collection('vecinos').add(vecinos.first);
}

class AuthController extends GetxController {
  AuthController();

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) Get.offAllNamed(RouteNames.signIn);
    });
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;
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
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(width: 1, color: Colors.grey))),
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
              ],
            ),
          ),
        );
      });
}
