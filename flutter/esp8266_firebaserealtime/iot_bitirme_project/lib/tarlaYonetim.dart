import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/myDrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';



final databaseReference = FirebaseDatabase.instance.reference();
final FirebaseAuth _auth = FirebaseAuth.instance;

class TarlaYonetim extends StatefulWidget {
  @override
  _TarlaYonetimState createState() => _TarlaYonetimState();
}


class _TarlaYonetimState extends State{
  bool ac = false;
  bool On1 = false;


  final dbR = FirebaseDatabase.instance.ref();
  final _database = FirebaseDatabase.instance.reference();

  String _sicaklikText = '';
  String _nemText = 'Nem =';
  String _havaText = 'Hava =';
  String _toprakText = 'Toprak =';
  void initState() {
    super.initState();
    _sicaklikNemGet();
  }

  @override


  Widget build(BuildContext context) {
    _sicaklikNemGet();
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Tarla Yönetimi"),
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

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_sicaklikText,
                  style: TextStyle(color: Colors.white),
                ),
                Text(_nemText + " %"), //water_damage
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.water_damage,
                  size: 100,
                  color: Colors.brown,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(_toprakText,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ac ? Image(
                  image: AssetImage("resimler/sulamasistemi_acik.png"),
                  width: 270,height: 170,
                ) : Image(
                  image: AssetImage("resimler/sulamasistemi_kapali.png"),
                  width: 270,height: 170,
                ),

              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ac ? Colors.green : Colors.white10),
                    onPressed: () {
                      dbR.child("SulamaSistemi").set({"Durumu":!ac});

                      setState(() {
                        ac = !ac;
                      });
                    },
                    child: ac ? Text("Sulama Sistemi Açık",
                      style: TextStyle(color: Colors.black),
                    ) :
                    Text("Sulama Sistemi Kapalı",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _sicaklikNemGet() {
    _database
        .child('/sicaklik')
        .onValue
        .listen((event) {
      final Object? sicaklik = event.snapshot.value;
      String sicaklik1 = sicaklik.toString();
      sicaklik1 = (double.tryParse(sicaklik1) ?? 0).toStringAsFixed(2);
      if (sicaklik != null) {
        setState(() {
          _sicaklikText = 'Sıcaklık : $sicaklik1';
        });
      }
      else
      {
        setState(() {
          _sicaklikText = 'Sicaklik : 0';
        });
      }
    });
    _database
        .child('/nem')
        .onValue
        .listen((event) {
      final Object? nem = event.snapshot.value;
      String nem1 = nem.toString();
      nem1= (double.tryParse(nem1) ?? 0).toStringAsFixed(2);
      setState(() {
        _nemText = 'Nem : $nem1';
      });
    });
    _database
        .child('/sicaklik')
        .onValue
        .listen((event) {
      final Object? topraknemi = event.snapshot.value;
      if (topraknemi != null) {
        setState(() {
          _toprakText = 'Toprak Nem : $topraknemi';
        });
      }
      else
      {
        setState(() {
          _toprakText = 'Toprak Nem : 50 %';
        });
      }
    });
  }
}