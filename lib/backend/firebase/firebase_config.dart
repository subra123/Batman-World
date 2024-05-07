import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCySaDcTPsClQVz-24V5rPV7bUdGW9bVms",
            authDomain: "sigma-myth-415413.firebaseapp.com",
            projectId: "sigma-myth-415413",
            storageBucket: "sigma-myth-415413.appspot.com",
            messagingSenderId: "593121909679",
            appId: "1:593121909679:web:a03eb1b002a3b2273f6d5a",
            measurementId: "G-9DV32WP7MC"));
  } else {
    await Firebase.initializeApp();
  }
}
