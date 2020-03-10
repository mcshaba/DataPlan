import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:selfcare/bloc/login/bloc/login_bloc.dart';
import 'package:selfcare/drawer/menu_dashboard_layout.dart';
import 'package:selfcare/repository/login_repository.dart';

import 'forgot_password.dart';


class Login extends StatefulWidget {
  static const String id = "/login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;
  String errorMessage = "";
  LoginBloc loginBloc;


  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid Email';
    else
      return null;
  }


  bool isCompleted() {
    if(_emailController.text.isNotEmpty &&  _passwordController.text.isNotEmpty){
      return true;
    }
    return false;
  }
  void _onEmailChange() {
    loginBloc.dispatch(UsernameChange(username: _emailController.text));
  }

  void _onPasswordChange() {
    loginBloc.dispatch(PasswordChange(password: _passwordController.text));
  }

  @override
  void dispose() {
    super.dispose();
    loginBloc.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
    loginBloc.dispatch(LoginStarted());

    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  void _submitForm() async {
//    if (_formKey.currentState.validate()) {
//      try {
//        setState(() {
//          loading = true;
//        });
//        final user = await Auth.signIn(_emailController.text, _passwordController.text);
//        if (user != null)
//          Navigator.pushAndRemoveUntil(
//              context,
//              MaterialPageRoute(builder: (context) => Home(user)),
//              ModalRoute.withName("/"));
//      } catch (e) {
//        setState(() {
//          loading = false;
//          switch (e.code) {
//            case "ERROR_INVALID_EMAIL":
//              errorMessage = "Your email address appears to be malformed.";
//              break;
//            case "ERROR_WRONG_PASSWORD":
//              errorMessage = "Incorrect password.";
//              break;
//            case "ERROR_USER_NOT_FOUND":
//              errorMessage = "User with this email doesn't exist.";
//              break;
//            case "ERROR_USER_DISABLED":
//              errorMessage = "User with this email has been disabled.";
//              break;
//            case "ERROR_TOO_MANY_REQUESTS":
//              errorMessage = "Too many requests. Try again later.";
//              break;
//            default:
//              errorMessage = "Something went wrong.";
//          }
//        });
//      }
//    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return MultiBlocProvider(
      providers: [
        BlocProvider(builder: (context) =>
            LoginBloc(
                repository: LoginRepository()
            ),),
      ],
      child: Scaffold(
        backgroundColor: Color(0xFF4A81C3),
        body: loading
            ? Center(
          child: SpinKitDoubleBounce(
            color: Theme
                .of(context)
                .primaryColor,
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
                    Padding(padding: const EdgeInsets.only(top: 73.0),
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

  Widget loginForm() {
    return Container(
      margin: const EdgeInsets.only(top: 24.0, right: 30, left: 30),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
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
                      color: Color(0xFF979797),
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
                    border: new OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: const Color(0xFFDADADA), width: 0.1)),
//                    fillColor: Color(0xffffffff),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDADADA))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDADADA))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    filled: true,
                  ),
                  style: TextStyle(
                      color: Color(0xFF4A4A4A)
                  ),
                  autovalidate: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cabin",
                      color: Color(0xFF979797),
                      fontSize: 12),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.length < 6)
                      return "Password must be at least 6 characters";
                    return null;
                  },
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide:
                        new BorderSide(color: const Color(0xFFDADADA))),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDADADA))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDADADA))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                  ),
                  obscureText: true,
                  autovalidate: true,
                  style: TextStyle(
                      color: Color(0xFF4A4A4A)
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPass()));

                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4A81C3),
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.w500)),
                  ),
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
              'Sign in',
              style: TextStyle(
                  color: Color(0xFF4A4A4A),
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
            'Welcome back !!!',
            style: TextStyle(
              color: Colors.grey,
              fontFamily: "Cabin",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Great Connectivity Awaits you',
            style: TextStyle(
              color: Color(0xFF979797),
              fontFamily: "Cabin",
              fontWeight: FontWeight.w400,
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return BlocProvider(
      builder: (context) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state){
          if(state is LoginStateSuccess){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuDashBoardPage(loginResponse: state.loginResponse,)));
            return;
          }
          if(state is LoginStatusFailure) {
            var loading = FlushbarHelper.createLoading(message: '${state.error}')..show(context);
            Future.delayed(new Duration(seconds: 10),

                    () => loading.dismiss(context)
            );
          }
        },
        child: BlocBuilder(
          bloc: loginBloc,
          builder: (BuildContext context, LoginState state) {
            if (state is InitialLoginStatusState) {
              return buildButtonWidget();
            } else if (state is LoginLoading) {
              return buildLoading();
            }
            else if (state is LoginStatusFailure) {
              return buildButtonWidget();
            }

            return buildButtonWidget();

          },),
      ),
    );
  }

  Widget buildLoading(){
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
      onTap: (isCompleted())? () async {
        loginBloc..dispatch(LoginWithUsernamePressed(login: loginBloc.login));
      }: null,
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
          'Sign in',
          style: TextStyle(fontSize: 14,
              fontFamily: "Cabin",
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white),
        ),
      ),
    );
  }
}


