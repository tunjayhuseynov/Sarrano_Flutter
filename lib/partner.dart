

// Partner
//Partner
//Partner
//Partner
//Partner

import 'package:flutter/material.dart';
import 'main.dart';

class PartnerActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PartnerState();
  }
}

class PartnerState extends State<PartnerActivity> {
  Future<bool> _infoCompany(String companyName, String adsCount) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Məlumat'),
            content: Container(
              height: 500,
              width: 400,
              child: Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Positioned(
                    width: 110,
                    left: 0,
                    top: 0,
                    child: Image.asset("images/survey.png"),
                  ),
                  Positioned(
                    child: Text("Ad: $companyName"),
                    top: 5,
                    left: 115,
                  ),
                  Positioned(
                    child: Text("Reklam Sayı: $adsCount "),
                    left: 115,
                    top: 30,
                  ),
                  Positioned(
                    top: 120,
                    width: 280,
                    left: 0,
                    child: Text(
                      "Bu qeder isin icinde u isi gormek kimisi yoxdur demek isterdim ki, gordum yox ele edyil, amma bezen eledir, mene ele gelir, esas MacDonal ne edir ona bos bos description yazmaqdir ki onu olce bilek. Lenet olsun hele itmeyib, bele test bir is olmasa ela oladi, isin 60 faizi bele seylere vaxt itirmekle gedir, neyleyek bu app appstoreda rrealse olacaq deye bu eziyyetlere qatlanacayiq, lakin kod yene de heyatdi, mene lezzet eleyir, budur, heyat qisa deymez qiza zad zud , bunun atiq agzi falan eyilir ne gunlere qaldi bu text, biraz problemleri cixdi deyensen cunki text yuxari niye surusmeye basladi deye dusunurem",
                      textAlign: TextAlign.justify,
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
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _infoCompany("MacDonald", "10");
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
                        child: Container(
                          width: 340,
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Text(
                            "MacDonald McDonald deyil, onun Copy&Right`siz formasıdır. Noqte burada",
                            style: TextStyle(fontSize: 14),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
