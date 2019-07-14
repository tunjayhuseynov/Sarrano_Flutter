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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => QRViewExample()),
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
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      "https://images6.alphacoders.com/937/937971.jpg",
                      fit: BoxFit.cover,
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
                                //border: Border.all(color: Colors.white, width: 3.5),
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: Image.network(
                                    "https://images6.alphacoders.com/937/937971.jpg",
                                    fit: BoxFit.cover,
                                  ).image,
                                ))),
                      ),
                    ),
                    Positioned(
                      bottom: 25,
                      child: Text(
                        "Bonus: 0",
                        style: TextStyle(fontSize: 35.0, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      top: 35,
                      child: Text(
                        "Angelina Baker",
                        style: TextStyle(color: Colors.white, fontSize: 35),
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
                onTap: () {},
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Image.asset("images/market.png"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Image.asset("images/purchase.png"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Image.asset("images/survey.png"),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Image.asset("images/setting.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                    top: 10,
                    left: 100,
                    child: Text(
                      "MacDonald",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    left: 100,
                    child: Text(
                      "19 Yanvar 22:10",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 10,
                    child: Text(
                      "+50",
                      style: TextStyle(fontSize: 28),
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
