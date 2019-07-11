import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
final phoneNumber = TextEditingController();


class LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                    new TabBar(labelPadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      tabs: [new Text("Giriş"), new Text("Qeydiyyat")],
                      indicatorColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
        ),
        body: TabBarView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  Container(
                    width: 200,
                    child: TextFormField(
                      controller: phoneNumber,
                      decoration: InputDecoration(
                        labelText: "Telefon Nömrəsi: ",
                        fillColor: Colors.white,
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Nömrə daxil edin";
                        } 
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        
                      }
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
            Column()
          ],
        ),
      ),
    );
  }
}

