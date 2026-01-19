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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 4,
        ),
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String expression = "0";
  String result = "0";

  final List<List<String>> buttonRows = [
    ['AC', 'C', '/', '*'],
    ['7', '8', '9', '-'],
    ['4', '5', '6', '+'],
    ['1', '2', '3', '='],
    ['0', '.', '', ''], // 0 prend 2 colonnes
  ];

  // Définition des couleurs
  Color getButtonColor(String text) {
    if (['AC', 'C', '=', '+', '-', '*', '/'].contains(text)) {
      return Colors.yellow[700]!; // jaune pour opérateurs et AC/C
    }
    return Colors.grey[850]!; // chiffres
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Column(
        children: [
          // Expression
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: TextField(
              readOnly: true,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: expression,
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              controller: TextEditingController(text: expression),
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          // Result
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: TextField(
              readOnly: true,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                hintText: result,
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              controller: TextEditingController(text: result),
              style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          // Boutons
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttonRows.map((row) {
                return Expanded(
                  child: Row(
                    children: row.map((text) {
                      if (text.isEmpty) return const Spacer();

                      // Correction alignement dernière ligne : 0 prend 2 colonnes
                      double flex = text == '0' ? 2 : 1;

                      return Expanded(
                        flex: flex.toInt(),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(getButtonColor(text)),
                              foregroundColor: MaterialStateProperty.all(Colors.black),
                              elevation: MaterialStateProperty.all(6),
                              shadowColor: MaterialStateProperty.all(Colors.black54),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (states) => states.contains(MaterialState.pressed)
                                    ? Colors.yellow.withOpacity(0.5)
                                    : null,
                              ),
                            ),
                            onPressed: () {
                              debugPrint('Button pressed: $text');
                            },
                            child: Center(child: Text(text)),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}