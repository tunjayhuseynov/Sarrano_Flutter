// Partner
//Partner
//Partner
//Partner
//Partner

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'API.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

class PartnerActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PartnerState();
  }
}

class PartnerState extends State<PartnerActivity> {
  bool isJsonLoaded = false;
  List<String> info = new List();
  List<String> images = new List();
  List<String> companyNames = new List();
  List<int> adsNum = new List();
  List<String> maplinks = new List();
  int listCount;
  bool isLoadingMore = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 800)).then((_) async {
      var prefs = await SharedPreferences.getInstance();
      var id = prefs.getInt("id") ?? 0;
      var token = prefs.getString('token') ?? null;
      http.get(getPartners(id, 0, token), headers: header).then((res) {
        if (res.statusCode == 200) {
          var list = json.decode(res.body);
          listCount = list['ListCount'];
          list['list'].forEach((index) {
            PartnerAPI his = PartnerAPI.fromJson(index);
            info.add(his.details);
            images.add(his.image);
            companyNames.add(his.companyName);
            adsNum.add(his.adsCount);
            maplinks.add(his.mapLink);
          });
          setState(() {
            isJsonLoaded = true;
          });
        }
      });
    });
  }

  Future<bool> _infoCompany(
      String companyName, String adsCount, String maplink, String imgName) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Center(
              child: Text('Məlumat'),
            ),
            content: Container(
              height: 350,
              width: 400,
              child: Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    width: 150,
                    height: 150,
                    left: 75,
                    top: 0,
                    child: CachedNetworkImage(
                      cacheManager: ,
                      imageUrl: rawUrl + "images/Companies/$imgName",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => new Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(
                            backgroundColor: Color.fromRGBO(176, 106, 179, 1),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(66, 135, 245, 1)),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => new Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          child: Icon(
                            Icons.error_outline,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Text(
                      "Partner: $companyName",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    top: 170,
                    left: 0,
                  ),
                  Positioned(
                    child: Text("Reklam Sayı: $adsCount ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    left: 0,
                    top: 200,
                  ),
                  Positioned(
                    top: 250,
                    width: 280,
                    left: 0,
                    child: Center(
                      child: Container(
                        child: GestureDetector(
                            onTap: () {
                              _launchMapsUrl(maplink);
                            },
                            child: Container(
                              width: 400,
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              decoration: BoxDecoration(
                                  gradient: mainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                  child: Text(
                                "Xəritədə QR kodların yerlərini göstər",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )),
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('Bağla'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _launchMapsUrl(String maplink) async {
    final url = '$maplink';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
              title: Text("Partnerlər"),
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
              itemCount: companyNames.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index < companyNames.length
                    ? GestureDetector(
                        onTap: () {
                          _infoCompany(
                              "${companyNames[index]}",
                              "${adsNum[index]}",
                              "${maplinks[index]}",
                              "${images[index]}");
                        },
                        child: Card(
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
                                      imageUrl: rawUrl +
                                          "images/Companies/${images[index]}",
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => new Center(
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          child: CircularProgressIndicator(
                                            backgroundColor: Color.fromRGBO(
                                                176, 106, 179, 1),
                                            valueColor:
                                                new AlwaysStoppedAnimation<
                                                        Color>(
                                                    Color.fromRGBO(
                                                        66, 135, 245, 1)),
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          new Center(
                                        child: Container(
                                          width: 90,
                                          height: 90,
                                          child: Icon(
                                            Icons.error_outline,
                                            size: 70,
                                          ),
                                        ),
                                      ),
                                    )),
                                Positioned(
                                  top: 3,
                                  left: 100,
                                  child: Text(
                                    "${companyNames[index]}",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                Positioned(
                                    top: 33,
                                    left: 100,
                                    child: Container(
                                      width: 300,
                                      padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                                      child: Text(
                                        "${info[index]}",
                                        style: TextStyle(fontSize: 14),
                                        textAlign: TextAlign.left,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ))
                    : listCount > companyNames.length
                        ? !isLoadingMore
                            ? Center(
                                child: RaisedButton(
                                  padding: EdgeInsets.all(0),
                                  elevation: 5,
                                  onPressed: () async {
                                    setState(() {
                                      isLoadingMore = true;
                                    });
                                    var prefs =
                                        await SharedPreferences.getInstance();
                                    var id = prefs.getInt("id") ?? 0;
                                    var token =
                                        prefs.getString('token') ?? null;
                                    http
                                        .get(getPartners(id, index, token),
                                            headers: header)
                                        .then((res) {
                                      if (res.statusCode == 200) {
                                        var list = json.decode(res.body);
                                        list['list'].forEach((index) {
                                          PartnerAPI his =
                                              PartnerAPI.fromJson(index);
                                          info.add(his.details);
                                          images.add(his.image);
                                          companyNames.add(his.companyName);
                                          adsNum.add(his.adsCount);
                                          maplinks.add(his.mapLink);
                                        });
                                        setState(() {
                                          isLoadingMore = false;
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                    decoration: BoxDecoration(
                                        gradient: mainColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Text(
                                      "Digərləri",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Center(
                                child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Color.fromRGBO(176, 106, 179, 1),
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(66, 135, 245, 1)),
                                ),
                              ))
                        : Container();
              },
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(176, 106, 179, 1),
                valueColor: new AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(66, 135, 245, 1)),
              ),
            ),
    );
  }
}
