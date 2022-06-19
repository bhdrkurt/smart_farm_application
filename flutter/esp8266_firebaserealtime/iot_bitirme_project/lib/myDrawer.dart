import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/arabaYonetim.dart';
import 'package:iot_bitirme_project/bariyerYonetim.dart';
import 'package:iot_bitirme_project/evYonetim.dart';
import 'package:iot_bitirme_project/garajYonetim.dart';
import 'package:iot_bitirme_project/main.dart';
import 'package:iot_bitirme_project/splashscreen/anasayfa.dart';
import 'package:iot_bitirme_project/tarlaYonetim.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyDrawerState();
}

class _MyDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("resimler/logo.png"),
                    width: 108,
                    height: 108,
                  ),
                  Text(
                    "Akıllı Çiftlik Kontrol",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Anasayfa'),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Anasayfa(),
                ),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.perm_device_information),
            title: Text('Ev Yönetimi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EvYonetim(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.local_laundry_service),
            title: Text('Tarla Yönetimi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TarlaYonetim(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Ahır Sistemi'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BariyerYonetim(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}