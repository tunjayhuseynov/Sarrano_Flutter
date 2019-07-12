import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: OpeningScene()));

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
            flex: 4,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Text("This is the result of scan: $qrText"),
                RaisedButton(
                  onPressed: () {
                    if (controller != null) {
                      controller.flipFlash();
                    }
                  },
                  child: Text('Flip', style: TextStyle(fontSize: 20)),
                )
              ],
            ),
            flex: 1,
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    final channel = controller.channel;
    controller.init(qrKey);
    this.controller = controller;
    channel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "onRecognizeQR":
          dynamic arguments = call.arguments;
          setState(() {
            qrText = arguments.toString();
          });
      }
    });
  }
}

class OpeningScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OpeningState();
  }
}

class OpeningState extends State<OpeningScene> {
  @override
  void initState() {
    super.initState();

    setState(() {
      Future.delayed(Duration(milliseconds: 1000)).then((_) async {
        var prefs = await SharedPreferences.getInstance();
        var id = prefs.getInt("id") ?? 0;
        var token = prefs.getString('token') ?? null;

        if (id != 0 && token != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileProcess()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home",
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            backgroundColor: Color.fromRGBO(100, 100, 200, 1),
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sarrano",
      home: Scaffold(
        body: Center(
          child: Text("aefeaf"),
        ),
      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInPageState();
  }
}

final _formKey = GlobalKey<FormState>();
final _formKey2 = GlobalKey<FormState>();
final loginPhoneNumber = TextEditingController();
final loginPassword = TextEditingController();
final regPhomneNUmber = TextEditingController();
final regEmail = TextEditingController();
final regPassword = TextEditingController();
final regName = TextEditingController();
final regSurname = TextEditingController();
final regBirth = TextEditingController();
final regSex = TextEditingController();

class LogInPageState extends State<LogInPage> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: new PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: new Container(
                color: Colors.green,
                child: new SafeArea(
                  child: Column(
                    children: <Widget>[
                      new Expanded(child: new Container()),
                      new TabBar(
                        labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        tabs: [new Text("Giriş"), new Text("Qeydiyyat")],
                        indicatorColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 200,
                            child: TextFormField(
                              controller: loginPhoneNumber,
                              decoration: InputDecoration(
                                  labelText: "Telefon Nömrəsi ",
                                  labelStyle: TextStyle(color: Colors.green),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Nömrə daxil edin";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: loginPassword,
                              decoration: InputDecoration(
                                  labelText: "Şifrə ",
                                  labelStyle: TextStyle(color: Colors.green),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Şifrə daxil edin";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusElevation: 5,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                            },
                            child: Text(
                              "Daxil Ol",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            child: TextFormField(
                              controller: regPhomneNUmber,
                              decoration: InputDecoration(
                                  labelText: "Telefon Nömrəsi ",
                                  labelStyle: TextStyle(color: Colors.green),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Nömrə daxil edin";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: regEmail,
                              decoration: InputDecoration(
                                  labelText: "E-Poçt Adressi ",
                                  labelStyle: TextStyle(color: Colors.green),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "E-poçta saxil edin";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: regPassword,
                              decoration: InputDecoration(
                                  labelText: "Şifrə ",
                                  labelStyle: TextStyle(color: Colors.green),
                                  fillColor: Colors.white,
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.green, width: 0.5),
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Şifrə daxil edin";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              obscureText: true,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 6,
                            onPressed: () {
                              if (_formKey2.currentState.validate()) {}
                            },
                            child: Text(
                              "Qeydiyyata Dəvam",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ProfileProcess extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Profile",
        home: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _image == null
                        ? new Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("images/unknown.jpeg"),
                                )))
                        : new Container(
                            width: 150.0,
                            height: 150.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Image.file(_image).image,
                                ))),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Text(
                        "Şəkil Seç",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 180,
                      child: TextFormField(
                        controller: regName,
                        decoration: InputDecoration(
                            labelText: "Ad ",
                            labelStyle: TextStyle(color: Colors.green),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0))),
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
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      width: 180,
                      child: TextFormField(
                        controller: regSurname,
                        decoration: InputDecoration(
                            labelText: "Soyad ",
                            labelStyle: TextStyle(color: Colors.green),
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.green, width: 0.5),
                                borderRadius: BorderRadius.circular(10.0))),
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
                                labelStyle: TextStyle(color: Colors.green),
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.green, width: 0.5),
                                    borderRadius: BorderRadius.circular(10.0))),
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
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 6,
                      onPressed: () {
                        if (_formKey2.currentState.validate()) {}
                      },
                      child: Text(
                        "Tamamla",
                        style: TextStyle(color: Colors.white),
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
