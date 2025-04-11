import 'package:flutter/material.dart';
import 'package:flutter_application_1/component/purplebutton.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/register.dart';



class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
     body: Center(
       child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Container()),
            Text('Welcome to UpTodo',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 20,),
            Text('Please login to your account or create',style: TextStyle(fontSize: 16,color: Colors.white.withAlpha(150)),),
            Text('new account to continue',style: TextStyle(fontSize: 16,color: Colors.white.withAlpha(150),),),
            Expanded(flex: 4, child: Container()),
            purplebutton(lable:'LOGIN',link: const Login(),fill: true,),
            SizedBox(height: 20,),
            purplebutton(lable: 'CREATE ACCOUNT', link: const Register(), fill: false),
            Expanded(child: Container()),
          ],
       ),
     ),
    );
  }
}
