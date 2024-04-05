import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'myApp.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCsFHLKqc5bV3TzwdNh13aQDQqvQt1ajHc",
          appId: "1:655695332407:android:8a22a629cb1fe7b88febb2",
          messagingSenderId: "655695332407",
          storageBucket: "crypto-2a08e.appspot.com",
          projectId: "crypto-2a08e")
   );
  runApp(const MyApp());
}
