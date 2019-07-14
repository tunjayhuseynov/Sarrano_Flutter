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
        onPressed: () {},
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
            BottomNavigationBarItem(
              icon: Icon(null),
              title: Text(''),
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
              backgroundColor: Colors.transparent,
              expandedHeight: 350.0,
              pinned: false,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      "https://scontent.fgyd8-1.fna.fbcdn.net/v/t1.0-9/57352867_802779226766872_8368079684117725184_n.jpg?_nc_cat=103&_nc_oc=AQlGXrh4RWJSv5zsvVNGeF6BXnCctJ4rIRe4y9BQB75Im8VqMYGmucbMFgl3UWIYvZI&_nc_ht=scontent.fgyd8-1.fna&oh=6a378a0d0041605bcff05249b62aecdf&oe=5DB52F50",
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
                      child: new Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white, width: 3.5),
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: Image.network(
                                  "https://scontent.fgyd8-1.fna.fbcdn.net/v/t1.0-9/57352867_802779226766872_8368079684117725184_n.jpg?_nc_cat=103&_nc_oc=AQlGXrh4RWJSv5zsvVNGeF6BXnCctJ4rIRe4y9BQB75Im8VqMYGmucbMFgl3UWIYvZI&_nc_ht=scontent.fgyd8-1.fna&oh=6a378a0d0041605bcff05249b62aecdf&oe=5DB52F50",
                                  fit: BoxFit.cover,
                                ).image,
                              ))),
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
                        "Tuncay Huseynov",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    )
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
              Card(
                child: Image.asset("images/market.png"),
              ),
              Card(
                child: Image.asset("images/purchase.png"),
              ),
              Card(
                child: Image.asset("images/survey.png"),
              ),
              Card(
                child: Image.asset("images/setting.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
