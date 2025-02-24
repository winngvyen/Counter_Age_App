import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  runApp(AgeCounterApp());
}

class AgeCounterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AgeCounterScreen(),
    );
  }
}

class AgeCounterScreen extends StatefulWidget {
  @override
  _AgeCounterScreenState createState() => _AgeCounterScreenState();
}

class _AgeCounterScreenState extends State<AgeCounterScreen> {
  int _age = 0;

  String get ageMessage {
    if (_age <= 12) return "You're a child!";
    if (_age <= 19) return "Teenager time!";
    if (_age <= 30) return "You're a young adult!";
    if (_age <= 50) return "You're an adult now!";
    return "Golden years!";
  }

  Color get backgroundColor {
    if (_age <= 12) return Colors.lightBlue;
    if (_age <= 19) return Colors.lightGreen;
    if (_age <= 30) return Colors.yellow;
    if (_age <= 50) return Colors.orange;
    return Colors.grey;
  }

  Color get progressColor {
    if (_age <= 33) return Colors.green;
    if (_age <= 67) return Colors.yellow;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text("Age Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "I am $_age years old",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              ageMessage,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _age / 99,
              backgroundColor: Colors.white,
              color: progressColor,
              minHeight: 10,
            ),
            SizedBox(height: 20),
            Slider(
              value: _age.toDouble(),
              min: 0,
              max: 99,
              divisions: 99,
              label: _age.toString(),
              onChanged: (double value) {
                setState(() {
                  _age = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_age > 0) _age--;
                    });
                  },
                  child: Text("Reduce Age"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_age < 99) _age++;
                    });
                  },
                  child: Text("Increase Age"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
