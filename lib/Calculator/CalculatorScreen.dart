import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(
    home: CalculatorScreen(),
  ));
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String expression = "";
  bool shouldResetOutput = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        expression = "";
        output = "0";
        shouldResetOutput = false;
      } else if (buttonText == "=") {
        try {
          String modifiedExpression = expression
              .replaceAll('×', '*')
              .replaceAll('÷', '/')
              .replaceAll('√', 'sqrt')
              .replaceAll('^', '**');

          if (modifiedExpression
              .contains(RegExp(r'(sin|cos|tan|log|ln|sqrt)\('))) {
            modifiedExpression = handleScientificFunctions(modifiedExpression);
          }

          final parsedExpression = Expression.parse(modifiedExpression);
          final evaluator = const ExpressionEvaluator();
          final result = evaluator.eval(parsedExpression, {});
          output = result.toString();
          expression = output;
        } catch (e) {
          output = "Error";
        }
        shouldResetOutput = true;
      } else {
        if (shouldResetOutput) {
          expression = buttonText;
          shouldResetOutput = false;
        } else {
          expression += buttonText;
        }
        output = expression;
      }
    });
  }

  String handleScientificFunctions(String expr) {
    expr = expr.replaceAllMapped(RegExp(r'sqrt\(([^)]+)\)'), (match) {
      double value = double.parse(match.group(1)!);
      return math.sqrt(value).toString();
    });

    expr = expr.replaceAllMapped(RegExp(r'sin\(([^)]+)\)'), (match) {
      double value = double.parse(match.group(1)!);
      return math.sin(value * (math.pi / 180)).toStringAsPrecision(10);
    });

    expr = expr.replaceAllMapped(RegExp(r'cos\(([^)]+)\)'), (match) {
      double value = double.parse(match.group(1)!);
      return math.cos(value * (math.pi / 180)).toStringAsPrecision(10);
    });

    expr = expr.replaceAllMapped(RegExp(r'tan\(([^)]+)\)'), (match) {
      double value = double.parse(match.group(1)!);
      return math.tan(value * (math.pi / 180)).toStringAsPrecision(10);
    });

    expr = expr.replaceAllMapped(RegExp(r'log\(([^)]+)\)'), (match) {
      double value = double.parse(match.group(1)!);
      return (math.log(value) / math.log(10)).toStringAsPrecision(10);
    });

    expr = expr.replaceAllMapped(RegExp(r'ln\(([^)]+)\)'), (match) {
      double value = double.parse(match.group(1)!);
      return math.log(value).toStringAsPrecision(10);
    });

    return expr;
  }

  Widget buildButton(String buttonText,
      {Color color = Colors.white70, Function? onPressed}) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else {
            buttonPressed(buttonText);
          }
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(15.0),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Scientific Calculator",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 20,
            ),
            child: Text(
              output,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                fontSize: 36.0,
              ),
            ),
          ),
          const Expanded(child: Divider()),
          Column(children: [
            Row(children: <Widget>[
              buildButton("sin(", color: Colors.tealAccent),
              buildButton("cos(", color: Colors.tealAccent),
              buildButton("tan(", color: Colors.tealAccent),
              buildButton("(", color: Colors.tealAccent),
              buildButton(")", color: Colors.tealAccent),
            ]),
            Row(children: <Widget>[
              buildButton("log(", color: Colors.tealAccent),
              buildButton("ln(", color: Colors.tealAccent),
              buildButton("^", color: Colors.tealAccent),
              buildButton("√(", color: Colors.tealAccent),
              buildButton("÷", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("×", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("-", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("+", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("."),
              buildButton("0"),
              buildButton("CLEAR", color: Colors.orange),
              buildButton("=", color: Colors.orange),
            ]),
            Row(children: <Widget>[
              buildButton("Unit Conversion", color: Colors.purpleAccent,
                  onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UnitConversionScreen()),
                );
              }),
            ])
          ]),
        ],
      ),
    );
  }
}

class UnitConversionScreen extends StatefulWidget {
  @override
  _UnitConversionScreenState createState() => _UnitConversionScreenState();
}

class _UnitConversionScreenState extends State<UnitConversionScreen> {
  String input = "";
  String output = "";
  String selectedConversion = "m to km";

  final List<String> conversionOptions = [
    "m to km",
    "km to m",
    "m to miles",
    "miles to m",
    "kg to lbs",
    "lbs to kg",
    "C to F",
    "F to C",
    "L to gallons",
    "gallons to L",
  ];

  void convert() {
    double inputValue = double.tryParse(input) ?? 0;
    double outputValue;

    switch (selectedConversion) {
      case "m to km":
        outputValue = inputValue / 1000;
        break;
      case "km to m":
        outputValue = inputValue * 1000;
        break;
      case "m to miles":
        outputValue = inputValue / 1609.34;
        break;
      case "miles to m":
        outputValue = inputValue * 1609.34;
        break;
      case "kg to lbs":
        outputValue = inputValue * 2.20462;
        break;
      case "lbs to kg":
        outputValue = inputValue / 2.20462;
        break;
      case "C to F":
        outputValue = (inputValue * 9 / 5) + 32;
        break;
      case "F to C":
        outputValue = (inputValue - 32) * 5 / 9;
        break;
      case "L to gallons":
        outputValue = inputValue / 3.78541;
        break;
      case "gallons to L":
        outputValue = inputValue * 3.78541;
        break;
      default:
        outputValue = inputValue;
    }

    setState(() {
      output = outputValue.toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText, {Color color = Colors.white70}) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            if (buttonText == "CLEAR") {
              input = "";
              output = "";
            } else {
              input = input + buttonText;
            }
          });
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(15.0),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Unit Conversion",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(
              vertical: 50,
              horizontal: 20,
            ),
            child: Text(
              input,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                fontSize: 36.0,
              ),
            ),
          ),
          const Expanded(child: Divider()),
          Column(children: [
            Row(children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
            ]),
            Row(children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
            ]),
            Row(children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
            ]),
            Row(children: <Widget>[
              buildButton("."),
              buildButton("0"),
              buildButton("CLEAR", color: Colors.redAccent),
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                DropdownButton<String>(
                  value: selectedConversion,
                  items: conversionOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedConversion = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: convert,
                        child: const Text("Convert"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  "Output: $output",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
