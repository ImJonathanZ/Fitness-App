import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//THIS PICKER NEEDS TO BE IMPLEMENTED EVERYTIME A USER ADDS A NEW EXERCISE
class Picker extends StatefulWidget {
  Picker({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _showImagePicker(context);
            },
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Color(0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red[900],
                    //avater with a square boreder
                    borderRadius: BorderRadius.circular(0)),
                width: 125,
                height: 125,
                child: Icon(
                  //avater icon
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //picker to click
  void _showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Center(
              child: ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    _imageFromLibrary();
                    Navigator.of(context).pop();
                  }),
            ),
          );
        });
  }

  //choose image from library
  _imageFromLibrary() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }
}
