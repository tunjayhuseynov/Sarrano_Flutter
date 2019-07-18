
// MARKET
// MARKET
// MARKET
// MARKET

import 'package:flutter/material.dart';
import 'main.dart';

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