import 'package:crypto_wallet/ui/addview.dart';
import 'package:crypto_wallet/ui/authentication.dart';
import 'package:crypto_wallet/ui/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Wallet',
      initialRoute: '/',
      routes: {
        '/': (context) => Authentication(),
        '/addview' : (context) => AddView(),
        '/homeview' : (context) => HomeView(),
      },

    );
  }
}

