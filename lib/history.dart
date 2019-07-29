// Kecmis
//Kecmis
// Kecmis
//Kecmis

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'package:http/http.dart' as http;
import 'API.dart';

class HistoryActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<HistoryActivity> {
  bool isJsonLoaded = false;
  List<String> _atTime = new List();
  List<int> bonus = new List();
  List<String> companyName = new List();
  List<String> image = new List();
  @override
  initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getInt("id") ?? 0;
      var token = prefs.getString('token') ?? null;
      http.get(getHistory(id, 0, token), headers: header).then((res) {
        if(res.statusCode == 200){
          List<dynamic> list = json.decode(res.body);
        list.forEach((index) {
          HistoryApi his = HistoryApi.fromJson(index);
          _atTime.add(his.capturedAt);
          bonus.add(his.bonus);
          companyName.add(his.companyName);
          image.add(his.image);
        });
        setState(() {
          isJsonLoaded = true;
        });
        }
      });
    });
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
              title: Text("Keçmiş"),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context, false),
              )),
        ),
      ),
      body: isJsonLoaded
          ? ListView.builder(
              itemCount: companyName.length,
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
                            child: CachedNetworkImage(
                              imageUrl:
                                  rawUrl + "images/Companies/${image[index]}",
                                  fit: BoxFit.cover,
                              placeholder: (context, url) => new Center(
                                child: Container(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(176, 106, 179, 1),
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(66, 135, 245, 1)),
                                ),
                              ),
                              ),
                              errorWidget: (context, url, error) =>
                                  new Center(
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      child: Icon(Icons.error_outline, size: 70,),
                                    ),
                                  ),
                            )),
                        Positioned(
                          top: 5,
                          left: 100,
                          child: Text(
                            companyName[index],
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Positioned(
                          top: 40,
                          left: 100,
                          child: Text(
                            _atTime[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                  gradient: mainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                "+${bonus[index]}",
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
              backgroundColor: Color.fromRGBO(176, 106, 179, 1),
              valueColor: new AlwaysStoppedAnimation<Color>(
                  Color.fromRGBO(66, 135, 245, 1)),
            )),
    );
  }
}
