library send_messagee;

import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';
import 'package:animated_stack/animated_stack.dart';
import 'package:denemeler/barnDoorPage.dart';
import 'package:denemeler/garageDoorPage.dart';
import 'package:denemeler/car_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
class ChatPage extends StatefulWidget {
  final BluetoothDevice? server;
  const ChatPage({
    Key? key,
    this.server,
  }) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  BluetoothConnection? connection;
  final ScrollController listScrollController = ScrollController();
  bool isConnecting = true;
  bool get isConnected => connection != null && connection!.isConnected;
  bool isDisconnecting = false;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'Çiftlik'),
    Tab(text: 'Garaj'),
    Tab(text: 'Araba')
  ];
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: myTabs.length, vsync: this);
    BluetoothConnection.toAddress(widget.server!.address).then((_connection) {
      print('Cihaza bağlanıldı');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });}); }
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
    super.dispose();
  }
  bool btnColor = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          controller: _controller,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Align(
              alignment: Alignment.center,
              child: barnDoorPage(
                sendMessageO: () => _sendMessage('o'),
                sendMessageC: () => _sendMessage('c'),
              )),
          Align(
            alignment: Alignment.center,
            child: garageDoorPage(
              sendMessageA: () => _sendMessage('A'),
              sendMessageK: () => _sendMessage('K'),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: carControl(
              sendMessageW: () => _sendMessage('w'),
              sendMessageA: () => _sendMessage('a'),
              sendMessageS: () => _sendMessage('s'),
              sendMessageD: () => _sendMessage('d'),

              sendMessage1: () => _sendMessage('1'),
              sendMessage2: () => _sendMessage('2'),
              sendMessage3: () => _sendMessage('3'),

              sendMessageL: () => _sendMessage('l'),
              sendMessageF: () => _sendMessage('f'),
              sendMessageK: () => _sendMessage('k'),
              sendMessageP: () => _sendMessage('p'),


              sendMessageG: () => _sendMessage('g'),
              sendMessageH: () => _sendMessage('h'),
              sendMessageY: () => _sendMessage('y'),

              sendMessageT: () => _sendMessage('t'),
              sendMessageU: () => _sendMessage('u'),
            ),
          ),
        ],
      ),
    );
  }
  _sendMessage(String text) async {
    text = text.trim();
    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text)));
        await connection!.output.allSent;
      } catch (e) {
      }
    }
  }
}
