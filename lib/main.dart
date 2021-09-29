import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/userData_provider.dart';

import 'Screens/auth_screen_doubleForm.dart';
import 'Screens/home_screen.dart';
import 'Screens/splash_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) {
            return UserDataProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Management System',
        themeMode: ThemeMode.light,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (ctx, AsyncSnapshot<User?> authSnapshot) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else {
              if (authSnapshot.hasData && authSnapshot.data!.emailVerified) {
                return HomeScreen();
              } else {
                return AuthScreenDoubleForm();
              }
            }
          },
        ),
      ),
    );
  }
}
