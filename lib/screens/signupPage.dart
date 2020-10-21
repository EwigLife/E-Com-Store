import 'package:flutter/material.dart';
import 'package:wordpress_app/api_service.dart';
import 'package:wordpress_app/model/customer.dart';
import 'package:wordpress_app/utils/ProgressHUD.dart';
import 'package:wordpress_app/utils/formHelper.dart';
import 'package:wordpress_app/utils/validatorService.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  APIService apiService;
  CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  
  @override
  void initState() {
    apiService = APIService();
    model = CustomerModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text('Sign Up'),
      ),
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _formUI(),
          ), 
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
        ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel('First Name'),
                FormHelper.textInput(
                  context,
                  model.firstName,
                  (value) => {
                    this.model.firstName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter First Name.';
                    }
                    return null;
                  }
                ),
                FormHelper.fieldLabel('Last Name'),
                FormHelper.textInput(
                  context,
                  model.lastName,
                  (value) => {
                    this.model.lastName = value,
                  },
                  onValidate: (value) {
                    return null;
                  }
                ),
                FormHelper.fieldLabel('Email'),
                FormHelper.textInput(
                  context,
                  model.email,
                  (value) => {
                    this.model.email = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter Valid Email.';
                    }
                    if (value.isNotEmpty && !value.toString().isValidEmail()) {
                      return 'please Enter Valid Email Id.';
                    }
                    return null;
                  }
                ),
                FormHelper.fieldLabel('Password'),
                FormHelper.textInput(
                  context,
                  model.password,
                  (value) => {
                    this.model.password = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Please Enter Password.';
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    color: Theme.of(context).accentColor.withOpacity(0.4),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ), 
                    onPressed: (){
                      setState((){
                        hidePassword = !hidePassword;
                      });
                    }
                  ),
                ),
                SizedBox(height: 20,),
                Center(
                  child: FormHelper.saveButton(
                    'Register', (){
                      if (validateAndSave()) {
                        print(model.toJson());
                        setState((){
                          isApiCallProcess = true;
                        });

                        apiService.createCustomer(model).then(
                          (ret) {
                            setState((){
                              isApiCallProcess = false;
                            });
                            if (ret) {
                              FormHelper.showMessage(
                                context,
                                'WooCommerce App',
                                'Registration Successfull', 
                                'ok', 
                                (){
                                  Navigator.of(context).pop();
                                }
                              );
                            } else {
                              FormHelper.showMessage(
                                context, 
                                'WooCommerece App', 
                                'Email Id Already Registered.', 
                                'ok', 
                                (){
                                  Navigator.of(context).pop();
                                }
                              );
                            }
                          }
                        );
                      }
                    }),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if(form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

}