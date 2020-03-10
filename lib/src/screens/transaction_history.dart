import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:selfcare/drawer/menu_dashboard_layout.dart';
import 'package:selfcare/model/LoginModel/LoginResponse.dart';

class TransactionHistory extends StatefulWidget {

  LoginResponse _loginResponse;

  TransactionHistory({Key key, LoginResponse loginResponse}):
        assert(loginResponse != null), _loginResponse = loginResponse,super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory>
    with SingleTickerProviderStateMixin {
  Item selectedUser;
  List<Item> users = <Item>[
    const Item(
        'Android',
        Icon(
          Icons.android,
          color: const Color(0xFF167F67),
        )),
  ];

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

    return Scaffold(
      backgroundColor: Color(0xFF4A81C3),
      body: Container(
        child: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    return DropdownButton<Item>(
      hint: Text(
        "FILTER",
        style: TextStyle(
            color: Color(0xFF868686),
            letterSpacing: 1,
            fontFamily: "Cabin",
            fontWeight: FontWeight.w500,
            fontSize: 12),
      ),
      value: selectedUser,
      underline: Container(
        height: 1.0,
      ),
      onChanged: (Item value) {
        setState(() {
          selectedUser = value;
        });
      },
      items: users.map((Item user) {
        return DropdownMenuItem<Item>(
          value: user,
          child: Row(
            children: <Widget>[
              user.icon,
              SizedBox(
                width: 10,
              ),
              Text(
                user.name,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          elevation: 1,
          color: backgroundColor,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: screenHeight,
                    color: Color(0xFFF8F8F8),
                  )
                ],
              ),
              home(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactionHistory(context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE2EFFF),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: 40.0,
                        height: 40.0,
                        child: Image.asset(
                          "images/topup.png",
                          color: Color(0xFF4A81C3),fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget._loginResponse.data.accounts[index].product.name}",
                            style: TextStyle(
                                color: Color(0xFF3B4B64),
                                fontFamily: "Cabin",
                                letterSpacing: 1,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "${widget._loginResponse.data.accounts[index].product.caption}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFFDADADA), letterSpacing: 1, fontWeight: FontWeight.w500, fontFamily: "Cabin",fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Text(
                        "N${(widget._loginResponse.data.accounts[index].product.price).toStringAsFixed(0)}",
                        style: TextStyle(
                          fontFamily: "Cabin",
                            letterSpacing: 1,
                            fontSize: 16,
                            color: Color(0xFF4A81C3),
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 1,
          );
        },
        itemCount: widget._loginResponse.data.accounts.length,
      ),
    );
  }

  Widget home(context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: InkWell(
              child: Image.asset(
                "images/menu.png",
                color: Colors.white,
              ),
              onTap: () {
                setState(() {
                  if (isCollapsed)
                    _controller.forward();
                  else
                    _controller.reverse();
                  isCollapsed = !isCollapsed;
                });
              },
            ),
          ),
          pinned: true,
          backgroundColor: Color(0xFF4A81C3),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "ALL ACCOUNTS",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "OCT 24, 2019",
                      style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 12,
                          letterSpacing: 1,
                          color: Color(0xFF4A81C3),
                          fontWeight: FontWeight.w500),
                    ),
//                    _dropDown()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                child: _transactionHistory(context),
              )
            ],
          ),
        ),

//        SliverList(
//          delegate: SliverChildBuilderDelegate((context, index) {
//            return Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                Padding(
//                  padding: const EdgeInsets.only(top: 10, left: 30.0, right: 30.0),
//                  child: Row(
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text(
//                        "OCT 24, 2019",
//                        style: TextStyle(
//                          fontFamily: "Cabin",
//                            fontSize: 12,
//                            letterSpacing: 1,
//                            color: Color(0xFF4A81C3),
//                            fontWeight: FontWeight.w500),
//                      ),
//                      _dropDown()
//                    ],
//                  ),
//                ),
//                Padding(
//                  padding: const EdgeInsets.only(left: 20.0, right: 30.0),
//                  child: _transactionHistory(context),
//                )
//              ],
//            );
//          }, childCount: 1),
//        )
      ],
    );
  }

  Widget menu(context) {
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
