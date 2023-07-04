import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<XFile?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

final FirebaseStorage storage = FirebaseStorage.instance;
Future<String?> uploadImage(File image, String name) async {
  final String namefile = name; //image.path.split("/").last;
  Reference ref = storage.ref().child("imgUsers").child(namefile);
  final UploadTask uploadTask = ref.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL();
  if (snapshot.state == TaskState.success) {
    return url;
  } else {
    return null;
  }
}
