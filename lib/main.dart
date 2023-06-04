import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Calculator();
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userQuestion = '';
  var answer = '';
  var userAnswer = '';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    List<String> buttons = [
      'C',
      '/',
      'x',
      'D',
      '7',
      '8',
      '9',
      '-',
      '4',
      '5',
      '6',
      '+',
      '1',
      '2',
      '3',
      '=',
      '%',
      '0',
      '.',
      'Ans'
    ];
    bool isOperator(String x) {
      if (x == 'C' ||
          x == '/' ||
          x == 'x' ||
          x == 'D' ||
          x == '-' ||
          x == '+' ||
          x == '=' ||
          x == 'Ans') {
        return true;
      }
      return false;
    }

    void evaluateMath() {
      setState(() {
        var equation = userQuestion;
        equation = equation.replaceAll('x', '*');
        Parser p = Parser();
        Expression exp = p.parse(equation);
        double result = exp.evaluate(EvaluationType.REAL, ContextModel());
        userAnswer = result.toString();
        // answer = userAnswer;
        // userQuestion = '';
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(0, 16, 16, 16),
        body: SafeArea(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userQuestion,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Color(0xffd9d5d5),
                        ),
                        // textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        userAnswer,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Color.fromARGB(255, 206, 205, 205),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * 0.55,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(22, 22, 22, 1),
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: buttons.length,
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      // top: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ElevatedButton(
                        onPressed: () {
                          // print((isOperator(
                          //     userQuestion[(userQuestion.length) - 1])));
                          if ('D' == buttons[index]) {
                            if (userQuestion.isNotEmpty) {
                              setState(
                                () {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                },
                              );
                              evaluateMath();
                            }
                          } else if ('C' == buttons[index]) {
                            setState(() {
                              userQuestion = '';
                              userAnswer = '';
                            });
                          } else if ('=' == buttons[index]) {
                            setState(() {
                              evaluateMath();
                              answer = userAnswer;
                              userQuestion = userAnswer;
                              userAnswer = '';
                            });
                          } else if ('Ans' == buttons[index]) {
                            setState(() {
                              userQuestion += answer;
                            });
                            evaluateMath();
                          } else {
                            setState(() {
                              userQuestion += buttons[index];
                            });
                            evaluateMath();
                          }
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(22, 22, 22, 1),
                          ),
                          minimumSize: MaterialStatePropertyAll(
                            Size(40, 40),
                          ),
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.all(5),
                          ),
                          shape: MaterialStatePropertyAll(CircleBorder()),
                        ),
                        child: Text(
                          buttons[index],
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isOperator(buttons[index])
                                ? const Color(0xff2a952a)
                                : const Color(0xffd9d5d5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
