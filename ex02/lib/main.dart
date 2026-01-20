import 'package:flutter/material.dart';

/// Entry point of the application.
/// Launches the root widget.
void main() {
  runApp(const MyApp());
}

/// Root widget of the application.
/// Sets up the MaterialApp and defines the home screen.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

/// Main calculator screen.
/// Uses a StatefulWidget because the buttons change state when clicked.
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

/// State class that holds the calculator data
/// and builds the user interface.
class _CalculatorPageState extends State<CalculatorPage> {
  /// Current expression displayed on screen
  String expression = "0";

  /// Current result displayed on screen
  String result = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      /// Top application bar with a simple title
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Turbo Mega Calculator 3000',
          style: TextStyle(color: Colors.white),
        ),
      ),

      /// Main layout divided vertically between
      /// display area and buttons area
      body: Column(
        children: [
          /// Expression display
          buildDisplay(expression, fontSize: 32),

          /// Result display
          buildDisplay(result, fontSize: 40),

          /// Buttons area taking all remaining space
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

  /// Builds a text display used for expression and result.
  /// Text is right-aligned to mimic a real calculator screen.
  Widget buildDisplay(String text, {required double fontSize}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerRight,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Builds a single row of calculator buttons.
  /// The last row is handled differently to make the "0" button wider.
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

  /// Builds a calculator button with a flat, rounded design.
  /// Each button prints its label to the debug console when pressed.
  Widget calculatorButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(6),
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
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Center(child: Text(text)),
      ),
    );
  }

  /// Returns the appropriate color depending on the button type:
  /// operators, function buttons, or number buttons.
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