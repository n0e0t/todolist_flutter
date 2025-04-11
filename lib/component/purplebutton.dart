import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/fade_to_page.dart';

class purplebutton extends StatelessWidget {
  final String lable;
  final dynamic link;
  final bool fill;

  const purplebutton({
    super.key, required this.lable , required this.link , required this.fill
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 48,
      child: ElevatedButton(
        onPressed: (){
          fadeToPage(context, link,200);
        },
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color:const Color.fromRGBO(136, 117, 255,1)
          ),
          backgroundColor: fill? Color.fromRGBO(136, 117, 255,1):Colors.black,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          )
        ), 
        child: 
            Text(lable,style: TextStyle(color: Colors.white,fontSize: 16),),
          
        ),
    );
  }
}
