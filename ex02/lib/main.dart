import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

/* State class that holds the calculator data and builds the user interface */
class _CalculatorPageState extends State<CalculatorPage> {
  String expression = "0";
  String result = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Turbo Mega Calculator 3000',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          buildDisplay(expression, fontSize: 30),
          buildDisplay(result, fontSize: 40),
          Expanded(
            child: Column(
              children: [
                buildButtonRow(['AC', 'C', '%', '/']),
                buildButtonRow(['7', '8', '9', '*']),
                buildButtonRow(['4', '5', '6', '-']),
                buildButtonRow(['1', '2', '3', '+']),
                buildButtonRow(['0', '.', '='], isLastRow: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDisplay(String text, {required double fontSize}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons, {bool isLastRow = false}) {
    return Expanded(
      child: Row(
        children: buttons.map((text) {
          if (isLastRow && text == '0') {
            return Expanded(
              flex: 2,
              child: calculatorButton(text),
            );
          }
          return Expanded(
            child: calculatorButton(text),
          );
        }).toList(),
      ),
    );
  }

  Widget calculatorButton(String text) {
    return Padding(
      padding: EdgeInsets.all(6),
      child: ElevatedButton(
        onPressed: () {
          debugPrint('Button pressed: $text');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: getButtonColor(text),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: const TextStyle(
            fontSize: 22,
          ),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }

  Color getButtonColor(String text) {
    if (['/', '*', '-', '+', '='].contains(text)) {
      return const Color(0xFFF29A02);
    }
    if (['C', 'AC', '%'].contains(text)) {
      return const Color(0xFF808080);
    }
    return const Color(0xFF3B3A3A);
  }
}