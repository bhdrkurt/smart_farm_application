import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/splashscreen/anasayfa.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(home: MyApp()));

}

class MyApp extends StatefulWidget {

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Anasayfa()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splash.png"),
                  fit: BoxFit.cover)
          ),
        )
    ) ;
  }
}