import 'package:flutter/material.dart';
import 'package:selfcare/drawer/menu_dashboard_layout.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin{

  bool isCollapsed = true;
  double screenWidth, screenHeight, backgroundHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    backgroundHeight = screenHeight * 0.75;

    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 34.0, left: 5),
                child: Image.asset(
                  "images/logo_blue.png",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Selfcare Portal",
                  style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 37,
              ),
              NavigationItem("images/dashboard.png", "DASHBOARD", context),
              NavigationItem("images/binoculars.png", "CHECK DATA BALANCE", context),
              NavigationItem("images/report.png", "REPORT", context),
              NavigationItem("images/usermenu.png", "MANAGE ACCOUNT", context),
              NavigationItem("images/loanmenu.png", "LOANS", context),
              NavigationItem("images/contactus.png", "CONTACT SUPPORT", context),
              NavigationItem("images/logout.png", "LOGOUT", context),
            ],
          ),
        ),
      ),
    );
  }
}
