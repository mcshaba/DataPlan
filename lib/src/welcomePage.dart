import 'dart:math';

import 'package:flutter/material.dart';
import 'package:selfcare/drawer/menu_dashboard_layout.dart';
import 'package:selfcare/src/screens/login.dart';
import 'package:selfcare/util/flushbar_helper.dart';
import 'package:selfcare/util/secure_storage.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.blue[100],
                  offset: Offset(1, 2),
                  blurRadius: 1,
                  spreadRadius: 1)
            ],
            color: Colors.white),
        child: Text(
          'Log In',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              fontFamily: "Cabin",
              color: Color(0xFF4A81C3)),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Stream anytime\nReliable as Day and Night!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  letterSpacing: 1.1,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
//            Icon(Icons.fingerprint, size: 90, color: Colors.white),
//            SizedBox(
//              height: 20,
//            ),
            Text(
              'No Buffering, No waiting\nSpeed beyond your imagination',
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Cabin",
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ));
  }

  Widget _title() {
    return Image.asset("images/logo_blue.png");

//      RichText(
//      textAlign: TextAlign.center,
//      text: TextSpan(
//          text: 'se',
//          style: GoogleFonts.portLligatSans(
//            textStyle: Theme.of(context).textTheme.display1,
//            fontSize: 30,
//            fontWeight: FontWeight.w700,
//            color: Colors.white,
//          ),
//          children: [
//            TextSpan(
//              text: 'lf',
//              style: TextStyle(color: Colors.black, fontSize: 30),
//            ),
//            TextSpan(
//              text: 'care',
//              style: TextStyle(color: Colors.white, fontSize: 30),
//            ),
//          ]),
//    );
  }

  @override
  void initState() {
    super.initState();

    SecureStorage.getInitialDataLoaded().then((data) {
      if (data == null) {
        _loadInitialData();
      }
    }).catchError((error) {
      throw Exception(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var top;
    if(height < 570){
       top = height * 0.34;
    } else {
       top = height * 0.44;

    }
    var screenWidth = MediaQuery.of(context).size.width;
    print("SCREEN WIDTH  $screenWidth");
    print("SCREEN HEIGHT  $height");
    return Scaffold(
      body: SingleChildScrollView(

        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.png"),
                    fit: BoxFit.cover),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: top,
                  ),
                  _title(),
                  SizedBox(
                    height: height * 0.047,
                  ),
                  _label(),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  _submitButton(),

                  //_label()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadInitialData() {
    SecureStorage.getToken().then((token) {
      if (token == null) {

        Future.delayed(Duration(seconds: 5), () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Login()),
        ));
      } else {
        print('Customer token : $token');

//        Navigator.pushReplacement(
//          context,
//          MaterialPageRoute(builder: (BuildContext context) => MenuDashBoardPage()),
//        );
      }
    }).catchError((error) {
      FlushbarHelper.createLoading(message: error)..show(context);
    });
  }
}
