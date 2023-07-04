import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Imagens extends StatefulWidget {
  const Imagens({
    Key? key,
  }) : super(key: key);
  @override
  State<Imagens> createState() => _ImagensState();
}

class _ImagensState extends State<Imagens> {
  File? imgn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('preva')),
      body: Column(
        children: [
          imgn !=null? Image.file(imgn!) :Container(
            height: 120,
            width: 120,
            margin: EdgeInsets.all(10),
          ),
          ElevatedButton(
              onPressed: () async {
                final img = await getImage();
                setState(() {
                  imgn = File(img!.path);

                });
              },
              child: const Text('camara')),
          ElevatedButton(onPressed: () {}, child: const Text('subir')),
        ],
      ),
    );
  }
}

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = (await picker.pickImage(source: ImageSource.camera));
  return image;
}
