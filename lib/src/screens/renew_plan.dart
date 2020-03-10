
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfcare/bloc/data_plan/bloc/dataplan_bloc.dart';
import 'package:selfcare/drawer/menu_dashboard_layout.dart';
import 'package:selfcare/model/DataModel/transaction.dart';
import 'package:selfcare/model/LoginModel/LoginResponse.dart';
import 'package:selfcare/util/line_dash_widget.dart';

class RenewPlan extends StatefulWidget {
  LoginResponse _loginResponse;
  int index;
  String periodDuration = "1";
  TransactionRequest transactionRequest;

  var vat;

  var rand;

  RenewPlan({Key key, LoginResponse loginResponse, int index})
      : //assert(loginResponse != null),
        _loginResponse = loginResponse,
        index = index,
        super(key: key);

  @override
  _RenewPlanState createState() => _RenewPlanState();
}

class _RenewPlanState extends State<RenewPlan>
    with SingleTickerProviderStateMixin {
  static const platform = const MethodChannel('com.startActivity/testChannel');

  DataplanBloc dataplanBloc;
  List<String> durations = ["1", "2", "3", "4", "5", "6", "7"];
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
    dataplanBloc = DataplanBloc();

    widget.vat = 0.075 * widget._loginResponse.data.accounts[widget.index].product.price *
        int.parse(widget.periodDuration);

    widget.rand= DateTime.now().millisecondsSinceEpoch.toString();

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 1).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);

    // ignore: missing_return
    platform.setMethodCallHandler((call) {
      final String argument = call.arguments;
      switch (call.method) {
        case "onSuccess":
          dataplanBloc.dispatch(ReferenceConfirmClickEvent(reference: argument));

          break;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    dataplanBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    screenHeight = size.height;
    screenWidth = size.width;
    backgroundHeight = screenHeight * 0.75;

    return Scaffold(
      backgroundColor: Color(0xFF4A81C3),
      body: Container(
        child: Stack(
          children: <Widget>[
            menu(context),
            mainBody(context),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return BlocProvider(
      builder: (context) => dataplanBloc,
      child: BlocListener<DataplanBloc, DataplanState>(
        listener: (context, state) async {
          // ignore: missing_return

          if (state is TransactionSuccessFul) {
            String response = "";
            try {
              final String result = await platform.invokeMethod(
                'chargeCard', {"reference" : state.transactionResponse.data.transRef});

              response = result;
            } on PlatformException catch (e) {
              response = "Failed to Invoke: '${e.message}'.";
            }
          }
          if (state is TransactionFailure) {
            buildButtonWidget();
          }

          if (state is TransactionSuccessFully) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialog(
                  title: new Text(
                      "Data Purchased Successful"),
                  content: new Text(
                      "Transaction Successful with - Reference ${state.completeTransactionResponse.data.transactionReference}."),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("Okay"),
                      onPressed: () {
                        Navigator.pop(context);
//                        Navigator.of(context).popUntil((route) => route.isFirst);
                        return;
                      },
                    ),
                  ],
                );
              },
            );
          }

        },
        child: BlocBuilder(
          bloc: dataplanBloc,
          builder: (BuildContext context, DataplanState state) {
            if (state is DataplanInitial) {
              return buildButtonWidget();
            } else if (state is TransactionLoading) {
              return buildLoading();
            } else if (state is TransactionFailure) {
              return buildButtonWidget();
            }

            return buildButtonWidget();
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF4A81C3), Color(0xFF4A81C3)])),
      child: SpinKitThreeBounce(
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget buildButtonWidget() {
    return InkWell(
      onTap: () async {

        widget.transactionRequest = TransactionRequest(
            amount: widget._loginResponse.data.accounts[widget.index].product.price * int.parse(widget.periodDuration)+ widget.vat,
            customerDesc: "LTE Customer Mobile Payment",
            customerId: int.parse(widget._loginResponse.data.user.iCustomer),
            fullName: widget._loginResponse.data.user.lastName,
            email: widget._loginResponse.data.user.userName,
            itemCode: "0",
            itemName: "Account Renewal",
            vat:  widget.vat,
            iAccount:  int.parse(widget._loginResponse.data.user.iAccount),
            iCustomer: int.parse(widget._loginResponse.data.user.iCustomer),
            operatorId: 1,
            iProduct: widget._loginResponse.data.accounts[widget.index].product.iProduct, //111
            phoneNumber: widget._loginResponse.data.user.mobilePhone,
            portalCode: "PortalCode1",
            providerId: 4,
            session: "Account-${widget._loginResponse.data.accounts[widget.index].iAccount}-${widget.rand}",
            value: widget._loginResponse.data.accounts[widget.index].product.price * int.parse(widget.periodDuration)+ widget.vat,
            allocateAll: true);

        dataplanBloc.dispatch(TransactionStarted(widget.transactionRequest));

        dataplanBloc
          ..dispatch(DataplanClickEvent(
              transactionRequest: widget.transactionRequest));
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF4A81C3), Color(0xFF4A81C3)])),
        child: Text(
          'PAY   N${widget._loginResponse.data.accounts[widget.index].product.price *
              int.parse(widget.periodDuration) + widget.vat}',
          style: TextStyle(
              fontSize: 18,
              fontFamily: "Cabin",
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildPeriodChoiceWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            border: Border.all(
              color: Color(0xFFDADADA),
              width: 1.0,
            )),
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Text(
              "Choose a Period",
              style: TextStyle(
                  color: Color(0xFF838383),
                  letterSpacing: 1,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          value: widget.periodDuration,
          underline: Container(
            height: 1.0,
          ),
          onChanged: (String value) {
            setState(() {
              widget.periodDuration = value;
            });
          },
          items: durations.map((String user) {
            return DropdownMenuItem<String>(
              value: user,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  user,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
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
                      fontWeight: FontWeight.normal),
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

 Widget mainBody(BuildContext context) {
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
          color: Color(0xFFFFFFFF),
          child: home(context),
        ),
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
              child: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
              ),
              onTap: () {
                Navigator.pop(context);
//                setState(() {
//                  if (isCollapsed)
//                    _controller.forward();
//                  else
//                    _controller.reverse();
//                  isCollapsed = !isCollapsed;
//                });
              },
            ),
          ),
          pinned: true,
          backgroundColor: Color(0xFF4A81C3),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "RENEWAL PLAN",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                    child: _body(context),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 20, left: 20.0, right: 30.0),
                    child: _submitButton(context),
                  )
                ],
              );
            }, childCount: 1))
      ],
    );
  }

  _body(context) {
    widget.vat = 0.075 * widget._loginResponse.data.accounts[widget.index].product.price *
        int.parse(widget.periodDuration);
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(
          top: 30,
        ),
        color: Color(0xFFFFFFFF),
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 39.83, 0, 0),
                child: Text(
                  "${widget._loginResponse.data.accounts[widget.index]
                      .portaoneAccountCredential.portaoneUsername}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Cabin",
                    color: Color(0xFF3B4B64),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Account MDN",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 12,
                    color: Color(0xFF838383),
                  ),
                ),
              ),
              Container(
                // height: 0.5,
                // color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const LineDashedPainter(color: Color(0xFFF8F8F8)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "${widget._loginResponse.data.accounts[widget.index].product
                      .name} - N${widget._loginResponse.data.accounts[widget.index].product
                      .fundPrice.toStringAsFixed(2)}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Cabin",
                    color: Color(0xFF3B4B64),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "${widget._loginResponse.data.accounts[widget.index].product.caption}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 12,
                    color: Color(0xFF838383),
                  ),
                ),
              ),

              Container(
                // height: 0.5,
                // color: Colors.white,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: const LineDashedPainter(color: Color(0xFFF8F8F8)),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  "${widget.vat}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Cabin",
                    color: Color(0xFF3B4B64),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "VAT",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Cabin",
                      color: Color(0xFF838383),
                      fontWeight: FontWeight.w500),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "Period",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 12,
                    color: Color(0xFF838383),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: _buildPeriodChoiceWidget(context),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Remaining Data",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Cabin",
                        color: Color(0xFF838383),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${(widget._loginResponse.data.accounts[widget.index].dataVolume).toStringAsFixed(1)}GB",
                      //"${state.bookingForm.schedule.busName}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Cabin",
                        color: Color(0xFF3B4B64),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1.0,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFF8F8F8),
                      width: 0.0,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${widget._loginResponse.data.accounts[widget.index].product
                          .validity} Month",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 14,
                        color: Color(0xFF3B4B64),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${widget._loginResponse.data.accounts[widget.index].product.display
                          .dataCapacity.capacity}GB",
                      //"${state.bookingForm.schedule.busName}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Cabin",
                        color: Color(0xFF3B4B64),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Validity",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 12,
                        color: Color(0xFF838383),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Data Capacity",
                      //"${state.bookingForm.schedule.busName}",
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Cabin",
                        color: Color(0xFF838383),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  "You are required to pay (7.5% VAT inclusive)",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Cabin",
                    letterSpacing: 0.5,
                    color: Color(0xFF4A81C3),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
//                  Container(
//                    // height: 0.5,
//                    // color: Colors.white,
//                    padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
//                    child: const LineDashedPainter(color: Colors.blueGrey),
//                  ),
              SizedBox(
                height: 42.76,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
