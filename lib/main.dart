import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarrano_flutter/homepage.dart';
import 'package:sarrano_flutter/locationService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ProfileCreation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'API.dart';

void main() => runApp(MaterialApp(home: OpeningScene()));

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
        PermissionStatus locationStatus = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.location);
        PermissionStatus cameraStatus = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.camera);
        PermissionStatus photoStatus = await PermissionHandler()
            .checkPermissionStatus(PermissionGroup.photos);

        if (locationStatus == PermissionStatus.denied ||
            cameraStatus == PermissionStatus.denied ||
            photoStatus == PermissionStatus.denied) {
          Map<PermissionGroup, PermissionStatus> permissions =
              await PermissionHandler().requestPermissions([
            PermissionGroup.location,
            PermissionGroup.camera,
            PermissionGroup.photos
          ]);
        }

        ServiceStatus serviceStatus = await PermissionHandler()
            .checkServiceStatus(PermissionGroup.location);

        if (serviceStatus == ServiceStatus.disabled || serviceStatus == ServiceStatus.unknown) {
                    Navigator.push(
              context, MaterialPageRoute(builder: (context) => LocationService()));
              return;
        }

        var prefs = await SharedPreferences.getInstance();
        var id = prefs.getInt("id") ?? 0;
        var token = prefs.getString('token') ?? null;

        if (id != 0 && token != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogInPage()));
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
            child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(176, 106, 179, 1),
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(66, 135, 245, 1)),
              ),
            ),
            Positioned(
              child: Padding(
                padding: EdgeInsets.all(50),
                child: Image.asset(
                  "images/Logo.png",
                  filterQuality: FilterQuality.none,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class LogInPage extends StatefulWidget {
  const LogInPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LogInPageState();
  }
}

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
  final _formKey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  final loginPhoneNumber = TextEditingController();
  final loginPassword = TextEditingController();
  final regPhoneNumber = TextEditingController();
  final regEmail = TextEditingController();
  final regPassword = TextEditingController();
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

  _launchURL() async {
    const url = 'https://flutter.dev';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

// LOGİN PAGE
  bool isLoading = false;
  bool isChecked = false;
  bool isLoadingReg = false;
  final key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    RegExp phoneExp =
        RegExp("(\\+994|0)(77|70|50|51|55)[0-9]{7}", caseSensitive: false);

    RegExp emailExp = RegExp(
        "^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))",
        caseSensitive: false);

    return WillPopScope(
        onWillPop: _onWillPop,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            key: key,
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
                                helperText: "Misal: 077XXXXXXX",
                                labelText: "Telefon Nömrəsi ",
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Nömrə daxil edin";
                                } else if (!phoneExp.hasMatch(val)) {
                                  return "Düzgün nömrə daxil edin";
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
                                } else if (val.length < 6) {
                                  return "Şifrə uzunluğu ən az 6 olmalıdır";
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
                          !isLoading
                              ? RaisedButton(
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  focusElevation: 5,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      await http
                                          .get(
                                              checkUserGet +
                                                  "?Number=${loginPhoneNumber.text}&Password=${loginPassword.text}",
                                              headers: header)
                                          .then((response) async {
                                        var logRes = LogResponse.fromJson(
                                            json.decode(response.body));

                                        if (logRes.id != 0) {
                                          var prefs = await SharedPreferences
                                              .getInstance();

                                          await prefs.setInt('id', logRes.id);
                                          await prefs.setString(
                                              'token', logRes.token);

                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (contect) =>
                                                      HomePage()));
                                        } else if (logRes.isFound == true) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          key.currentState
                                              .showSnackBar(new SnackBar(
                                            content:
                                                new Text("Şifrə Yanlışdır"),
                                          ));
                                        } else {
                                          setState(() {
                                            isLoading = false;
                                            key.currentState
                                                .showSnackBar(new SnackBar(
                                              content: new Text(
                                                  "Belə nir nömrə qeydiyyatdan keçməyib"),
                                            ));
                                          });
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 10, 30, 10),
                                    decoration: BoxDecoration(
                                        gradient: mainColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Text(
                                      "Daxil Ol",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 40,
                                  padding: EdgeInsets.all(5),
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    backgroundColor:
                                        Color.fromRGBO(176, 106, 179, 1),
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Color.fromRGBO(66, 135, 245, 1)),
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
                              controller: regPhoneNumber,
                              decoration: InputDecoration(
                                helperText: "Misal: 077XXXXXXX",
                                labelText: "Telefon Nömrəsi ",
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "Nömrə daxil edin";
                                } else if (!phoneExp.hasMatch(val)) {
                                  return "Düzgün nömrə daxil edin";
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
                                helperText: "Misal: xxxxx@gmail.com",
                                labelText: "E-Poçt ",
                                labelStyle: TextStyle(
                                    foreground: Paint()..shader = inputColor),
                                fillColor: Colors.white,
                              ),
                              validator: (val) {
                                if (val.length == 0) {
                                  return "E-poçta saxil edin";
                                } else if (emailExp.hasMatch(val)) {
                                  return "E-poçtu düzgün formatda daxil edin";
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
                                } else if (val.length < 6) {
                                  return "Şifrə uzunluğu ən az 6 olmalıdır";
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
                          Container(
                              width: 200,
                              child: Row(
                                children: <Widget>[
                                  Checkbox(
                                    activeColor: Colors.white,
                                    checkColor:
                                        Color.fromRGBO(176, 106, 179, 1),
                                    value: isChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isChecked = value;
                                      });
                                    },
                                  ),
                                  Container(
                                    width: 150,
                                    child: RichText(
                                      text: TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => _launchURL(),
                                          text: "Müqaviləni",
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.blue),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text:
                                                    " oxudum və şərtlərlə razılaşıram",
                                                style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.black))
                                          ]),
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 30,
                          ),
                          !isLoadingReg
                              ? RaisedButton(
                                  padding: EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                  focusElevation: 3,
                                  onPressed: () async {
                                    if (_formKey2.currentState.validate() &&
                                        isChecked) {
                                      setState(() {
                                        isLoadingReg = true;
                                      });
                                      await http
                                          .get(
                                              checkUserGet +
                                                  "?number=${regPhoneNumber.text}&Password=",
                                              headers: header)
                                          .then((res) async {
                                        var checking = LogResponse.fromJson(
                                            json.decode(res.body));

                                        if (checking.isFound == true) {
                                          setState(() {
                                            isLoadingReg = false;
                                          });
                                          key.currentState
                                              .showSnackBar(new SnackBar(
                                            content: new Text(
                                                "Artıq bu nömrə qeydiyyatdan keçib"),
                                          ));
                                        } else {
                                          RegistrationInformation
                                              registrationInformation =
                                              new RegistrationInformation(
                                                  regEmail.text,
                                                  regPhoneNumber.text,
                                                  regPassword.text);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileProcess(
                                                      registrationInformation:
                                                          registrationInformation,
                                                    )),
                                          );
                                        }
                                      });
                                    } else if (_formKey2.currentState
                                            .validate() &&
                                        !isChecked) {
                                      key.currentState
                                          .showSnackBar(new SnackBar(
                                        content: new Text(
                                            "Tətbiqatdan istifadə etmək üçün müqavilə şərtləri ilə razılaşmalısınız"),
                                      ));
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                        gradient: mainColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Text(
                                      "Qeydiyyata Dəvam",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 40,
                                  padding: EdgeInsets.all(5),
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    backgroundColor:
                                        Color.fromRGBO(176, 106, 179, 1),
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Color.fromRGBO(66, 135, 245, 1)),
                                  ),
                                )
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

