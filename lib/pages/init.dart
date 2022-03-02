import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 30.0;
  double resultFontSize = 30.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
        equationFontSize = 30.0;
        resultFontSize = 30.0;
      } else if (buttonText == "DEL") {
        equationFontSize = 30.0;
        resultFontSize = 30.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 30.0;
        resultFontSize = 30.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 30.0;
        resultFontSize = 30.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    }
    );
  }

  Widget buildButtonBase(String buttonText, double buttonHeight, Color buttonColor) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((MediaQuery.of(context).size.height * 0.2 * buttonHeight)/2)),
        color: buttonColor,
        height: MediaQuery.of(context).size.height * 0.2 * buttonHeight,
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText,style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.black),)
    );
  }
  Widget buildButtonTopText(String buttonText, double buttonHeight, Color buttonColor) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((MediaQuery.of(context).size.height * 0.125 * buttonHeight)/2)),
        color: buttonColor,
        height: MediaQuery.of(context).size.height * 0.125 * buttonHeight,
        padding: EdgeInsets.all(0.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white),)
    );
  }
  Widget buildButtonTopIcon(IconData buttonText, double buttonHeight, Color buttonColor) {
    return MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular((MediaQuery.of(context).size.height * 0.125 * buttonHeight)/2)),
        color: buttonColor,
        height: MediaQuery.of(context).size.height * 0.125 * buttonHeight,
        padding: EdgeInsets.all(0.0),
        onPressed: () => buttonPressed("NA"),
        child: Text("NA",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white),)
    );
  }
  Widget shiftAlphaText(String text1, String text2) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: text1,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
          TextSpan(text: text2,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ],
      ),
    );
  }
  Widget shiftText(String text) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: text,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
        ],
      ),
    );
  }
  Widget alphaText(String text) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(text: text,style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('FX 991es plus'))),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            color: Colors.deepPurple[200],
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(equation,style: TextStyle(fontSize: equationFontSize,color: Colors.deepPurple,),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.deepPurple[200],
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(result,style: TextStyle(fontSize: resultFontSize,color: Colors.deepPurple,),
              ),
            ),
          ),

          //below 3 line pushes the buttons to the bottom of the screen
          // Expanded(
          //   child: Divider(),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                      Center(child: shiftText("SHIFT")),
                      Center(child: alphaText("ALPHA")),
                      Center(child: shiftAlphaText("MODE    ", "SETUP")),
                      Center(child: shiftText("NA")),
                    ]),
                    TableRow(children: [
                      buildButtonTopText(" ", 0.35, Colors.grey),
                      buildButtonTopText(" ", 0.35, Colors.grey),
                      buildButtonTopText(" ", 0.35, Colors.grey),
                      buildButtonTopText(" ", 0.35, Colors.grey),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          //row of upper buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(children: [
                      Center(child: shiftAlphaText("SOLVE   ", "=")),
                      Center(child: shiftAlphaText("NA     ", ":")),
                      Center(child: shiftAlphaText(" ", " ")),
                      Center(child: shiftAlphaText(" ", " ")),
                      Center(child: shiftText("x!")),
                      Center(child: shiftText("NA")),
                    ]),
                    TableRow(children: [
                      buildButtonTopText("CALC", 0.35, Colors.black),
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                      buildButtonTopText(" ", 0.35, Colors.transparent),
                      buildButtonTopText(" ", 0.35, Colors.transparent),
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                    ]),
                    TableRow(children: [
                      Center(child: shiftText("NA")),
                      Center(child: shiftText("NA")),
                      Center(child: shiftAlphaText("NA   ", "DEC")),
                      Center(child: shiftAlphaText("NA   ", "HEX")),
                      Center(child: shiftAlphaText("NA   ", "BIN")),
                      Center(child: shiftAlphaText("NA   ", "OCT")),
                    ]),
                    TableRow(children: [
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                      buildButtonTopIcon(Icons.ac_unit, 0.35, Colors.black),
                      buildButtonTopText("log", 0.35, Colors.black),
                      buildButtonTopText("ln", 0.35, Colors.black),
                    ]),
                    TableRow(children: [
                      Center(child: shiftAlphaText("NA    ", "A")),
                      Center(child: shiftAlphaText("←    ", "B")),
                      Center(child: shiftAlphaText("Abs    ", "C")),
                      Center(child: shiftAlphaText("NA     ", "D")),
                      Center(child: shiftAlphaText("NA     ", "E")),
                      Center(child: shiftAlphaText("NA     ", "F")),
                    ]),
                    TableRow(children: [
                      buildButtonTopText("(-)", 0.35, Colors.black),
                      buildButtonTopText("° ' \"", 0.35, Colors.black),
                      buildButtonTopText("hyp", 0.35, Colors.black),
                      buildButtonTopText("sin", 0.35, Colors.black),
                      buildButtonTopText("cos", 0.35, Colors.black),
                      buildButtonTopText("tan", 0.35, Colors.black),
                    ]),
                    TableRow(children: [
                      Center(child: shiftText("STO")),
                      Center(child: shiftAlphaText("←     ", "i")),
                      Center(child: shiftText("%")),
                      Center(child: shiftAlphaText(",       ", "X")),
                      Center(child: shiftAlphaText("NA     ", "Y")),
                      Center(child: shiftAlphaText("M-     ", "M")),
                    ]),
                    TableRow(children: [
                      buildButtonTopText("RCL", 0.35, Colors.black),
                      buildButtonTopText("ENG", 0.35, Colors.black),
                      buildButtonTopText("(", 0.35, Colors.black),
                      buildButtonTopText(")", 0.35, Colors.black),
                      buildButtonTopText("S=D", 0.35, Colors.black),
                      buildButtonTopText("M+", 0.35, Colors.black),
                    ]),
                  ],
                ),
              ),
            ],
          ),

          //row of bottom buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(children: [
                      Center(child: shiftText("CONST")),
                      Center(child: shiftText("CONV")),
                      Center(child: shiftText("CLR")),
                      Center(child: shiftText("INS")),
                      Center(child: shiftText("OFF")),
                    ]),
                    TableRow(children: [
                      buildButtonBase("7", 0.35, Colors.black26),
                      buildButtonBase("8", 0.35, Colors.black26),
                      buildButtonBase("9", 0.35, Colors.black26),
                      buildButtonBase("DEL", 0.35, Colors.redAccent),
                      buildButtonBase("AC", 0.35, Colors.redAccent),
                    ]),
                    TableRow(children: [
                      Center(child: shiftText("MATRIX")),
                      Center(child: shiftText("VECTOR")),
                      Center(child: shiftText(" ")),
                      Center(child: shiftText("nPr")),
                      Center(child: shiftText("nCr")),
                    ]),
                    TableRow(children: [
                      buildButtonBase("4", 0.35, Colors.black26),
                      buildButtonBase("5", 0.35, Colors.black26),
                      buildButtonBase("6", 0.35, Colors.black26),
                      buildButtonBase("*", 0.35, Colors.black26),
                      buildButtonBase("/", 0.35, Colors.black26),
                    ]),
                    TableRow(children: [
                      Center(child: shiftText("STAT")),
                      Center(child: shiftText("CMPLX")),
                      Center(child: shiftText("BASE")),
                      Center(child: shiftText("Pol")),
                      Center(child: shiftText("Rec")),
                    ]),
                    TableRow(children: [
                      buildButtonBase("1", 0.35, Colors.black26),
                      buildButtonBase("2", 0.35, Colors.black26),
                      buildButtonBase("3", 0.35, Colors.black26),
                      buildButtonBase("+", 0.35, Colors.black26),
                      buildButtonBase("-", 0.35, Colors.black26),
                    ]),
                    TableRow(children: [
                      Center(child: shiftText("Rnd")),
                      Center(child: shiftAlphaText("Ran#", "RanInt")),
                      Center(child: shiftAlphaText("π       ", "e")),
                      Center(child: shiftText("  DRG►")),
                      Center(child: shiftText(" ")),
                    ]),
                    TableRow(children: [
                      buildButtonBase("0", 0.35, Colors.black26),
                      buildButtonBase(".", 0.35, Colors.black26),
                      buildButtonBase("x10ˣ", 0.35, Colors.black26),
                      buildButtonBase("Ans", 0.35, Colors.black26),
                      buildButtonBase("=", 0.35, Colors.black26),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
