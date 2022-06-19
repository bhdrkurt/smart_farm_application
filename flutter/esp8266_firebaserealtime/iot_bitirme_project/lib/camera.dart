import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class KameraYonetim extends StatefulWidget {
  @override
  _KameraYonetimState createState() => _KameraYonetimState();
}


class _KameraYonetimState extends State{

  File? imageFile;
  ImagePicker picker = ImagePicker();


  Widget _decideImageView(){
    if(imageFile == null)
      return Text("resim seçilmedi");
    else
      return Image.file(imageFile!, width: 400,height: 400,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kamera'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _decideImageView(),
              ElevatedButton(
                onPressed: () async{
                  _showChoiseDialog(context);
                },
                child: Text("tıkla"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _openGallery(BuildContext context) async {
    var picture = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(picture!.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiseDialog(BuildContext context){
    return  showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("birini seçin"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child: Text("galeri"),
                onTap: () {
                  _openGallery(context);
                },
              ),
              GestureDetector(
                child: Text("kamera"),
                onTap: () {
                  _openCamera(context);
                },
              )
            ],
          ),
        ),
      );
    });
  }

}