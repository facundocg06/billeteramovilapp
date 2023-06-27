import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/imagens.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  File? imgn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('material app bar'),
      ),
      body: Column(
        children: [
          Container(
            height: 180,
            width: 180,
            color: Colors.grey,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
          ),
          ElevatedButton(
              onPressed: () async {
                final imagen = await getImage(ImageSource.camera);
                setState(() {
                  imgn = File(imagen!.path);
                });
              },
              child: const Text('subir foto')),
          ElevatedButton(onPressed: () {}, child: const Text('tomar foto')),
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
        ],
      ),
    );
  }
}
