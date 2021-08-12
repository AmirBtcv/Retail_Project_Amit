
import 'package:amit_final_project/globale/Dialogs.dart';
import 'package:amit_final_project/login/Registration.dart';
import 'package:amit_final_project/model/User.dart';
import 'package:amit_final_project/network/ServiceApi.dart';
import 'package:amit_final_project/tabs/tabspage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        // centerTitle: true,
      ),


      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

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
                SizedBox(height: 10,),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  controller: _passwordController,
                  validator: (passvalue) =>
                  passvalue.isEmpty ? 'Password is Required' : null,
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: " Dosen't have account",style: TextStyle(color: Colors.black)),
                        WidgetSpan(child: SizedBox(width: 5,)),
                        WidgetSpan(child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Registration()));

                            },
                          child: Text("Regisre"
                          ,style: TextStyle(
                              color: Colors.blueAccent,
                            ),),
                        ))
                      ]
                    ),
                  ),
                ),
                SizedBox(height: 20,),



                ElevatedButton(onPressed: () => loginBtnClicked(),child: Text('Login') ),
                // loginBtnClicked)
              ],
            ),
          ),
        ),
      ),
    );
  }

  loginBtnClicked () async {


    await Dialogs.showProgressDialog(context: context,msg: "Loading");

      if (!_formkey.currentState.validate())
      {
        Fluttertoast.showToast(
            msg: "Missing Failed",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        await Dialogs.hideProgressDialog();
        return;
      }

      User user =User(email: _emailController.text,password: _passwordController.text);
      String res = await ServiceApi.instance.login(user);
      await Dialogs.hideProgressDialog();
      if (ServiceApi.statuscode==200) {

        user.token = res;
        // Save token user to shared preference


        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => TabsPage()));
        print('token :${ServiceApi.statuscode},$res');

      } else {
        await Dialogs.hideProgressDialog();
        print('Error :${ServiceApi.statuscode},$res');


          Fluttertoast.showToast(
              msg: ('Error :${ServiceApi.statuscode},$res'),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          return;

      }



  }

}
