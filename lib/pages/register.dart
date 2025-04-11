import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/inputform.dart';
import 'package:flutter_application_1/component/purplebutton_logo.dart';
import 'package:flutter_application_1/function/fade_to_page.dart';
import 'package:flutter_application_1/function/push_to_page.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/welcome.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool uservalidate = false;
  bool passwordvalidate = false;
  bool passconvalidate = false;
  final TextEditingController _fieldUsername = TextEditingController();
  final TextEditingController _fieldPassword = TextEditingController();
  final TextEditingController _fieldCPassword = TextEditingController();

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
        child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.only(left: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Register',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32,color: Colors.white,),),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
              inputform(formname: 'Username', lable: 'Enter your Username',controller: _fieldUsername,validate: uservalidate,errormas: 'already used',),
              inputform(formname: 'Password', lable: 'Enter your Password',controller: _fieldPassword,validate: passwordvalidate,errormas: 'password not match',),
              inputform(formname: 'Confirm Password', lable: 'Confirm your Password',controller: _fieldCPassword,validate: passconvalidate,errormas: 'password not match',),
              Expanded(flex: 2, child: Container()),
              SizedBox(
                width: 327,
                height: 48,
                child: ElevatedButton(
                  onPressed: (){
                    User? matchedUser;
                    try{
                       matchedUser = userList.value.firstWhere((user)=>user.username == _fieldUsername.text);
                    } catch(e){
                      setState(() {
                        uservalidate = false;
                      });
                      matchedUser = null;
                    }

                    if(matchedUser!=null){
                      setState(() {
                        uservalidate = true;
                      });
                    }
                    else if(_fieldPassword.text == _fieldCPassword.text && _fieldPassword.text != ''){
                      final user = User(username: _fieldUsername.text, password: _fieldPassword.text);
                      userList.value = [...userList.value,user];
                      setState(() {
                        uservalidate = false;
                        passwordvalidate = false;
                        passconvalidate = false;
                      });
                      pushToPage(context, Login(), 200);
                    }
                    else{
                      setState(() {
                        passwordvalidate = true;
                        passconvalidate = true;
                      });
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                      color:const Color.fromRGBO(136, 117, 255,1)
                    ),
                    backgroundColor:  Color.fromRGBO(136, 117, 255,1),
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0)
                    )
                  ), 
                  child: 
                      Text('Register',style: TextStyle(color: Colors.white,fontSize: 16),)
                  ),
              ),
              SizedBox(height: 10,),
              Text('or',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color:Color.fromARGB(255, 151, 151, 151)),),
              SizedBox(height: 10,),
              purplebutton_logo(lable: 'Register with Google', link: Login(), fill: false, logo: 'assets/icons/google.png'),
              Expanded(flex: 2, child: Container()),
              RichText(text: TextSpan(
                children: [
                  TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Color.fromARGB(255, 151, 151, 151)),
                    text: 'Already have an account?'
                  ),
                  TextSpan(
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color:Colors.white,),
                    text: 'Login',
                    recognizer: TapGestureRecognizer()..onTap = (){
                      pushToPage(context, Login(), 200);
                    }
                  )
                  
                ]
              )),
              Expanded(child: Container()),
            ],
        ),
      ),
    );
  }
}