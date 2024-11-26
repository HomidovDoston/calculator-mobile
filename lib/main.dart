import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0";

  void onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        displayText = "0";
      } else if (value == "=") {
        // Here you can add logic to calculate the result
        // For simplicity, we'll just reset the display
        displayText = "0";
      } else {
        if (displayText == "0") {
          displayText = value;
        } else {
          displayText += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(16),
              child: Text(
                displayText,
                style: TextStyle(color: Colors.white, fontSize: 48),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: [
                  buildButtonRow(["7", "8", "9", "/"]),
                  buildButtonRow(["4", "5", "6", "x"]),
                  buildButtonRow(["1", "2", "3", "-"]),
                  buildButtonRow(["C", "0", "=", "+"]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return Expanded(
            child: ElevatedButton(
              onPressed: () => onButtonPressed(buttonText),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                textStyle: TextStyle(fontSize: 24),
              ),
              child: Text(buttonText),
            ),
          );
        }).toList(),
      ),
    );
  }
}
