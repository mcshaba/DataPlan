import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:selfcare/bloc/account_bloc/bloc/account_bloc.dart';
import 'package:selfcare/bloc/login/bloc/login_bloc.dart';
import 'package:selfcare/model/ActiveSession/activeSessionModel.dart';
import 'package:selfcare/model/LoginModel/LoginResponse.dart';
import 'package:selfcare/repository/data_repository.dart';
import 'package:selfcare/src/screens/login.dart';
import 'package:selfcare/src/screens/renew_plan.dart';
import 'package:selfcare/src/screens/topup_plan.dart';
import 'package:selfcare/src/screens/transaction_history.dart';
import 'package:selfcare/util/helper_functions.dart';
import 'package:selfcare/util/secure_storage.dart';

final Color backgroundColor = Color(0xFF4A81C3);

class MenuDashBoardPage extends StatefulWidget {
  LoginResponse _loginResponse;

  int index = 0;

  MenuDashBoardPage({Key key, @required LoginResponse loginResponse})
      : assert(loginResponse != null),
        _loginResponse = loginResponse,
        super(key: key);

  @override
  _MenuDashBoardPageState createState() => _MenuDashBoardPageState();
}

class _MenuDashBoardPageState extends State<MenuDashBoardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight, backgroundHeight;

  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  int accountID;

  AccountBloc dataPlanBloc;

  @override
  Future<void> initState() {
    super.initState();
    dataPlanBloc = AccountBloc();
    dataPlanBloc.dispatch(AccountStarted());

    callActiveSession(dataPlanBloc);

    accountID = widget._loginResponse.data.accounts.length == 0
        ? 0
        : widget._loginResponse.data?.accounts[widget.index].iAccount;
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
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
    print("SCREEN WIDTH  $screenWidth");
    if( screenWidth < 350){

    }
    backgroundHeight = screenHeight * 0.75;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            dashboard(context),
          ],
        ),
      ),
    );
  }

  Widget _dropDown() {
    var length = widget._loginResponse.data.accounts[widget.index].id.length;
    var string = StringBuffer();
    string.write(widget._loginResponse.data.accounts[widget.index].id);
    string.write(" - ");
    string.write(widget._loginResponse.data.user.firstName.substring(0, 5));

    return InkWell(
      onTap: () => _onChangeAccount(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            string.isNotEmpty ? string.toString() : "---",
            style: TextStyle(
                color: Color(0xFF4A81C3),
                fontFamily: "Cabin",
                fontWeight: FontWeight.w500,
                letterSpacing: 0.9,
                fontSize: 14),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget dashboard(BuildContext context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.65 * screenWidth,
      right: isCollapsed ? 0 : -0.35 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
//          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.25,
                  ),
                  Container(
                    height: backgroundHeight,
                    color: Color(0xFFF8F8F8),
                  )
                ],
              ),
              MultiBlocProvider(providers: [
                BlocProvider(
                    builder: (context) =>
                        AccountBloc(repository: DataRepository()))
              ], child: _mainData(context))
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Logging Out"),
          content: new Text(
              "Are you sure you want to logout. You might lose offline data. Proceed?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            OutlineButton(
              child: Text('Yes Logout'),
              textColor: Colors.red,
              color: Colors.transparent,
              onPressed: () async {
                await Helper.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Login()),
                    ModalRoute.withName('/'));

//                Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (BuildContext context) => LoginPage()),
//                );
              },
            ),
          ],
        );
      },
    );
  }

  void _getCachedData() async {
    var token = await SecureStorage.getToken();
    var iAccount = await SecureStorage.getIAccount();
  }

  void _onChangeAccount() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF73737373),
            height: 450,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(20),
                        topRight: const Radius.circular(20))),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: _buildBottomNavigation())),
          );
        });
  }

  Column _buildBottomNavigation() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text("MY DEVICES ",
              style: TextStyle(
                  color: Color(0xFF4A81C3),
                  fontSize: 18,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text("Please select device you want to manage",
                style: TextStyle(
                    color: Color(0xFFADACAC),
                    fontSize: 12,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.w500)),
          ),
        ),
        _transactionHistory(context),
      ],
    );
  }

  Widget _transactionHistory(context) {
    var length;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          length =
              widget._loginResponse.data.accounts[index].subscriber.firstName !=
                      null
                  ? widget._loginResponse.data.accounts[index].subscriber
                      .firstName.length
                  : 0;

          return InkWell(
            onTap: () {
              setState(() {
                widget.index = index;
              });
              Navigator.pop(context);
            },
            child: Card(
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
//                        Container(
//                          decoration: BoxDecoration(
//                            color: Color(0xFFE2EFFF),
//                            borderRadius: BorderRadius.circular(10.0),
//                          ),
//                          width: 40.0,
//                          height: 40.0,
//                          child: Image.asset(
//                            "images/topup.png",
//                            color: Color(0xFF4A81C3),fit: BoxFit.scaleDown,
//                          ),
//                        ),
//                        SizedBox(
//                          width: 10.0,
//                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "${widget._loginResponse.data.accounts[index].id} ${widget._loginResponse.data.accounts[index].subscriber.firstName != null ? widget._loginResponse.data.accounts[index].subscriber.firstName.substring(0, length > 10 ? 10 : length) : ""}",
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
                              "${widget._loginResponse.data.accounts[index].product.name != null ? widget._loginResponse.data.accounts[index].product.name : " "}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color(0xFFDADADA),
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Cabin",
                                  fontSize: 12),
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
                          "N${widget._loginResponse.data.accounts[index].product.price}",
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
                      fontFamily: "Cabin",
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 37,
              ),
              NavigationItem("images/dashboard.png", "DASHBOARD", context),
              NavigationItem(
                  "images/binoculars.png", "CHECK DATA BALANCE", context),
              NavigationItem("images/report.png", "REPORT", context),
              NavigationItem("images/usermenu.png", "MANAGE ACCOUNT", context),
              NavigationItem("images/loanmenu.png", "LOANS", context),
              NavigationItem(
                  "images/contactus.png", "CONTACT SUPPORT", context),
              NavigationItem("images/logout.png", "LOGOUT", context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainData(context) {
    var balance = StringBuffer();
    var gigabyte = StringBuffer();
    var dataVolume = StringBuffer();

    balance.write("N");
    balance.write(widget._loginResponse.data.user.balance);

    gigabyte.write((widget._loginResponse.data.accounts[widget.index].product
            .display.dataCapacity.capacity)
        .toStringAsFixed(0));
    gigabyte.write("GB");

    dataVolume.write(
        (widget._loginResponse.data.accounts[widget.index].dataVolume)
            .toStringAsFixed(1));
    dataVolume.write("GB");

    return BlocProvider(
      builder: (context) => dataPlanBloc,
      child: BlocListener<AccountBloc, AccountState>(
        listener: (context, state) {
          if (state is AccountLoading) {}
          if (state is AccountSuccessFully) {
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
                      "${state.activeSessionResponse.data[widget.index].customer.balance}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    centerTitle: true,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    var daysLeft = StringBuffer();
                    daysLeft.write(state
                        .activeSessionResponse.data[widget.index].expirationDate
                        .difference(DateTime.now())
                        .inDays);
                    daysLeft.write(" Days Left");

                    return Container(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 238,
                            width: screenWidth,
                            margin: const EdgeInsets.only(bottom: 17.61),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 10.0,
                                ),
                                _dropDown(),
                                Text(
                                  "Account Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      fontFamily: "Cabin",
                                      letterSpacing: 0.9,
                                      color: Color(0xFF838383)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CircularPercentIndicator(
                                  arcType: ArcType.FULL,
//                                  footer: Center(
//                                    child: Row(
//                                      children: <Widget>[
//                                        SizedBox(
//                                          width: 110.18,
//                                        ),
//                                        Text(
//                                          "0GB",
//                                          style: TextStyle(
//                                              fontFamily: "Cabin",
//                                              fontSize: 14,
//                                              color: Color(0xFFDADADA),
//                                              fontWeight: FontWeight.w500,
//                                              letterSpacing: 0.9),
//                                        ),
//                                        SizedBox(
//                                          width: 50.18,
//                                        ),
//                                        Text(
//                                          "${gigabyte.toString()}",
//                                          style: TextStyle(
//                                              fontFamily: "Cabin",
//                                              fontSize: 14,
//                                              color: Color(0xFFDADADA),
//                                              fontWeight: FontWeight.w500,
//                                              letterSpacing: 0.9),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
                                  radius: 100,
                                  lineWidth: 4.0,
//                                  percent: 1.0,
                                  center: Container(
                                    height: 75,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            color: Colors.grey.shade200,
                                            offset: Offset(2, 4),
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${dataVolume.toString()}',
                                        style: TextStyle(
                                            color: Color(0xFF4A81C3),
                                            fontSize: 20,
                                            letterSpacing: 1.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  progressColor: Color(0xFF4A81C3),
                                  backgroundColor: Color(0xFFEFF1FB),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${daysLeft.toString()}",
                                  style: TextStyle(
                                      fontFamily: "Cabin",
                                      letterSpacing: 0.5,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF4A81C3)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 100,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
//                        Container(
//                          width: 92,
//                          height: 80,
//                          decoration: BoxDecoration(
//                              shape: BoxShape.rectangle,
//                              color: Color(0xFFF38181),
//                              borderRadius: BorderRadius.circular(3.0)),
//                          child: Center(
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Image.asset(
//                                  "images/loan.png",
//                                  color: Color(0xFFF8F8F8),
//                                ),
//                                SizedBox(
//                                  height: 10.0,
//                                ),
//                                Center(
//                                  child: Text(
//                                    'Loan Request',
//                                    style: TextStyle(
//                                        color: Color(0xFFF8F8F8),
//                                        fontFamily: "Cabin",
//                                        letterSpacing: 0.5,
//                                        fontWeight: FontWeight.w500,
//                                        fontSize: 10),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                RenewPlan(
                                                    loginResponse:
                                                        widget._loginResponse,
                                                    index: widget.index)));
                                  },
                                  child: Container(
                                    width: screenWidth * 0.37,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color(0xFFFCE38A),
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/renewal.png",
                                          color: Color(0xFF4A81C3),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text(
                                          'Renewal',
                                          style: TextStyle(
                                              color: Color(0xFF4A81C3),
                                              fontFamily: "Cabin",
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                TopUpPlan(
                                                    loginResponse:
                                                        widget._loginResponse,
                                                    index: widget.index)));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color(0xFF4A81C3),
                                        borderRadius:
                                            BorderRadius.circular(3.0)),
                                    width: screenWidth * 0.37,
                                    height: 75,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          "images/topup.png",
                                          color: Color(0xFFF8F8F8),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Top-Up',
                                          style: TextStyle(
                                              color: Color(0xFFF8F8F8),
                                              fontFamily: "Cabin",
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "TOP ACCOUNTS",
                                style: TextStyle(
                                  fontFamily: "Cabin",
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3B4B64),
                                  fontSize: 12,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TransactionHistory(
                                                    loginResponse:
                                                        widget._loginResponse,
                                                  )));
                                    },
                                    color: Color(0xFFA5D2FD).withOpacity(0.21),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                        color: Color(0xFF3B4B64),
                                        fontFamily: "Cabin",
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: ClampingScrollPhysics(),
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                var productName = StringBuffer();
                                var caption = StringBuffer();
                                var price = StringBuffer();
                                productName.write(widget._loginResponse.data
                                    .accounts[index].product.name);
                                caption.write(widget._loginResponse.data
                                    .accounts[index].product.caption);
                                price.write("N");
                                price.write(widget._loginResponse.data
                                    .accounts[index].product.price);

                                return Card(
                                  elevation: 1.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 60,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFEBEB),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              width: 40.0,
                                              height: 40.0,
                                              child: Image.asset(
                                                "images/loan.png",
                                                color: Color(0xFFF38181),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  "${productName.toString()}",
                                                  style: TextStyle(
                                                    color: Color(0xFF3B4B64),
                                                    fontSize: 14.0,
                                                    fontFamily: "Cabin",
                                                    letterSpacing: 0.5,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  "${caption.toString()}",
                                                  style: TextStyle(
                                                      fontFamily: "Cabin",
                                                      letterSpacing: 0.5,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color(0xFFDADADA),
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 10.0),
                                            child: Text(
                                              "${price.toString()}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Cabin",
                                                letterSpacing: 0.5,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF4A81C3),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                              itemCount:
                                  widget._loginResponse.data.accounts.length > 3
                                      ? 3
                                      : widget
                                          ._loginResponse.data.accounts.length,
                            ),
                          ),
                        ],
                      ),
                    );
                  }, childCount: 1, addAutomaticKeepAlives: true),
                )
              ],
            );
          }
          if (state is AccountFailure) {}
        },
        child: BlocBuilder(
            bloc: dataPlanBloc,
            builder: (BuildContext context, AccountState state) {
              if (state is InitialLoginStatusState) {
                return buildBody();
              } else if (state is AccountSuccessFully) {
                if (state.activeSessionResponse.data.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Image(
                          image: new AssetImage("images/empty.gif"),
                          height: 200,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Sorry we could not find any data',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Cabin"),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }

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
//                              if (isCollapsed)
//                                _controller.forward();
//                              else
//                                _controller.reverse();
//                              isCollapsed = !isCollapsed;
                            });
                          },
                        ),
                      ),
                      pinned: true,
                      backgroundColor: Color(0xFF4A81C3),
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          "N${state.activeSessionResponse.data[widget.index].customer.balance}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        centerTitle: true,
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        var daysLeft = StringBuffer();
                        daysLeft.write(state.activeSessionResponse
                            .data[widget.index].expirationDate
                            .difference(DateTime.now())
                            .inDays);
                        daysLeft.write(" Days Left");

                        return Container(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 238,
                                width: screenWidth,
                                margin: const EdgeInsets.only(bottom: 17.61),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    _dropDown(),
                                    Text(
                                      "Account Details",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          fontFamily: "Cabin",
                                          letterSpacing: 0.9,
                                          color: Color(0xFF838383)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircularPercentIndicator(
                                      arcType: ArcType.FULL,
//                                      footer: Center(
//                                        child: Row(
//                                          children: <Widget>[
//                                            SizedBox(
//                                              width: 110.18,
//                                            ),
//                                            Text(
//                                              "0GB",
//                                              style: TextStyle(
//                                                  fontFamily: "Cabin",
//                                                  fontSize: 14,
//                                                  color: Color(0xFFDADADA),
//                                                  fontWeight: FontWeight.w500,
//                                                  letterSpacing: 0.9),
//                                            ),
//                                            SizedBox(
//                                              width: 50.18,
//                                            ),
//                                            Text(
//                                              "${gigabyte.toString()}",
//                                              style: TextStyle(
//                                                  fontFamily: "Cabin",
//                                                  fontSize: 14,
//                                                  color: Color(0xFFDADADA),
//                                                  fontWeight: FontWeight.w500,
//                                                  letterSpacing: 0.9),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
                                      radius: 100,
                                      lineWidth: 4.0,
//                                      percent: 1.0,
                                      center: Container(
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Colors.grey.shade200,
                                                offset: Offset(2, 4),
                                                blurRadius: 5,
                                                spreadRadius: 2)
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${dataVolume.toString()}',
                                            style: TextStyle(
                                                color: Color(0xFF4A81C3),
                                                fontSize: 20,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      progressColor: Color(0xFF4A81C3),
                                      backgroundColor: Color(0xFFEFF1FB),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "${daysLeft.toString()}",
                                      style: TextStyle(
                                          fontFamily: "Cabin",
                                          letterSpacing: 0.5,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF4A81C3)),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 100,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
//                        Container(
//                          width: 92,
//                          height: 80,
//                          decoration: BoxDecoration(
//                              shape: BoxShape.rectangle,
//                              color: Color(0xFFF38181),
//                              borderRadius: BorderRadius.circular(3.0)),
//                          child: Center(
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Image.asset(
//                                  "images/loan.png",
//                                  color: Color(0xFFF8F8F8),
//                                ),
//                                SizedBox(
//                                  height: 10.0,
//                                ),
//                                Center(
//                                  child: Text(
//                                    'Loan Request',
//                                    style: TextStyle(
//                                        color: Color(0xFFF8F8F8),
//                                        fontFamily: "Cabin",
//                                        letterSpacing: 0.5,
//                                        fontWeight: FontWeight.w500,
//                                        fontSize: 10),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    RenewPlan(
                                                        loginResponse: widget
                                                            ._loginResponse,
                                                        index: widget.index)));
                                      },
                                      child: Container(
                                        width: screenWidth * 0.37,
                                        height: 75,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Color(0xFFFCE38A),
                                            borderRadius:
                                                BorderRadius.circular(3.0)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              "images/renewal.png",
                                              color: Color(0xFF4A81C3),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              'Renewal',
                                              style: TextStyle(
                                                  color: Color(0xFF4A81C3),
                                                  fontFamily: "Cabin",
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    TopUpPlan(
                                                        loginResponse: widget
                                                            ._loginResponse,
                                                        index: widget.index)));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: Color(0xFF4A81C3),
                                            borderRadius:
                                                BorderRadius.circular(3.0)),
                                        width: screenWidth * 0.37,
                                        height: 75,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              "images/topup.png",
                                              color: Color(0xFFF8F8F8),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Top-Up',
                                              style: TextStyle(
                                                  color: Color(0xFFF8F8F8),
                                                  fontFamily: "Cabin",
                                                  letterSpacing: 0.5,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "TOP ACCOUNTS",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF3B4B64),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          TransactionHistory(
                                                            loginResponse: widget
                                                                ._loginResponse,
                                                          )));
                                        },
                                        color:
                                            Color(0xFFA5D2FD).withOpacity(0.21),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Text(
                                          "View All",
                                          style: TextStyle(
                                            color: Color(0xFF3B4B64),
                                            fontFamily: "Cabin",
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: ClampingScrollPhysics(),
                                child: ListView.separated(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    var productName = StringBuffer();
                                    var caption = StringBuffer();
                                    var price = StringBuffer();
                                    productName.write(widget._loginResponse.data
                                        .accounts[index].product.name);
                                    caption.write(widget._loginResponse.data
                                        .accounts[index].product.caption);
                                    price.write("N");
                                    price.write(widget._loginResponse.data
                                        .accounts[index].product.price);

                                    return Card(
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFFFEBEB),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  width: 40.0,
                                                  height: 40.0,
                                                  child: Image.asset(
                                                    "images/loan.png",
                                                    color: Color(0xFFF38181),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      "${productName.toString()}",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF3B4B64),
                                                        fontSize: 14.0,
                                                        fontFamily: "Cabin",
                                                        letterSpacing: 0.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.0,
                                                    ),
                                                    Text(
                                                      "${caption.toString()}",
                                                      style: TextStyle(
                                                          fontFamily: "Cabin",
                                                          letterSpacing: 0.5,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              Color(0xFFDADADA),
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 10.0),
                                                child: Text(
                                                  "${price.toString()}",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: "Cabin",
                                                    letterSpacing: 0.5,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF4A81C3),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 5,
                                    );
                                  },
                                  itemCount: widget._loginResponse.data.accounts
                                              .length >
                                          3
                                      ? 3
                                      : widget
                                          ._loginResponse.data.accounts.length,
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: 1, addAutomaticKeepAlives: true),
                    )
                  ],
                );
              }
              return buildBody();
            }),
      ),
    );
  }

  Widget buildBody() {
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
//                  if (isCollapsed)
//                    _controller.forward();
//                  else
//                    _controller.reverse();
//                  isCollapsed = !isCollapsed;
                });
              },
            ),
          ),
          pinned: true,
          backgroundColor: Color(0xFF4A81C3),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "N${widget._loginResponse?.data?.user?.balance == null ? "---" : widget._loginResponse?.data?.user?.balance}",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
              centerTitle: true,
          ),

        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var daysLeft = StringBuffer();
            daysLeft.write(widget
                ._loginResponse.data.accounts[widget.index].expirationDate
                .difference(DateTime.now())
                .inDays);
            daysLeft.write(" Days Left");

            return Container(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 238,
                    width: screenWidth,
                    margin: const EdgeInsets.only(bottom: 17.61),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        _dropDown(),
                        Text(
                          "Account Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              fontFamily: "Cabin",
                              letterSpacing: 0.9,
                              color: Color(0xFF838383)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CircularPercentIndicator(
                          arcType: ArcType.FULL,
                          footer: Center(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 110.18,
                                ),
                                Text(
                                  "0GB",
                                  style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 14,
                                      color: Color(0xFFDADADA),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.9),
                                ),
                                SizedBox(
                                  width: 50.18,
                                ),
                                Text(
                                  "${(widget._loginResponse.data.accounts[widget.index].product.display.dataCapacity.capacity) == null ? "---" : (widget._loginResponse.data.accounts[widget.index].product.display.dataCapacity.capacity).toStringAsFixed(0)}",
                                  style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 14,
                                      color: Color(0xFFDADADA),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.9),
                                ),
                              ],
                            ),
                          ),
                          radius: 100,
                          lineWidth: 4.0,
                          percent: 0.61,
                          center: Container(
                            height: 75,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: Offset(2, 4),
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${widget._loginResponse.data.accounts[widget.index].dataVolume.toStringAsFixed(2)} GB',
                                style: TextStyle(
                                    color: Color(0xFF4A81C3),
                                    fontSize: 20,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          progressColor: Color(0xFF4A81C3),
                          backgroundColor: Color(0xFFEFF1FB),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "${daysLeft.toString()}",
                          style: TextStyle(
                              fontFamily: "Cabin",
                              letterSpacing: 0.5,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4A81C3)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//                        Container(
//                          width: 92,
//                          height: 80,
//                          decoration: BoxDecoration(
//                              shape: BoxShape.rectangle,
//                              color: Color(0xFFF38181),
//                              borderRadius: BorderRadius.circular(3.0)),
//                          child: Center(
//                            child: Column(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Image.asset(
//                                  "images/loan.png",
//                                  color: Color(0xFFF8F8F8),
//                                ),
//                                SizedBox(
//                                  height: 10.0,
//                                ),
//                                Center(
//                                  child: Text(
//                                    'Loan Request',
//                                    style: TextStyle(
//                                        color: Color(0xFFF8F8F8),
//                                        fontFamily: "Cabin",
//                                        letterSpacing: 0.5,
//                                        fontWeight: FontWeight.w500,
//                                        fontSize: 10),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RenewPlan(
                                            loginResponse:
                                                widget._loginResponse,
                                            index: widget.index)));
                          },
                          child: Container(
                            width: screenWidth * 0.37,
                            height: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color(0xFFFCE38A),
                                borderRadius: BorderRadius.circular(3.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/renewal.png",
                                  color: Color(0xFF4A81C3),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Renewal',
                                  style: TextStyle(
                                      color: Color(0xFF4A81C3),
                                      fontFamily: "Cabin",
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        TopUpPlan(
                                            loginResponse:
                                                widget._loginResponse,
                                            index: widget.index)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color(0xFF4A81C3),
                                borderRadius: BorderRadius.circular(3.0)),
                            width: screenWidth * 0.37,
                            height: 75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "images/topup.png",
                                  color: Color(0xFFF8F8F8),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Top-Up',
                                  style: TextStyle(
                                      color: Color(0xFFF8F8F8),
                                      fontFamily: "Cabin",
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "TOP ACCOUNTS",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3B4B64),
                          fontSize: 12,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          TransactionHistory(
                                            loginResponse:
                                                widget._loginResponse,
                                          )));
                            },
                            color: Color(0xFFA5D2FD).withOpacity(0.21),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              "View All",
                              style: TextStyle(
                                color: Color(0xFF3B4B64),
                                fontFamily: "Cabin",
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var productName = StringBuffer();
                        var caption = StringBuffer();
                        var price = StringBuffer();
                        productName.write(widget
                            ._loginResponse.data.accounts[index].product.name);
                        caption.write(widget._loginResponse.data.accounts[index]
                            .product.caption);
                        price.write("N");
                        price.write(widget
                            ._loginResponse.data.accounts[index].product.price);

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
                                        color: Color(0xFFFFEBEB),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      width: 40.0,
                                      height: 40.0,
                                      child: Image.asset(
                                        "images/loan.png",
                                        color: Color(0xFFF38181),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "${productName.toString()}",
                                          style: TextStyle(
                                            color: Color(0xFF3B4B64),
                                            fontSize: 14.0,
                                            fontFamily: "Cabin",
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "${caption.toString()}",
                                          style: TextStyle(
                                              fontFamily: "Cabin",
                                              letterSpacing: 0.5,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFDADADA),
                                              fontSize: 12),
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
                                      "${price.toString()}",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Cabin",
                                        letterSpacing: 0.5,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF4A81C3),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: widget._loginResponse.data.accounts.length > 3
                          ? 3
                          : widget._loginResponse.data.accounts.length,
                    ),
                  ),
                ],
              ),
            );
          }, childCount: 1, addAutomaticKeepAlives: true),
        )
      ],
    );
  }

  _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      String SelectedItem = name;
    });
  }

  void callActiveSession(AccountBloc dataPlanBloc) async {
//    String iAccount = await SecureStorage.getIAccount() == null ? widget._loginResponse.data.user.iAccount : SecureStorage.getIAccount();
//    String iCustomer = await SecureStorage.getICustomer()  == null ? widget._loginResponse.data.user.iCustomer : SecureStorage.getICustomer();
    String iAccount = widget._loginResponse.data.user.iAccount;
    String iCustomer = widget._loginResponse.data.user.iCustomer;

    ActiveSessionModel activeSessionModel = ActiveSessionModel(
        iCustomer: int.parse(iCustomer), iAccount: int.parse(iAccount));
    dataPlanBloc.dispatch(UpdateAccountCustomer(account: activeSessionModel));

    dataPlanBloc.dispatch(GetAccountEvent(account: activeSessionModel));
  }

  Future<bool> _onBackPressed() {

    return showDialog(context: context, builder: (context)=> AlertDialog(
      title: Text("Do you want to exit the app?"),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.pop(context, false), child: Text("No")),
        FlatButton(onPressed: () async{
          await Helper.logout();
//          Navigator.pop(context, true);
          Navigator.of(context).popUntil((route) => route.isFirst);

        }, child: Text("Yes")),
      ],
    ));
  }
}

Widget NavigationItem(String iconName, String text, context) {
  return InkWell(
    onTap: () {
//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (BuildContext context) {
//            return RenewPlan();
//          },
//        ),
//      );
    },
    child: Padding(
      padding: const EdgeInsets.only(
        left: 25,
        top: 30.0,
      ),
      child: Row(
        children: <Widget>[
          Image.asset(
            iconName,
            color: Colors.white,
          ),
          SizedBox(
            width: 15,
          ),
          Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Cabin",
                  fontSize: 14))
        ],
      ),
    ),
  );
}

Image getIcon(String selector) {
  if (selector == TransactionType.LOAN_REQUEST) {
    return Image.asset(
      "images/loan.png",
      color: Color(0xFFF8F8F8),
    );
  } else if (selector == TransactionType.RENEWAL) {
    return Image.asset(
      "images/loan.png",
      color: Color(0xFFF8F8F8),
    );
  } else if (selector == TransactionType.TOP_UP) {
    return Image.asset(
      "images/loan.png",
      color: Color(0xFFF8F8F8),
    );
  }
}

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

enum TransactionType { LOAN_REQUEST, TOP_UP, RENEWAL }

final areaValues = EnumValues({
  "Loan Request ": TransactionType.LOAN_REQUEST,
  "Top Up": TransactionType.TOP_UP,
  "Renewal": TransactionType.RENEWAL
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
