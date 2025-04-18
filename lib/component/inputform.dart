import 'package:flutter/material.dart';

// ignore: must_be_immutable
class inputform extends StatelessWidget {
  final String lable;
  final String formname;
  final TextEditingController controller;
  bool validate;
  String? errormas;

  inputform({
    super.key,required this.formname , required this.lable ,required this.controller,required this.validate,required this.errormas
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formname,style: TextStyle(fontSize: 16,color: Colors.white),),
            ],
          ),
        ),
        SizedBox(height: 8,),
        SizedBox(
          width: MediaQuery.sizeOf(context).width-50,
          height: 80,
          child: TextField(
            controller: controller,
            style: TextStyle(color: Colors.white,fontSize: 16),
            obscureText: true,
            decoration: InputDecoration(filled: true,fillColor: Color.fromARGB(255, 23, 23, 23) ,border: OutlineInputBorder(),labelText: lable,labelStyle: TextStyle(fontSize: 16),
            errorText: validate ? errormas : null,
            ),
          ),
        ),
      ],
    );
  }
}


