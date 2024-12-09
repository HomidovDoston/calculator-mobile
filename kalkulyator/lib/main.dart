import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

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
  String displayInput = "";
  String displayResult = "0";

void onButtonPressed(String value) {
  setState(() {
    if (value == "C") {
      // Hammasini tozalash
      displayInput = "";
      displayResult = "";
    } else if (value == "⌫") {
      // Oxirgi belgini o'chirish
      if (displayInput.isNotEmpty) {
        displayInput = displayInput.substring(0, displayInput.length - 1);
      }
    } else if (value == "=") {
      // Natijani hisoblash
      try {
        String sanitizedInput = displayInput.replaceAll("×", "*").replaceAll("÷", "/");
        final result = _evaluateExpression(sanitizedInput);
        displayResult = result.toString();
        // ".0" bilan tugaydigan natijalarni qisqartirish
        if (displayResult.endsWith(".0")) {
          displayResult = displayResult.substring(0, displayResult.length - 2);
        }
      } catch (e) {
        displayResult = "Error";
      }
    } else if (value == ".") {
      // Nuqta kiritish uchun tekshiruv
      if (displayInput.isEmpty || 
          displayInput.endsWith("+") || 
          displayInput.endsWith("-") || 
          displayInput.endsWith("×") || 
          displayInput.endsWith("÷")) {
        displayInput += "0.";
      } else if (!displayInput.endsWith(".") && !RegExp(r'\d+\.\d*$').hasMatch(displayInput)) {
        displayInput += value;
      }
    } else if (value == "0") {
      // Nol kiritish qoidalari
      if (displayInput.isEmpty || 
          displayInput == "0" || 
          displayInput.endsWith(".") || 
          displayInput.endsWith("+") || 
          displayInput.endsWith("-") || 
          displayInput.endsWith("×") || 
          displayInput.endsWith("÷")) {
        displayInput += value;
      } else if (!displayInput.startsWith("0") || displayInput.contains(".")) {
        // Nolni kiritishga ruxsat berish
        displayInput += value;
      }
    } else {
      // Boshqa barcha belgilarni kiritish
      displayInput += value;
    }
  });
}





  double _evaluateExpression(String input) {
    Parser parser = Parser();
    Expression exp = parser.parse(input);
    ContextModel contextModel = ContextModel();
    return exp.evaluate(EvaluationType.REAL, contextModel);
  }

  String _formatResult(double result) {
    if (result == result.toInt()) {
      return result.toInt().toString(); // Agar natija butun bo'lsa
    }
    return result.toString(); // Agar natija kasrli bo'lsa
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
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      displayInput,
                      style: TextStyle(fontSize: 28, color: Colors.white70),
                    ),
                    Text(
                      displayResult,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.tealAccent,
                      ),
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
                  buildButtonRow(["7", "8", "9", "×"], Colors.pink),
                  buildButtonRow(["4", "5", "6", "-"], Colors.pink),
                  buildButtonRow(["1", "2", "3", "+"], Colors.pink),
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
          Color buttonColor;

          // Tugma turiga qarab rangni ajratish
          if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷" || buttonText == "C" || buttonText == "⌫" || buttonText == "(" || buttonText == ")"  || buttonText == "EE"){
            buttonColor = Colors.tealAccent; // Amallar ranglari
          } else {
            buttonColor = Colors.pink; // Raqamlar ranglari
          }
          

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: buttonText.isNotEmpty
                    ? () => onButtonPressed(buttonText)
                    : null, // Bo‘sh tugma ishlamasligi kerak
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[850],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 20,
                    color: buttonColor,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}





// Calculator yakunlandi .