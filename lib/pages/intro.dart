import 'package:flutter/material.dart';
import 'package:flutter_application_1/function/fade_to_page.dart';
import 'package:flutter_application_1/pages/welcome.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IntroductionScreen(
          globalBackgroundColor: Colors.black,
          pages: [
            PageViewModel(
              title: "",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Pushes content to bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60,),
                  Image.asset('assets/intro/1.png', height: 250),
                  const SizedBox(height: 40),
                  const Text(
                    "Manage your tasks",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "You can easily manage all of your daily tasks in DoMe for free",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Pushes content to bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60,),
                  Image.asset('assets/intro/2.png', height: 250),
                  const SizedBox(height: 40),
                  const Text(
                    "Create daily routine",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "In Uptodo  you can create your personalized routine to stay productive",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "",
              bodyWidget: Column(
                mainAxisAlignment: MainAxisAlignment.end, // Pushes content to bottom
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60,),
                  Image.asset('assets/intro/2.png', height: 250),
                  const SizedBox(height: 40),
                  const Text(
                    "Orgonaize your tasks",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "You can organize your daily tasks by adding your tasks into separate categories",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            fadeToPage(context, Welcome(), 500);
            
          },
          onSkip: () {
           fadeToPage(context, Welcome(), 500);
          },
          showSkipButton: false, // We put skip manually
          showBackButton: true,
          back: const Text("BACK", style: TextStyle(fontWeight: FontWeight.w600,color: Color.fromARGB(120, 255, 255, 255))),
          next: const Text("NEXT", style: TextStyle(fontWeight: FontWeight.w600)),
          done: const Text("GET STARTED", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotDecoration(),
        ),
        // Top-left Skip button
        Positioned(
          top: 40,
          left: 16,
          child: TextButton(
            onPressed: () {
              fadeToPage(context, Welcome(), 500);
            },
            child: const Text("SKIP", style: TextStyle(fontSize: 16,color: Color.fromARGB(120, 255, 255, 255))),
          ),
        ),
      ],
    );
  }

  PageDecoration getPageDecoration() {
  return const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.black, 
  );
}


  DotsDecorator getDotDecoration() {
    return const DotsDecorator(
      color: Colors.grey,
      activeColor: Colors.white,
      size: Size(10, 10),
      activeSize: Size(22, 10),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );
  }
}