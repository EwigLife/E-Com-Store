import 'package:flutter/material.dart';
import 'package:wordpress_app/screens/signupPage.dart';
import 'package:wordpress_app/utils/ProgressHUD.dart';
import 'package:wordpress_app/api_service.dart';
import 'package:wordpress_app/utils/formHelper.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String username;
  String password;
  APIService apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      child: _uiSetup(context),
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Form(
                    key: globalKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 25),
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (input) => username = input,
                          validator: (input) => !input.contains('@')
                              ? "Email Id should be valid"
                              : null,
                          decoration: new InputDecoration(
                            hintText: "Email Address",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red)),
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        new TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                          keyboardType: TextInputType.text,
                          onSaved: (input) => password = input,
                          validator: (input) => input.length < 6
                              ? "Password should be more than 3 characters"
                              : null,
                          obscureText: hidePassword,
                          decoration: new InputDecoration(
                            hintText: "Password",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.2))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red)),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.red,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Colors.red
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 80),
                          onPressed: () {
                            if (validateAndSave()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              apiService
                                  .loginCustomer(username, password)
                                  .then((ret) => {
                                        if (ret != null)
                                          {
                                            FormHelper.showMessage(
                                                context,
                                                'WooCommerce App',
                                                'Login Successfull',
                                                'OK',
                                                (){},
                                              ),
                                          }
                                          else {
                                            FormHelper.showMessage(
                                                context,
                                                'WooCommerce App',
                                                'Invalid Credentials',
                                                'OK',
                                                (){},
                                              ),
                                          }
                                      });
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.red,
                          shape: StadiumBorder(),
                        ),
                        FlatButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 75),
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.red,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () { 
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SignupPage()));
                         },
                        child: Text("Sign UP"),),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
