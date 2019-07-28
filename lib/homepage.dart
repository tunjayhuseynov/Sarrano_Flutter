import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarrano_flutter/locationService.dart';
import 'package:sarrano_flutter/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cameraQR.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'history.dart';
import 'market.dart';
import 'partner.dart';
import 'purchase.dart';
import 'API.dart';
import 'package:cached_network_image/cached_network_image.dart';

var geolocator = Geolocator();
var locationOptions =
    LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

StreamSubscription<Position> positionStream =
    geolocator.getPositionStream(locationOptions).listen((Position position) {
  print(position == null
      ? 'Unknown'
      : position.latitude.toString() + ', ' + position.longitude.toString());
});

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var _currentIndex = 1;
  bool isBackgroundImageLoaded = false;
  bool isProfileImageLoaded = false;
  bool isInfoJsonLoaded = false;
  String userLink;
  String fullname;
  String bonusCount;

  @override
  initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300)).then((_) async {
      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getInt("id") ?? 0;
      var token = prefs.getString('token') ?? null;
      http.get(getUserGet(id, token), headers: header).then((res) {
        var user = UserInfo.fromJson(json.decode(res.body));
        setState(() {
          bonusCount = "Bonus: ${user.bonus.toString()}";
          fullname = "${user.name} ${user.surname}";
          userLink = user.imgName;
          isInfoJsonLoaded = true;
        });
      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            PermissionHandler()
                .checkServiceStatus(PermissionGroup.location)
                .then((serviceStatus) {
              if (serviceStatus == ServiceStatus.disabled ||
                  serviceStatus == ServiceStatus.unknown) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationService()),
                );
                return;
              }
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => QRViewPage()),
              );
            });
          },
          backgroundColor: Colors.yellow[800],
          child: Icon(Icons.camera),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(gradient: mainColor),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            elevation: 0,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
            backgroundColor: Colors.transparent,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                if (index == 0) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => HistoryActivity()));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => PartnerActivity()));
                }
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('Keçmiş'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text('Partner'),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: Container(),
                backgroundColor: Colors.transparent,
                expandedHeight: 333.0,
                pinned: false,
                floating: true,
                snap: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: <Widget>[
                      isInfoJsonLoaded
                          ? Container(
                              decoration: BoxDecoration(
                                gradient: mainColor,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: getImage(userLink),
                                fit: BoxFit.cover,
                                placeholder: (context, url) => new Center(
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    new Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: mainColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: mainColor,
                                ),
                              ),
                            ),
                      new BackdropFilter(
                        filter:
                            prefix0.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      isInfoJsonLoaded
                          ? Positioned(
                              width: 150,
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    gradient: mainColor,
                                    shape: BoxShape.circle),
                                child: new Container(
                                    width: 150.0,
                                    height: 150.0,
                                    decoration: new BoxDecoration(
                                        gradient: mainColor,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                                getImage(userLink))))),
                              ),
                            )
                          : Positioned(
                              width: 150,
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    gradient: mainColor,
                                    shape: BoxShape.circle),
                                child: new Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: new BoxDecoration(
                                    gradient: mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 30,
                        child: isInfoJsonLoaded
                            ? Text(
                                bonusCount,
                                style: TextStyle(
                                    fontSize: 29.0,
                                    color: Colors.white,
                                    fontFamily: "Serif",
                                    fontWeight: FontWeight.w300),
                              )
                            : Container(
                                child: Text("Yüklənir..."),
                              ),
                      ),
                      Positioned(
                        top: 45,
                        child: isInfoJsonLoaded
                            ? Text(
                                fullname,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontFamily: "Serif"),
                              )
                            : Container(),
                      ),
                      Positioned(
                        bottom: 0,
                        width: 500,
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(gradient: mainColor),
                        ),
                      ),
                    ],
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              ),
            ];
          },
          body: Center(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => MarketActivity()));
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Image.asset(
                      "images/market.png",
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PurchaseActivity()));
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Image.asset(
                      "images/purchase.png",
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Image.asset(
                      "images/survey.png",
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => SettingActivity()));
                  },
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Image.asset(
                      "images/setting.png",
                      filterQuality: FilterQuality.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
