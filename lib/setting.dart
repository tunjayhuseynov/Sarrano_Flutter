import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sarrano_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingSate();
  }
}

class SettingSate extends State<SettingActivity> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Hesabdan çıxış', style: TextStyle(color: Colors.grey[700]),),
            content: new Text('Hesabdan çıxmaq istəyirsiniz?', style: TextStyle(color: Colors.black54,),),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Xeyir', style: TextStyle(foreground: Paint()..shader = inputColor),),
              ),
              new FlatButton(
                onPressed: () async {
                  var pref = await SharedPreferences.getInstance();
                  pref.setInt('id', 0);
                  pref.setString('token', null);
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => LogInPage()));
                },
                child: new Text('Bəli', style: TextStyle(foreground: Paint()..shader = inputColor),),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
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
            child: AppBar(
                title: Text("Tənzimləmələr"),
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context, false),
                )),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: GestureDetector(
              onTap: () {},
              child: Text(
                "Hesab",
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()..shader = inputColor),
              ),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
                child: GestureDetector(
              onTap: () {},
              child: Text(
                "Bildirişlər",
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()..shader = inputColor),
              ),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
                child: GestureDetector(
              onTap: () {
                _onWillPop();
              },
              child: Text(
                "Çıxış",
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()..shader = inputColor),
              ),
            ))
          ],
        ));
  }
}
