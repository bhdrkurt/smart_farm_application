import 'package:flutter/material.dart';


class barnDoorPage extends StatefulWidget {
  const barnDoorPage({Key? key, required this.sendMessageO , required this.sendMessageC}) : super(key: key);
  final Function sendMessageO;
  final Function sendMessageC;


  @override
  _barnDoorPageState createState() => _barnDoorPageState();
}

class _barnDoorPageState extends State<barnDoorPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20.0,
              width: 150.0,
              child: Center(
                child: Text(""),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Positioned(
              top: .0,
              left: .0,
              right: .0,
              child: Center(
                child: ClipRRect(
                  child: Container(

                    height: 20.0,
                    width: 350,
                    color: Colors.grey[800],
                    child: Center(

                      child: Text("Ahır Kapısı Kontrol Paneli",
                        style: TextStyle(color: Colors.white, fontSize: 15),),
                    ),

                  ),
                ),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 20.0,
              width: 150.0,
              child: Center(
                child: Text(""),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () {
            widget.sendMessageO();
          },
          child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green,
              child: Text(
                "AÇ",
                style: TextStyle(color: Colors.black, fontSize: 20),
              )),
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(
            onTap: () {
              widget.sendMessageC();
            },
            child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.redAccent,
                child: Text(
                  "KAPAT",
                  style: TextStyle(color: Colors.grey[400], fontSize: 20),
                ))),

      ],
    );
  }
}
