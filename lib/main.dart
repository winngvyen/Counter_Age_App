import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => AgeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AgeCounter(),
    );
  }
}

class AgeProvider extends ChangeNotifier {
  int _age = 0;

  int get age => _age;

  void increaseAge() {
    _age++;
    notifyListeners();
  }

  void decreaseAge() {
    if (_age > 0) {
      _age--;
      notifyListeners();
    }
  }
}

class AgeCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int age = context.watch<AgeProvider>().age;

    Color backgroundColor;
    String message;

    if (age <= 12) {
      backgroundColor = Colors.lightBlue;
      message = "You're a child!";
    } else if (age <= 19) {
      backgroundColor = Colors.lightGreen;
      message = "Teenager time!";
    } else if (age <= 30) {
      backgroundColor = Colors.yellow;
      message = "You're a young adult!";
    } else if (age <= 50) {
      backgroundColor = Colors.orange;
      message = "You're an adult now!";
    } else {
      backgroundColor = Colors.grey;
      message = "Golden years!";
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text("Age Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "I am $age years old",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.read<AgeProvider>().increaseAge(),
              child: Text("Increase Age"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.read<AgeProvider>().decreaseAge(),
              child: Text("Reduce Age"),
            ),
          ],
        ),
      ),
    );
  }
}
