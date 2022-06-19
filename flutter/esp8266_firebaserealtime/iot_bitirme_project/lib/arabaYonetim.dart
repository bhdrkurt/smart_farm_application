import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/myDrawer.dart';
class ArabaYonetim extends StatefulWidget {
  @override
  _ArabaYonetimState createState() => _ArabaYonetimState();
}


class _ArabaYonetimState extends State{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Araba Kontrol"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(

        ),
      ),
    );
  }

}
