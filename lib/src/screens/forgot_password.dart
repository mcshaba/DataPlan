import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfcare/bloc/forgot_pass_bloc/bloc/forgot_password_bloc.dart';
import 'package:selfcare/repository/login_repository.dart';
import 'package:selfcare/src/screens/login.dart';
import 'package:selfcare/util/flushbar_helper.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool loading = false;
  String errorMessage = "";
  ForgotPassBloc forgotPasswordBloc;

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid Email';
    else
      return null;
  }

  void _onEmailChange() {
    forgotPasswordBloc.dispatch(EmailChange(username: _emailController.text));
  }

  @override
  void dispose() {
    super.dispose();
    forgotPasswordBloc.dispose();
    _emailController.dispose();
  }

  @override
  void initState() {
    super.initState();
    forgotPasswordBloc = ForgotPassBloc();
    forgotPasswordBloc.dispatch(ForgotPasswordStarted());

    _emailController.addListener(_onEmailChange);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          builder: (context) => ForgotPassBloc(repository: LoginRepository()),
        ),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF4A81C3),
        body: loading
            ? Center(
                child: SpinKitDoubleBounce(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 73.0),
                            child: _title(),
                          ),
                          loginForm(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        elevation: 0,
//      ),
//      body: SafeArea(
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
//          child: !emailSent
//              ? Form(
//            key: _formKey,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: <Widget>[
//
//                TextFormField(
//                  keyboardType: TextInputType.emailAddress,
//                  textInputAction: TextInputAction.done,
//                  controller: _emailController,
//                  validator: (value) => validateEmail(value),
//                  decoration: InputDecoration(
//                    labelText: "Email",
//                    prefixIcon: Icon(Icons.email),
//                  ),
//                ),
//                SizedBox(height: 12),
//                RaisedButton(
//                  child: Text("Submit"),
//                  onPressed: _submitForm,
//                ),
//              ],
//            ),
//          )
//              : Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text("Reset email sent to",
//                  style: Theme.of(context).textTheme.headline),
//              // SizedBox(height: 12),
//              Text(_emailController.text,
//                  style: Theme.of(context).textTheme.subtitle),
//              SizedBox(height: 36),
//              Text("Please check your email",
//                  style: Theme.of(context).textTheme.subtitle),
//            ],
//          ),
//        ),
//      ),
//    );
//  }

  Widget loginForm() {
    return Container(
      margin: const EdgeInsets.only(top: 24.0, right: 30, left: 30),
      decoration: BoxDecoration(
        color: Color(0xFF4A81C3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _header(),
          SizedBox(
            height: 24,
          ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Email",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cabin",
                      color: Color(0xFFFFFFFF),
                      fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _emailController,
                  validator: (value) => validateEmail(value),
                  onFieldSubmitted: (v) {
                    FocusScope.of(context).nextFocus();
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xffffffff),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDADADA))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDADADA))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    filled: true,
                  ),
                  style: TextStyle(color: Color(0xFF4A4A4A)),
                ),
                SizedBox(
                  height: 20,
                ),
                _submitButton(),
                SizedBox(
                  height: 90,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Image.asset("images/logo_white.png");
  }

  Widget _header() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 39.0),
            child: Text(
              'Forgot Password',
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 18,
                  fontFamily: "Cabin",
                  letterSpacing: -0.09,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Input email address to reset password',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Cabin",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return BlocProvider(
      builder: (context) => forgotPasswordBloc,
      child: BlocListener<ForgotPassBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Login()));
            return;
          }
          if (state is ForgotPasswordFailure) {
            var loading =
                FlushbarHelper.createLoading(message: '${state.error}')
                  ..show(context);
            Future.delayed(
                new Duration(seconds: 10), () => loading.dismiss(context));
          }
        },
        child: BlocBuilder(
          bloc: forgotPasswordBloc,
          builder: (BuildContext context, ForgotPasswordState state) {
            if (state is InitialStatusState) {
              return buildButtonWidget();
            } else if (state is ForgotPasswordLoading) {
              return buildLoading();
            } else if (state is ForgotPasswordFailure) {
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
      width: MediaQuery.of(context).size.width,
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
      onTap: () {
        forgotPasswordBloc
          ..dispatch(ForgotPasswordEventPressed(
              forgotModel: forgotPasswordBloc.forgotModel));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF254B87), Color(0xFF254B87)])),
        child: Text(
          'Send',
          style: TextStyle(
              fontSize: 14,
              fontFamily: "Cabin",
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white),
        ),
      ),
    );
  }
}
