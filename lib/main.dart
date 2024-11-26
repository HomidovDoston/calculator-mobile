import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayInput = "40×30×2"; // Example input
  String displayResult = "   2,400"; // Example result

  void onButtonPressed(String value) {
    // Handle button logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display Section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      displayInput,
                      style: TextStyle(fontSize: 28, color: Colors.grey[400]),
                    ),
                    Text(
                      displayResult,
                      style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            // Buttons Section
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  buildButtonRow(["C", "⌫", "(", ")", "÷"], Colors.tealAccent),
                  buildButtonRow(["7", "8", "9", "×"], Colors.tealAccent),
                  buildButtonRow(["4", "5", "6", "+"], Colors.tealAccent),
                  buildButtonRow(["1", "2", "3", "-"], Colors.tealAccent),
                  buildButtonRow(["0", ".", "EE", "="], Colors.tealAccent),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons, Color color) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          final isBracket = buttonText == "(" || buttonText == ")"; // Shart
          final isOperator = ["+", "-", "×", "÷", "="].contains(buttonText); // Amallarni aniqlash
          final isNumber = int.tryParse(buttonText) != null || buttonText == "0"; // Raqamlarni aniqlash

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isBracket ? 4.0 : 8.0, // "(" va ")" uchun kichik padding
                vertical: 8.0,
              ),
              child: ElevatedButton(
                onPressed: () => onButtonPressed(buttonText),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: TextStyle(fontSize: 24),
                  foregroundColor: isNumber
                      ? Colors.pink // Raqamlar
                      : isOperator
                          ? Colors.tealAccent // Amallar
                          : color, // Boshqalar
                          
                ),
                child: Text(buttonText),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}




// Ko'rinish yakunlandi ...
