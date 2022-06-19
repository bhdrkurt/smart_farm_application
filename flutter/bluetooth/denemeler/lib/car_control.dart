import 'dart:ui';

import 'package:flutter/material.dart';


class carControl extends StatefulWidget {
  const carControl({Key? key, required this.sendMessageW , required this.sendMessageA,required this.sendMessageS,required this.sendMessageD,
  required this.sendMessage1,required this.sendMessage2,required this.sendMessage3,required this.sendMessageL,required this.sendMessageF,
    required this.sendMessageK,required this.sendMessageP,required this.sendMessageT,required this.sendMessageU,
    required this.sendMessageG,required this.sendMessageH,required this.sendMessageY}) : super(key: key);
  final Function sendMessageW;
  final Function sendMessageA;
  final Function sendMessageS;
  final Function sendMessageD;
  final Function sendMessage1;
  final Function sendMessage2;
  final Function sendMessage3;

  final Function sendMessageL;
  final Function sendMessageF;
  final Function sendMessageK;
  final Function sendMessageP;


  final Function sendMessageG;
  final Function sendMessageH;
  final Function sendMessageY;

  final Function sendMessageT;
  final Function sendMessageU;


  @override
  _carControlState createState() => _carControlState();
}

class _carControlState extends State<carControl> {
  bool On =false;
  bool ileri =true;
  bool sol =true;
  bool geri =true;
  bool sag =true;
  bool stop=true;
  bool yavas=true;
  bool orta=true;
  bool hizli=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
      child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.transparent,
            ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if(ileri == true){widget.sendMessageW();
                  if(On == true){widget.sendMessageT();}}
                else{widget.sendMessageP();}
                setState(() {
                  ileri=!ileri;
                  sag=true;
                  geri=true;
                  sol=true;
                  stop=true;
                });},
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black ,
              child : ileri ?  Icon(
                 Icons.arrow_circle_up_outlined,
                  color: Colors.white,
                  size: 45.0,):
              Icon(
                Icons.arrow_circle_up_outlined,
                color: Colors.green,
                size: 45.0,
              )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if(sol == true){
                  widget.sendMessageA();
                  if(On == true){
                    widget.sendMessageT();
                  }
                }
                else{
                  widget.sendMessageP();
                }
                setState(() {
                  ileri = true;
                  sag=true;
                  geri=true;
                  stop=true;
                  sol=!sol;
                });
              },
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black ,
                  child : sol ?  Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.white,
                    size: 45.0,
                  ):
                  Icon(
                    Icons.arrow_circle_left_outlined,
                    color: Colors.green,
                    size: 45.0,
                  )),
            ),
              CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.transparent,
              ),
            GestureDetector(
              onTap: () {
                if(sag == true){
                  widget.sendMessageD();
                  if(On == true){
                    widget.sendMessageT();
                  }
                }
                else{
                  widget.sendMessageP();
                }
                setState(() {
                  sag=!sag;
                  ileri=true;
                  geri=true;
                  sol=true;
                  stop=true;
                });
              },
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black ,
                  child : sag ?  Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 45.0,
                  ):
                  Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.green,
                    size: 45.0,
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                if(geri == true){
                  widget.sendMessageS();

                if(On == true){
                  widget.sendMessageT();
                }
                }
                else{
                  widget.sendMessageP();
                }
                setState(() {
                  geri=!geri;
                  sag=true;
                  ileri=true;
                  sol=true;
                  stop=true;

                });
              },
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black ,
                  child : geri ?  Icon(
                    Icons.arrow_circle_down_outlined,
                    color: Colors.white,
                    size: 45.0,
                  ):
                  Icon(
                    Icons.arrow_circle_down_outlined,
                    color: Colors.green,
                    size: 45.0,
                  )),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                widget.sendMessageL();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child :  Icon(
                  Icons.light ,
                  color: Colors.lightGreen,
                  size: 45.0,
                ),),
            ),
            InkWell(
              onTap: () {
                widget.sendMessageK();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child :  Icon(
                  Icons.notifications ,
                  color: Colors.lightGreen,
                  size: 45.0,
                ),),
            ),

            InkWell(
              onTap: () {
                widget.sendMessageF();
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black,
                child :  Icon(
                  Icons.warning ,
                  color: Colors.lightGreen,
                  size: 45.0,
                ),),
            ),
            GestureDetector(
              onTap: () {
                if(stop == true){
                  widget.sendMessageP();
                  if(On == true){
                    widget.sendMessageU();
                  }
                }
                setState(() {
                  stop=!stop;
                  sag=true;
                  geri=true;
                  sol=true;
                  On=false;
                  ileri=true;
                });
              },
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black ,
                  child : stop ?  Icon(
                    Icons.stop_circle_sharp,
                    color: Colors.white,
                    size: 45.0,
                  ):
                  Icon(
                    Icons.stop_circle_sharp,
                    color: Colors.green,
                    size: 45.0,
                  )),
            ),
          ],
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  widget.sendMessageG();
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child :  Icon(
                    Icons.light ,
                    color: Colors.redAccent,
                    size: 45.0,
                  ),),
              ),
              InkWell(
                onTap: () {
                  widget.sendMessageH();
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child :  Icon(
                    Icons.notifications ,
                    color: Colors.redAccent,
                    size: 45.0,
                  ),),
              ),

              InkWell(
                onTap: () {
                  widget.sendMessageY();
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child :  Icon(
                    Icons.warning ,
                    color: Colors.redAccent,
                    size: 45.0,
                  ),),
              ),
              GestureDetector(
                onTap: () {
                  },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent ,
                    child : Icon(
                      Icons.stop_circle_sharp,
                      color: Colors.transparent,
                      size: 45.0,
                    )),
              ),
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

                      child: Text("Hız Seçenekleri",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                widget.sendMessage1();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),//or 15.0
                child: Container(
                    height: 35.0,
                    width: 80.0,
                    color: Color(0xffFF0E58),
                    child: Center(
                      child: Text(
                        "Yavaş",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[400], fontSize: 20),
                      ),
                    )
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.sendMessage2();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),//or 15.0
                child: Container(
                    height: 35.0,
                    width: 80.0,
                    color: Color(0xffFF0E58),
                    child: Center(
                      child: Text(
                        "Orta",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[400], fontSize: 20),
                      ),
                    )
                ),
              ),
            ),

            InkWell(
              onTap: () {
                widget.sendMessage3();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),//or 15.0
                child: Container(
                    height: 35.0,
                    width: 80.0,
                    color: Color(0xffFF0E58),
                    child: Center(
                      child: Text(
                        "Hızlı",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[400], fontSize: 20),
                      ),
                    )
                ),
              ),
            ),
          ]),


        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
        ElevatedButton(
        style: TextButton.styleFrom(
        backgroundColor: On ? Colors.white10 : Colors.grey),
        onPressed: () {
          if(On == false)
         widget.sendMessageT();
          else
            widget.sendMessageU();

          setState(() {
            On = !On;
          });
        },
        child: On ? Text("Tohumlama Açık",
          style: TextStyle(color: Colors.black),
        ) :
        Text("Tohumlama Kapalı",
          style: TextStyle(color: Colors.black),
        )
        ),
          ],
        ),


          ],
        ),
)

    );
  }
}
