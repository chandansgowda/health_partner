import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:health_partner/screens/auth_gate.dart';

import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelKey: 'appointment_reminder',
            channelName: 'Appointment Reminder Notifications',
            channelDescription: 'Notification channel to alert user about Appointment',
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            channelShowBadge: true,
            enableVibration: true,
            playSound: true,
        )
      ],
      debug: true
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: AuthGate(),
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.red
      ),
    );
  }
}
