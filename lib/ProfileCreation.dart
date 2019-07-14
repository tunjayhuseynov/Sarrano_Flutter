import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'main.dart';

final _formKey3 = GlobalKey<FormState>();
final regName = TextEditingController();
final regSurname = TextEditingController();
final regBirth = TextEditingController();
final regSex = TextEditingController();

class ProfileProcess extends StatefulWidget {
  const ProfileProcess({
    Key key,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ProfileProcessState();
  }
}

class ProfileProcessState extends State<ProfileProcess> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        regBirth.text = DateFormat("yyyy-MM-dd").format(picked);
        print(regBirth.text);
      });
  }

//  CREATEING A PROFILE VIA REGISTRATION
  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return MaterialApp(
        title: "Profile",
        home: Scaffold(
          key: key,
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //IMAGE OF USER
                    _image == null
                        ? GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: new Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 2.5,
                                        color:
                                            Color.fromRGBO(176, 106, 179, 1)),
                                    image: new DecorationImage(
                                      fit: BoxFit.contain,
                                      image: AssetImage("images/unknown.jpeg"),
                                    ))),
                          )
                        : new Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                                border: Border.all(
                                    width: 2.5,
                                    color: Color.fromRGBO(176, 106, 179, 1)),
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.file(_image).image,
                                ))),
                    SizedBox(
                      height: 20,
                    ),
                    //BUTTON OF SELECTION OF AN IMAGE
                    // RaisedButton(
                    //   onPressed: () {
                    //     getImage();
                    //   },
                    //   child: Text(
                    //     "Şəkil Seç",
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   color: Colors.green,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    //NAME BOX
                    Container(
                      width: 180,
                      child: TextFormField(
                        controller: regName,
                        decoration: InputDecoration(
                          labelText: "Ad ",
                          labelStyle: TextStyle(
                              foreground: Paint()..shader = inputColor),
                          fillColor: Colors.white,
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Adınızı Daxil Edin";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    //SURNAME BOX
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      width: 180,
                      child: TextFormField(
                        controller: regSurname,
                        decoration: InputDecoration(
                          labelText: "Soyad ",
                          labelStyle: TextStyle(
                              foreground: Paint()..shader = inputColor),
                          fillColor: Colors.white,
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Soyadınızı Daxil Edin";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    //BIRTH DATE BOX
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                        width: 180,
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: regBirth,
                            decoration: InputDecoration(
                              labelText: "Doğum Tarixi ",
                              labelStyle: TextStyle(
                                  foreground: Paint()..shader = inputColor),
                              fillColor: Colors.white,
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Doğum Tarixinizi Daxil Edin";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: null,
                            obscureText: false,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    //OKAY BUTTON
                    RaisedButton(
                      padding: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 6,
                      onPressed: () {
                        if (_formKey3.currentState.validate() &&
                            _image != null) {
                          print("Done");
                        } else {
                          key.currentState.showSnackBar(new SnackBar(
                            content: new Text("Şəkil Əlavə Edin"),
                          ));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        decoration: BoxDecoration(gradient: mainColor),
                        child: Text(
                          "Tamamla",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
