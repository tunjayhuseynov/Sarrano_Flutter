import 'dart:io';
import 'dart:ui' as prefix0;
import 'main.dart';
import 'package:flutter/material.dart';

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
                if (index != 1) {
                  _currentIndex = index;
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
                        MaterialPageRoute(
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
                        MaterialPageRoute(
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
                  onTap: () {},
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

// MARKET
// MARKET
// MARKET
// MARKET

class MarketActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarketState();
  }
}

class MarketState extends State<MarketActivity> {
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
              title: Text("Market"),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            child: Container(
              height: 90,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 2,
                      width: 90,
                      child: Image.asset("images/unknown.jpeg")),
                  Positioned(
                    top: 5,
                    left: 100,
                    child: Text(
                      "MacDonald",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 100,
                    child: Text(
                      "50% Endirim Kuponu",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Positioned(
                    top: 65,
                    right: 15,
                    child: Text(
                      "Qalıq: 10",
                      style: TextStyle(fontSize: 15, fontFamily: 'Serif'),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            gradient: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "500",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ALISLAR
// ALISLAR
// ALISLAR
// ALISLAR

class PurchaseActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PurchaseState();
  }
}

class PurchaseState extends State<PurchaseActivity> {
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
              title: Text("Alışlar"),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            child: Container(
              height: 90,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      left: 2,
                      width: 90,
                      child: Image.asset("images/unknown.jpeg")),
                  Positioned(
                    top: 5,
                    left: 100,
                    child: Text(
                      "MacDonald",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    left: 100,
                    child: Text(
                      "50% Endirim Kuponu",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Positioned(
                    top: 65,
                    right: 10,
                    child: Text(
                      "17 May 21:10",
                      style: TextStyle(fontSize: 15, fontFamily: 'Serif'),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                            gradient: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Text(
                          "500",
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
