import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/fade_to_page.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/pages/intro.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState(){
    super.initState();
    intialization();
  }

  void intialization() async{
    await Future.delayed(const Duration(seconds: 1));
    FlutterNativeSplash.remove();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      fadeToPage(context, Intro(),800);
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(seconds: 2),
        builder: (context, value, child) => Opacity(
          opacity: value,
          child: child,
        ),
        child: Image.asset('assets/icons/start.png'),
      ),
    ),
  );
}

}


ValueNotifier<List<User>> userList = ValueNotifier<List<User>>([]);
ValueNotifier<User?> currentUser = ValueNotifier(null);


// ignore: constant_identifier_names
const catagory_list = [
  {
    "name":"Grocery",
    "color": Color.fromARGB(255, 204, 255, 128)
  },
  {
    "name":"Work",
    "color": Color.fromARGB(255, 255,150,128)
  },
  {
    "name":"Sport",
    "color": Color.fromARGB(255, 128,255,255)
  },
  {
    "name":"Design",
    "color": Color.fromARGB(255, 128,255,217)
  },
  {
    "name":"University",
    "color": Color.fromARGB(255, 128,156,255)
  },
  {
    "name":"Social",
    "color": Color.fromARGB(255, 255,128,235)
  },
  {
    "name":"Music",
    "color": Color.fromARGB(255, 252,128,255)
  },
  {
    "name":"Health",
    "color": Color.fromARGB(255,128,255,163)
  },
  {
    "name":"Movie",
    "color": Color.fromARGB(255,128,209,255)
  },
  {
    "name":"Home",
    "color": Color.fromARGB(255,255,204,128)
  },
  {
    "name":"None",
    "color": Color.fromRGBO(136, 117, 255,1)
  }
];

