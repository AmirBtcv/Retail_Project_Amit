import 'package:amit_final_project/model/User.dart';
import 'package:amit_final_project/network/ServiceApi.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Register Page",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
        ),
        body:



            Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  controller: _nameController,
                  validator: (namevalue) =>
                      namevalue.isEmpty ? 'Name is Required' : null,
                ),


                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  controller: _emailController,
                  validator: (emailvalue) {
                    if (emailvalue.isEmpty)
                      return "Email is Reuired";
                    else if (!EmailValidator.validate(emailvalue))
                      return "Please enter a valid email";
                    else return null;
                  },
                ),


                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  controller: _passwordController,
                  validator: (passvalue) =>
                      passvalue.isEmpty ? 'Password is Required' : null,
                ),

                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password'),
                  controller: _confirmPasswordController,
                  validator: (confirmpassvalue) {
                    if(confirmpassvalue.isEmpty)
                      return 'Confirm Password is Required';
                    else if(confirmpassvalue != _passwordController.text)
                      return "Password don't match";
                    else return null;
                  }

                ),


                ElevatedButton(
                  onPressed: () => registerBtnClicked(),
                  child: Text('Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )),
                  // color: Colors.black,
                )
              ],
            ),
          ),
        )
        // ],
        // ),
        // ),
        );
    // );
  }

  registerBtnClicked() async{
    if (!_formkey.currentState.validate()) {
      Fluttertoast.showToast(
          msg: "Registration Failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else {
      // if (!_formKey.currentState.validate()) {
      Fluttertoast.showToast(
          msg: "Registration Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.pink);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));


      User user = User(name: _nameController.text,email: _emailController.text,password: _passwordController.text);
      dynamic res = await ServiceApi.instance.register(user);
      if (ServiceApi.instance==201){
        user.token = res;
        print('Token :$res');
      }else {
        print('Erorr :${ServiceApi.statuscode},$res');
      }
    }
  }
}
