import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';
import 'ProfileCreation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: HomePage()));

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

final _formKey2 = GlobalKey<FormState>();
final _formKey = GlobalKey<FormState>();
final loginPhoneNumber = TextEditingController();
final loginPassword = TextEditingController();
final regPhomneNUmber = TextEditingController();
final regEmail = TextEditingController();
final regPassword = TextEditingController();


final LinearGradient mainColor = LinearGradient(
  // Where the linear gradient begins and ends
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  // Add one stop for each color. Stops should increase from 0 to 1
  stops: [0.1, 0.9],
  colors: [
    // Colors are easy thanks to Flutter's Colors class.
    Color.fromRGBO(66, 135, 245, 1),
    Color.fromRGBO(176, 106, 179, 1)
  ],
);
final Shader inputColor =
    mainColor.createShader(new Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class LogInPageState extends State<LogInPage> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Əminsiniz?'),
            content: new Text('Tətbiqatdan çıxmaq istəyirsiniz?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Xeyir'),
              ),
              new FlatButton(
                onPressed: () => exit(0),
                child: new Text('Bəli'),
              ),
            ],
          ),
        ) ??
        false;
  }

// LOGİN PAGE
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
                decoration: BoxDecoration(
                  // Box decoration takes a gradient
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // Add one stop for each color. Stops should increase from 0 to 1
                    stops: [0.1, 0.9],
                    colors: [
                      // Colors are easy thanks to Flutter's Colors class.
                      Color.fromRGBO(66, 135, 245, 1),
                      Color.fromRGBO(176, 106, 179, 1)
                    ],
                  ),
                ),
                child: new SafeArea(
                  child: Column(
                    children: <Widget>[
                      new Expanded(child: new Container()),
                      new TabBar(
                        labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        tabs: [new Text("Giriş"), new Text("Qeydiyyat")],
                        indicatorColor: Colors.blueGrey[600],
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
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
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
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
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
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            focusElevation: 5,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(gradient: mainColor),
                              child: Text(
                                "Daxil Ol",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //Registraion Form
                //
                //
                //
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
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
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
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
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
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
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
                            padding: EdgeInsets.all(0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                            focusElevation: 3,
                            onPressed: () {
                              if (_formKey2.currentState.validate()) {}
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                              decoration: BoxDecoration(gradient: mainColor),
                              child: Text(
                                "Qeydiyyata Dəvam",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
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
