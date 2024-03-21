import 'package:chillmate/data/firebase_api.dart';
import 'package:flutter/material.dart';
import 'screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chillmate/firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Mitr'),

      home: LoginPage(),
      // routes: {
      //   NotiPage.route:(context) => const NotificationListener(child: child)
      // },
    );
  }
}
