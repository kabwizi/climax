import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String entree;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.arrowLeft,
                  color: kBlackColor,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (value) {
                  entree = value;
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      FontAwesomeIcons.city,
                      color: kBlackColor,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    hintText: "City name",
                    hintStyle: TextStyle(color: Colors.grey[600])),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context, entree);
              },
              child: Text(
                'Get Weather',
                style: kButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
