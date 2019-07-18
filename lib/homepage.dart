import 'dart:io';
import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:sarrano_flutter/setting.dart';
import 'cameraQR.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'history.dart';
import 'market.dart';
import 'partner.dart';
import 'purchase.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var _currentIndex = 1;

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRViewPage()),
            );
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
                      MaterialPageRoute(
                          builder: (context) => HistoryActivity()));
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PartnerActivity()));
                }
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                title: Text('Keçmiş'),
              ),
              /* BottomNavigationBarItem(
              icon: Icon(null),
              title: Text(''),
            ),*/
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
                      Image.network(
                        "https://images6.alphacoders.com/937/937971.jpg",
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.none,
                      ),
                      new BackdropFilter(
                        filter:
                            prefix0.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                        child: new Container(
                          decoration: new BoxDecoration(
                              color: Colors.black.withOpacity(0.3)),
                        ),
                      ),
                      Positioned(
                        width: 150,
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              gradient: mainColor, shape: BoxShape.circle),
                          child: new Container(
                              width: 150.0,
                              height: 150.0,
                              decoration: new BoxDecoration(
                                  gradient: mainColor,
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      "https://images6.alphacoders.com/937/937971.jpg",
                                      fit: BoxFit.fill,
                                      filterQuality: FilterQuality.none,
                                    ).image,
                                  ))),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        child: Text(
                          "Bonus: 0",
                          style: TextStyle(
                              fontSize: 29.0,
                              color: Colors.white,
                              fontFamily: "Serif",
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Positioned(
                        top: 45,
                        child: Text(
                          "Angelina Baker",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: "Serif"),
                        ),
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
