import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/signup_screen.dart';
import 'package:untitled1/screens/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//const primaryColor = Color(0xFF151026);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      /*
      theme: ThemeData(
        primaryColor: primaryColor,
      ),*/
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: LoginScreen(),
      ),
      routes: {
        '/home': (context) => SteamGamesList(),
        //'/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}


/*import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled1/blocs/auth/auth_bloc.dart';
import 'package:untitled1/screens/login_screen.dart';
import 'package:untitled1/screens/signup_screen.dart';
import 'package:untitled1/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//const primaryColor = Color(0xFF151026);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      /*
      theme: ThemeData(
        primaryColor: primaryColor,
      ),*/
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: LoginScreen(),
      ),
      routes: {
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignupScreen(),
      },
    );
  }
}*/