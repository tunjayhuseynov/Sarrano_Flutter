import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarrano_flutter/homepage.dart';

class LocationService extends StatefulWidget {
  const LocationService({Key key}) : super(key: key);

  @override
  _LocationServiceState createState() => _LocationServiceState();
}

class _LocationServiceState extends State<LocationService>
    with WidgetsBindingObserver {
      Timer _timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
        _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
         PermissionHandler()
            .checkServiceStatus(PermissionGroup.location)
            .then((serviceStatus) {
          if (serviceStatus == ServiceStatus.enabled) {
            _timer.cancel();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
                    
          }
        }); 
        });
        
});
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();

  }

  AppLifecycleState _notification;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notification = state;
      if (state == AppLifecycleState.resumed) {
        PermissionHandler()
            .checkServiceStatus(PermissionGroup.location)
            .then((serviceStatus) {
          if (serviceStatus == ServiceStatus.enabled) {
            Navigator.push(
                context, CupertinoPageRoute(builder: (context) => HomePage()));
          }
        });
      }
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
              child: Text("Zəhmət olmasa Location (GPS) servisini aktiv edin"),
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
