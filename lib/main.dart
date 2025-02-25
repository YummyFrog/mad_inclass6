import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeProvider(),
      child: const MyApp(),
    ),
  );
}

class AgeProvider extends ChangeNotifier {
  int _age = 0;

  int get age => _age;

  void setAge(int newAge) {
    _age = newAge;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AgeCounterScreen(),
    );
  }
}

class AgeCounterScreen extends StatelessWidget {
  const AgeCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AgeProvider>(
        builder: (context, ageProvider, child) {
          int age = ageProvider.age;
          String message;
          Color backgroundColor;

          if (age <= 12) {
            message = "You're a child!";
            backgroundColor = Colors.lightBlue.shade100;
          } else if (age <= 19) {
            message = "Teenager time!";
            backgroundColor = Colors.lightGreen.shade100;
          } else if (age <= 30) {
            message = "You're a young adult!";
            backgroundColor = Colors.yellow.shade100;
          } else if (age <= 50) {
            message = "You're an adult now!";
            backgroundColor = Colors.orange.shade100;
          } else {
            message = "Golden years!";
            backgroundColor = Colors.grey.shade300;
          }

          Color progressBarColor;
          if (age <= 33) {
            progressBarColor = Colors.green;
          } else if (age <= 67) {
            progressBarColor = Colors.yellow;
          } else {
            progressBarColor = Colors.red;
          }

          return Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Age Counter",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "I am ${age} years old",
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  
                  Slider(
                    value: age.toDouble(),
                    min: 0,
                    max: 99,
                    divisions: 99,
                    label: "$age",
                    onChanged: (double newValue) {
                      ageProvider.setAge(newValue.toInt());
                    },
                  ),

                  const SizedBox(height: 20),
                  
                  Container(
                    width: 300,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: age / 99,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: progressBarColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

