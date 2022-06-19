import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/myDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;

class EvYonetim extends StatefulWidget {
  @override
  _EvYonetimState createState() => _EvYonetimState();
}

class _EvYonetimState extends State {
  final database = FirebaseDatabase.instance.reference();
  bool aydinlatma = false;
  bool havalandirma = false;
  bool sogutma = false;
  bool isitma = false;
  bool hirsiz = false;
  bool yangin = false;
  bool sokaklamba = false;

  final dbR = FirebaseDatabase.instance.ref();
  final _database = FirebaseDatabase.instance.reference();

  String _sicaklikText = '';
  String _nemText = 'Nem :';
  String _havaText = 'Hava :';
  String _yanginAlarmText = '';
  String _hirsizAlarmText = '';

  void initState() {
    super.initState();
    _degerGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Akıllı Ev Kontrol"),
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
                  Icons.device_thermostat,
                  size: 100,
                  color: Colors.redAccent,
                ),
                Icon(
                  Icons.water_damage,
                  size: 100,
                  color: Colors.blueAccent,
                ),
                Icon(
                  Icons.park,
                  size: 100,
                  color: Colors.lightGreen,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  _sicaklikText,
                  style: TextStyle(color: Colors.white),
                ),
                Text(_nemText + " %"), //water_damage
                Text(_havaText + " PPM"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                hirsiz
                    ? Image(
                        image: AssetImage("resimler/hırsızalarmsistemi.png"),
                        width: 100,
                        height: 100,
                      )
                    : Image(
                        image:
                            AssetImage("resimler/kapa_hırsızalarmsistemi.png"),
                        width: 100,
                        height: 100,
                      ),
                yangin
                    ? Image(
                        image: AssetImage("resimler/kapa_yangınalarm.png"),
                        width: 100,
                        height: 100,
                      )
                    : Image(
                        image: AssetImage("resimler/ac_yangınalarm.png"),
                        width: 100,
                        height: 100,
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
                aydinlatma
                    ? Icon(
                        Icons.lightbulb,
                        size: 100,
                        color: Colors.amber,
                      )
                    : Icon(
                        Icons.lightbulb_outline,
                        size: 100,
                      ),
                havalandirma
                    ? Icon(
                        Icons.water,
                        size: 100,
                        color: Colors.blue,
                      )
                    : Icon(
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
                        backgroundColor:
                            aydinlatma ? Colors.white10 : Colors.grey),
                    onPressed: () {
                      dbR.child("Aydinlatma").set({"Durumu": !aydinlatma});
                      setState(() {
                        aydinlatma = !aydinlatma;
                      });
                    },
                    child: aydinlatma
                        ? Text(
                            "Aydınlatma Açık",
                            style: TextStyle(color: Colors.black),
                          )
                        : Text(
                            "Aydınlatma Kapalı",
                            style: TextStyle(color: Colors.black),
                          )),
                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            havalandirma ? Colors.white10 : Colors.grey),
                    onPressed: () {
                      dbR.child("Havalandirma").set({"Durumu": !havalandirma});
                      setState(() {
                        havalandirma = !havalandirma;
                      });
                    },
                    child: havalandirma
                        ? Text("Havalandırma Açık")
                        : Text("Havalandırma Kapalı")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                havalandirma
                    ? Image(
                        image: AssetImage("resimler/sogutmasistemi.png"),
                        width: 100,
                        height: 100,
                      )
                    : Image(
                        image: AssetImage("resimler/kapa_sogutmasistemi.png"),
                        width: 100,
                        height: 100,
                      ),
                isitma
                    ? Image(
                        image: AssetImage("resimler/ısıtmasistemi.png"),
                        width: 100,
                        height: 100,
                      )
                    : Image(
                        image: AssetImage("resimler/kapa_ısıtmasistemi.png"),
                        width: 100,
                        height: 100,
                      ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor:
                            havalandirma ? Colors.white10 : Colors.grey),
                    onPressed: () {
                      dbR.child("sogutma").set({"Durumu": !havalandirma});
                      setState(() {
                        havalandirma = !havalandirma;
                      });
                    },
                    child: havalandirma
                        ? Text("Soğutma Sistemi Açık")
                        : Text("Soğutma Sistemi Kapalı")),
                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: isitma ? Colors.white10 : Colors.grey),
                    onPressed: () {
                      dbR.child("isitma").set({"Durumu": !isitma});
                      setState(() {
                        isitma = !isitma;
                      });
                    },
                    child: isitma
                        ? Text("Isıtma Sistemi Açık")
                        : Text("Isıtma Sistemi Kapalı")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _degerGet() {
    _database.child('/evsicaklik').onValue.listen((event) {
      final Object? sicaklik = event.snapshot.value;
      String sicaklik1 = sicaklik.toString();
      sicaklik1 = (double.tryParse(sicaklik1) ?? 0).toStringAsFixed(2);
      if (sicaklik != null) {
        setState(() {
          _sicaklikText = 'Sıcaklık : $sicaklik1';
        });
      } else {
        setState(() {
          _sicaklikText = 'Sicaklik : 0';
        });
      }
    });
    _database.child('/evnem').onValue.listen((event) {
      final Object? nem = event.snapshot.value;
      String nem1 = nem.toString();
      nem1 = (double.tryParse(nem1) ?? 0).toStringAsFixed(2);
      setState(() {
        _nemText = 'Nem : $nem1';
      });
    });
    _database.child('/havakalite').onValue.listen((event) {
      final Object? co2 = event.snapshot.value;
      setState(() {
        _havaText = 'Hava : $co2';
      });
    });
    _database.child('/yansensorpinev').onValue.listen((event) {
      final Object? yanginsensor = event.snapshot.value;
      setState(() {
        if (yanginsensor == 0) {
          _yanginAlarmText = 'Yangın Var';
          yangin = false;
        } else {
          _yanginAlarmText = 'Yangın Yok';
          yangin = true;
        }
      });
    });
    _database.child('/hareketsensorpin').onValue.listen((event) {
      final Object? hareketsensor = event.snapshot.value;
      setState(() {
        if (hareketsensor == 0) {
          _hirsizAlarmText = 'Hareket Var';
          hirsiz = false;
        } else {
          _hirsizAlarmText = 'Hareket Yok';
          hirsiz = true;
        }
      });
    });
  }
}
