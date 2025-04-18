import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/inputform.dart';
import 'package:flutter_application_1/component/purplebutton_logo.dart';
import 'package:flutter_application_1/function/fade_to_page.dart';
import 'package:flutter_application_1/function/push_to_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/pages/loading_dialog.dart';
import 'package:flutter_application_1/pages/nav.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:flutter_application_1/pages/welcome.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool uservalidate = false;
  bool passwordvalidate = false;

  final TextEditingController _fieldUsername = TextEditingController();
  final TextEditingController _fieldPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
          fadeToPage(context, Welcome(), 200);        
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height -130,
            child: Column(
                children: [
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.white,),),
                      ],
                    ),
                  ),
                  Expanded(child: Container()),
                  inputform(formname: 'Username', lable: 'Enter your Username',controller: _fieldUsername,validate:  uservalidate,errormas: 'Username wrong',),
                  inputform(formname: 'Password', lable: 'Enter your Password',controller: _fieldPassword,validate: passwordvalidate,errormas: 'Password wrong',),
                  Expanded(flex: 2, child: Container()),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width-50,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        User? matchedUser;
            
                        try {
                          matchedUser = userList.value.firstWhere(
                            (user) => user.username == _fieldUsername.text.trim(),
                          );
                          setState(() {
                            uservalidate = false; // Username found
                          });
                        } catch (e) {
                          matchedUser = null;
                          setState(() {
                            uservalidate = true; // Username not found
                            passwordvalidate = false;
                          });
                        }
            
                        if (matchedUser != null) {
                          if (matchedUser.password == _fieldPassword.text.trim()) {
                            // Successful login
                            currentUser.value = matchedUser;
            
                            setState(() {
                              passwordvalidate = false;
                            });
                            showLoadingDialog(context);
                            await Future.delayed(Duration(seconds: 1));
                            hideLoadingDialog(context);
                            fadeToPage(context, Navbar(), 200);
                          } else {
                            // Password does not match
                            setState(() {
                              passwordvalidate = true;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        side: BorderSide(
                          color:const Color.fromRGBO(136, 117, 255,1)
                        ),
                        backgroundColor: Color.fromRGBO(136, 117, 255,1),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(0)
                        )
                      ), 
                      child: 
                          Text('Login',style: TextStyle(color: Colors.white,fontSize: 16),),
                      ),
                  ),
                  SizedBox(height: 10,),
                  Text('or',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:Color.fromARGB(255, 151, 151, 151)),),
                  SizedBox(height: 10,),
                  purplebutton_logo(lable: 'Login with Google', link: Login(), fill: false, logo: 'assets/icons/google.png'),
                  Expanded(flex: 2, child: Container()),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Color.fromARGB(255, 151, 151, 151)),
                        text: 'Don’t have an account? '
                      ),
                      TextSpan(
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Colors.white,),
                        text: 'Register',
                        recognizer: TapGestureRecognizer()..onTap = (){
                          pushToPage(context, Register(), 200);
                        }
                      )
                      
                    ]
                  )),
                  Expanded(child: Container()),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
