import 'package:calculator/Button.dart';
import 'package:calculator/result.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(
    MaterialApp(
      home: Calculator(),
    ),
  );
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = '';
  String output = '';
  double outputSize = 30;
  bool hide = false;
  bool out = false;
  void cal(String pressed) {
    if (pressed == 'AC') {
      input = input + pressed;
      input = '';
      output = '';
      out = false;
    } else if (pressed == '<') {
      if (input != '') {
        input = input.substring(0, input.length - 1);
      }
    } else if (pressed == '=') {
      if (input != '') {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        output = expression.evaluate(EvaluationType.REAL, cm).toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hide = true;
        outputSize = 38;
        out = true;
      }
    } else {
      input = input + pressed;
      if (out) {
        if (pressed == '%' ||
            pressed == '*' ||
            pressed == '/' ||
            pressed == '-' ||
            pressed == '+') {
          hide = false;
          outputSize = 30;
          out = false;
        } else {
          input = '';
          input += pressed;
          out = false;
        }
      }
      hide = false;
      outputSize = 30;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double mm;
    double a = 0.03;
    if (MediaQuery.of(context).size.height.toDouble() <= 690 ||
        MediaQuery.of(context).size.width.toDouble() <= 340) {
      a = 0.002;
    }
    mm = MediaQuery.of(context).size.width.toDouble() * 0.05;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * a,
          ),
          Result(input, output, outputSize, hide),
          Container(
            padding: EdgeInsets.all(mm),
            alignment: Alignment.center,
            width: double.infinity,
            margin: EdgeInsets.all(mm),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  )
                ]),
            child: Column(
              children: [
                Row(
                  children: [
                    Button(
                      a: 'AC',
                      x: () => cal('AC'),
                    ),
                    Spacer(),
                    Button(a: '<-', x: () => cal('<')),
                    Spacer(),
                    Button(a: '%', x: () => cal('%')),
                    Spacer(),
                    Button(a: '/', x: () => cal('/'))
                  ],
                ),
                Container(
                  height: mm * 1.7,
                ),
                Row(
                  children: [
                    Button(a: '7', x: () => cal('7')),
                    Spacer(),
                    Button(a: '8', x: () => cal('8')),
                    Spacer(),
                    Button(a: '9', x: () => cal('9')),
                    Spacer(),
                    Button(a: 'X', x: () => cal('*'))
                  ],
                ),
                Container(
                  height: mm,
                ),
                Row(
                  children: [
                    Button(a: '4', x: () => cal('4')),
                    Spacer(),
                    Button(a: '5', x: () => cal('5')),
                    Spacer(),
                    Button(a: '6', x: () => cal('6')),
                    Spacer(),
                    Button(a: '-', x: () => cal('-'))
                  ],
                ),
                Container(
                  height: mm,
                ),
                Row(
                  children: [
                    Button(a: '1', x: () => cal('1')),
                    Spacer(),
                    Button(a: '2', x: () => cal('2')),
                    Spacer(),
                    Button(a: '3', x: () => cal('3')),
                    Spacer(),
                    Button(a: '+', x: () => cal('+'))
                  ],
                ),
                Container(
                  height: mm,
                ),
                Row(
                  children: [
                    Button(a: '0', b: 0.4, x: () => cal('0')),
                    Spacer(),
                    Button(a: '.', x: () => cal('.')),
                    Spacer(),
                    Button(a: '=', x: () => cal('=')),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
