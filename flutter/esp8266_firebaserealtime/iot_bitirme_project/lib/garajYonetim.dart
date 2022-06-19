import 'package:flutter/material.dart';
import 'package:iot_bitirme_project/myDrawer.dart';
class GarajYonetim extends StatefulWidget {
  @override
  _GarajYonetimState createState() => _GarajYonetimState();

}


class _GarajYonetimState extends State{
  bool ac = false;
  bool On1 = false;

  String _sicaklikText = 'Hırsız Alarm Sistemi     ';
  String _nemText = 'Nem =';
  String _havaText = 'Hava =';
  String _toprakText = 'Toprak =';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Akıllı Garaj Kontrol"),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              children: [
                Image(
                  image: AssetImage("resimler/hırsızalarmsistemi.png"),
                  width: 80,
                  height: 80,
                ),
                Text(_sicaklikText,
                  style: TextStyle(color: Colors.white),
                ),
                Text(" "),
                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: ac ? Colors.green : Colors.white10),
                    onPressed: () {
                      setState(() {
                        ac = !ac;
                      });
                    },
                    child: ac ? Text("Aktif",
                      style: TextStyle(color: Colors.black),
                    ) :
                    Text("Pasif",
                      style: TextStyle(color: Colors.black),
                    )),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                On1 ? Image(
                  image: AssetImage("resimler/kapa_garajkapısı.png"),
                  width: 120,
                  height: 120,
                  ) :
                Image(
                    image: AssetImage("resimler/ac_garajkapısı.png"),
                    width: 120,
                    height: 120,
                    ) ,

              ],

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: On1 ? Colors.green : Colors.white10),
                    onPressed: () {
                      setState(() {
                        On1 = !On1;
                      });
                    },
                    child: On1 ? Text("Garaj Kapısı Açık",
                      style: TextStyle(color: Colors.black),
                    ) :
                    Text("Garaj Kapısı Kapalı",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

}