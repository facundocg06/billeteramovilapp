import 'package:billeteramovil/app/app.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:billeteramovil/pages/home.dart';
import 'package:billeteramovil/pages/statistics.dart';
import 'package:billeteramovil/widgets/bottomnavigationbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/model/add_date.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AdddataAdapter());
  await Hive.openBox<Add_data>('data');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // cameras = await availableCameras();
  runApp(const App());
}
