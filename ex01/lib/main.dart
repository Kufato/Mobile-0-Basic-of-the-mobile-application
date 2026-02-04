import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isHelloWorld = false;

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isHelloWorld ? 'Hello World!' : 'Hello Everybody',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white
                ),
                onPressed: () {
                  setState(() {
                    _isHelloWorld = !_isHelloWorld;
                  });
                },
                child: Text(
                  'Press me',
                  style: TextStyle(color: Colors.black)
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}