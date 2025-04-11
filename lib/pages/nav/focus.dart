import 'dart:async';
import 'package:flutter/material.dart';

class Focusscreen extends StatefulWidget {
  const Focusscreen({super.key});

  @override
  State<Focusscreen> createState() => _FocusscreenState();
}

class _FocusscreenState extends State<Focusscreen> {
  static const int maxSeconds = 60 * 60; // 60 minutes
  int seconds = 0;
  Timer? _timer;
  bool _isRunning = false;

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds < maxSeconds) {
          seconds++;
        } else {
          _stopTimer();
          _isRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String get formattedTime {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  double get progress {
    return seconds / maxSeconds;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Container()),
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 210,
                  height: 210,
                  child: CircularProgressIndicator(
                    value: progress,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(136, 117, 255,1),),
                    backgroundColor: Color.fromARGB(255, 54, 54, 54),
                    strokeWidth: 12,
                  ),
                ),
                Text(
                  formattedTime,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25,),
            Text('While your focus mode is on, all of your',style: TextStyle(color: Colors.white),),
            Text('notification will be off',style: TextStyle(color: Colors.white),),
            SizedBox(height: 20,),
            SizedBox(
              width: 177,
              height: 48,
              child: ElevatedButton(
                onPressed: _toggleTimer,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  backgroundColor: Color.fromRGBO(136, 117, 255,1),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(_isRunning ? 'Stop Focusing' : 'Start Focusing',style: TextStyle(color: Colors.white),),
              ),
            ),
            Expanded(flex: 5, child: Container())
          ],
        ),
      ),
    );
  }
}
