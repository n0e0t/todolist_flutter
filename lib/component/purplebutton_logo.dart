import 'package:flutter/material.dart';

class purplebutton_logo extends StatelessWidget {
  final dynamic lable;
  final dynamic link;
  final dynamic fill;
  final dynamic logo;

  const purplebutton_logo({
    super.key,required this.lable ,required this.link,required this.fill,required this.logo
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width-50,
      height: 48,
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => link)
            );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Image.asset(logo),
                ),
                Text(lable,style: TextStyle(color: Colors.white,fontSize: 16),),
              ],
            ),
        ),
    );
  }
}
