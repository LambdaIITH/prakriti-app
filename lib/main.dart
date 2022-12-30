import 'package:flutter/material.dart';
import 'package:prakriti_app/pages/auth_page.dart';
import 'package:prakriti_app/pages/home_page.dart';
import 'package:prakriti_app/providers/fauna_provider.dart';
import 'package:prakriti_app/providers/flora_provider.dart';
import 'package:prakriti_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FaunaProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FloraProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthPage(),
        routes: {
          '/home_page': (context) => const HomePage(),
          '/details': (context) => const AuthPage(),
        },
      ),
    
    );
  }
}
