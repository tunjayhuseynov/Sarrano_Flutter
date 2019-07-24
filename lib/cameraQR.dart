import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sarrano_flutter/locationService.dart';

class QRViewPage extends StatefulWidget {
  const QRViewPage({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewState();
}

class _QRViewState extends State<QRViewPage> with WidgetsBindingObserver {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  bool isFlashOff = true;
  QRViewController controller;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      ServiceStatus serviceStatus = await PermissionHandler()
          .checkServiceStatus(PermissionGroup.location);
      if (serviceStatus == ServiceStatus.disabled) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LocationService()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          Positioned(
            top: 50,
            left: 10,
            child: GestureDetector(
              onTap: () {
                controller.flipFlash();
                setState(() {
                  if (isFlashOff) {
                    isFlashOff = false;
                  } else {
                    isFlashOff = true;
                  }
                });
              },
              child: new Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //border: Border.all(color: Colors.white, width: 1)
                ),
                child: isFlashOff
                    ? Icon(
                        Icons.flash_off,
                        color: Colors.white,
                        size: 35,
                      )
                    : Icon(
                        Icons.flash_on,
                        color: Colors.white,
                        size: 35,
                      ),
              ),
            ),
          ),
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
