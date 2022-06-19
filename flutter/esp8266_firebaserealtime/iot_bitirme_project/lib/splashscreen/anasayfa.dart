import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/arabaYonetim.dart';
import 'package:iot_bitirme_project/bariyerYonetim.dart';
import 'package:iot_bitirme_project/evYonetim.dart';
import 'package:iot_bitirme_project/garajYonetim.dart';
import 'package:iot_bitirme_project/myDrawer.dart';
import 'package:iot_bitirme_project/tarlaYonetim.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State {
  final dbR = FirebaseDatabase.instance.ref();
  final _database = FirebaseDatabase.instance.reference();

  String _sicaklikText = '';
  String _nemText = 'Nem =';
  bool sokaklamba = false;
  bool hirsiz = false;
  bool yangin = false;
  String _yanginAlarmText = '';
  String _hirsizAlarmText = '';
  bool ahirhirsiz = false;
  bool ahiryangin = false;
  String _AhiryanginAlarmText = '';
  String _AhirhirsizAlarmText = '';

  void initState() {
    super.initState();
    _AnasayfadegerGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Akıllı Çiftlik Kotrol"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            color: Colors.green,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.device_thermostat,
                      size: 100,
                      color: Colors.redAccent,),
                    Icon(
                      Icons.water_damage,
                      size: 100,
                      color: Colors.blueAccent,),],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(_sicaklikText,
                      style: TextStyle(color: Colors.white), ),
                    Text(_nemText + " %"), //water_damage
                  ],
                ),
              ],
            ),
          ),

          Container(
            color: Colors.greenAccent,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    hirsiz
                        ? Image(
                      image: AssetImage("resimler/hırsızalarmsistemi.png"),
                      width: 70,
                      height: 70,
                    )
                        : Image(
                      image: AssetImage("resimler/kapa_hırsızalarmsistemi.png"),
                      width: 70,
                      height: 70,
                    ),
                    yangin
                        ? Image(
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
                    Text(_hirsizAlarmText),
                    Text(_yanginAlarmText),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Ev Önü Kontrol"),
                    Text("Ev Yangın Alarmı"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ahirhirsiz
                        ? Image(
                      image: AssetImage("resimler/hırsızalarmsistemi.png"),
                      width: 70,
                      height: 70,
                    )
                        : Image(
                      image: AssetImage("resimler/kapa_hırsızalarmsistemi.png"),
                      width: 70,
                      height: 70,
                    ),
                    ahiryangin
                        ? Image(
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
                    Text(_AhirhirsizAlarmText),
                    Text(_AhiryanginAlarmText),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Ahır Yolu Kontrol"),
                    Text("Ahır Yangın Alarmı"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
          ),


          Container(
            color: Colors.cyan,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 2,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EvYonetim(),
                          ),); },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.black,
                        child: Image(
                          image: AssetImage("resimler/evyonetimilogo1.png"),
                          color: Colors.lightGreen,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TarlaYonetim(), ), );
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.black,
                        child: Image(
                          image: AssetImage("resimler/field.png"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Ev Yönetimi',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Tarla Yönetimi',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BariyerYonetim(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.black,
                        child: Image(
                          image: AssetImage("resimler/ahirresim1.png"),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        dbR.child("SokakLamba").set({"Durumu":!sokaklamba});
                        setState(() {
                          sokaklamba = !sokaklamba;
                        });
                      },
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.blueAccent,
                        child : sokaklamba ? CircleAvatar(
                            radius: 32,
                            backgroundColor: Colors.greenAccent,
                          child: Image(
                            image: AssetImage("resimler/sokaklambasi1.png"),
                          )):
                            Image(image: AssetImage("resimler/sokaklambasi1.png"),
                      ),
                        ),

                      ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Ahır Yönetimi',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      'Sokak Lambası',
                      style: TextStyle(fontSize: 25),
                    ),

                  ],
                ),
              ],
            ),
          )

        ],
      )),
    );
  }

  void _AnasayfadegerGet() {
    _database.child('/sicaklik').onValue.listen((event) {
      final Object? sicaklik = event.snapshot.value;
      String sicaklik1 = sicaklik.toString();
      sicaklik1 = (double.tryParse(sicaklik1) ?? 0).toStringAsFixed(2);
      if (sicaklik != null) {
        setState(() {_sicaklikText = 'Sıcaklık : $sicaklik1'; });}
      else{setState(() { _sicaklikText = 'Sicaklik : 0'; });}});
    _database.child('/nem').onValue.listen((event) {
      final Object? nem = event.snapshot.value;
      String nem1 = nem.toString();
      nem1= (double.tryParse(nem1) ?? 0).toStringAsFixed(2);
      setState(() {_nemText = 'Nem : $nem1'; });});
    _database.child('/yansensorpinev').onValue.listen((event) {
      final Object? yanginsensor = event.snapshot.value;
      setState(() {
        if (yanginsensor == 0) {
        _yanginAlarmText = 'Yangın Var';
          yangin = false;
        } else {
          _yanginAlarmText = 'Yangın Yok';
          yangin = true;} });});
    _database.child('/hareketsensorpin').onValue.listen((event) {
      final Object? hareketsensor = event.snapshot.value;
      setState(() { if (hareketsensor == 0) {
          _hirsizAlarmText = 'Hareket Var';
          hirsiz = false; }
      else {_hirsizAlarmText = 'Hareket Yok';
          hirsiz = true;} });});

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
    _database.child('/ahirhareketsensorpin').onValue.listen((event) {
      final Object? hareketsensorahir = event.snapshot.value;
      setState(() {
        if (hareketsensorahir == 0) {
          _AhirhirsizAlarmText = 'Hareket Var';
          ahirhirsiz = false;
        } else {
          _AhirhirsizAlarmText = 'Hareket Yok';
          ahirhirsiz = true;
        }
      });
    });
  }
}
