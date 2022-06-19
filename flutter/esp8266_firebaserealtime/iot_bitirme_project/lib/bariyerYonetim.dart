import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/myDrawer.dart';
import 'package:iot_bitirme_project/camera.dart';

import 'package:firebase_database/firebase_database.dart';


final dbR = FirebaseDatabase.instance.ref();
final _database = FirebaseDatabase.instance.reference();

class BariyerYonetim extends StatefulWidget {
  @override
  _BariyerYonetimState createState() => _BariyerYonetimState();
}


class _BariyerYonetimState extends State{
  bool On = false;
  bool On1 = false;
  bool On2 = false;
  bool On3 = false;
  bool ahiryangin = false;
  String _havaText = 'Hava :';
  String _AhiryanginAlarmText= '';
  void initState() {
    super.initState();
    _sicaklikNemGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Ahır Yönetimi"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.park,
                  size: 100,
                  color: Colors.deepOrange,
                ),
                ahiryangin ? Image(
                  image: AssetImage("resimler/kapa_yangınalarm.png"),
                  width: 70,
                  height: 70,
                )
                    : Image(
                  image: AssetImage("resimler/ac_yangınalarm.png"),
                  width: 70,
                  height: 70,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_havaText +" PPM"),
                Text(_AhiryanginAlarmText),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                On2 ? Icon(
                  Icons.lightbulb,
                  size: 100,
                  color: Colors.amber,
                ) : Icon(
                  Icons.lightbulb_outline,
                  size: 100,
                ),
                On3 ? Icon(
                  Icons.water,
                  size: 100,
                  color: Colors.blue,
                ) : Icon(
                  Icons.water_outlined,
                  size: 100,
                ),
              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: On2 ? Colors.white10 : Colors.grey),
                    onPressed: () {
                      dbR.child("Led").set({"Durumu":!On2});
                      setState(() {
                        On2 = !On2;
                      });
                    },
                    child: On2 ? Text("Aydınlatma Açık",
                      style: TextStyle(color: Colors.black),
                    ) :
                    Text("Aydınlatma Kapalı",
                      style: TextStyle(color: Colors.black),
                    )),
                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: On3 ? Colors.white10 : Colors.grey),
                    onPressed: () {
                      dbR.child("Fan").set({"Durumu":!On3});
                      setState(() {
                        On3 = !On3;
                      });
                    },
                    child: On3 ? Text("Havalandırma Açık") : Text("Havalandırma Kapalı")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                On ? Image(
                  image: AssetImage("resimler/ac_kamerasistemi.png"),
                  width: 160,
                  height: 160,
                )  : Image(
                  image: AssetImage("resimler/kapa_kamerasistemi.png"),
                  width: 160,
                  height: 160,
                ) ,

              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                    onPressed: () {setState(() {
                      On = !On;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KameraYonetim(),
                      ),);
                    },
                    child:  Text("Kamera Sistemini Aç",
                      style: TextStyle(color: Colors.black),
                    )
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
  void _sicaklikNemGet() {

    _database
        .child('/ahirco2')
        .onValue
        .listen((event) {
      final Object? ahirco2 = event.snapshot.value;
      setState(() {
        if (ahirco2 != null) {
          _havaText = 'Hava : $ahirco2';
        }
        else{
          setState(() {
            _havaText = 'Hava : 400';
          });
        }
      });
    });
    _database.child('/ahiryansensorpin').onValue.listen((event) {
      final Object? yanginsensorahir = event.snapshot.value;
      setState(() {
        if (yanginsensorahir == 0) {
          _AhiryanginAlarmText = 'Yangın Var';
          ahiryangin = false;
        } else {
          _AhiryanginAlarmText = 'Yangın Yok';
          ahiryangin = true;
        }
      });
    });

  }
}