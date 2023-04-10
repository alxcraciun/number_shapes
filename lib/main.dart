import 'package:flutter/material.dart';
import 'dart:math' show pow;

void main() {
  runApp(const NumberShapesApp());
}

class NumberShapesApp extends StatelessWidget {
  const NumberShapesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(title: 'Number Shapes'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
            child: Text(
                "Please input a number to see if it is square or triangular.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                controller: _textController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something!';
                  } else {
                    try {
                      int.parse(value);
                    } catch (e) {
                      return 'Please enter a natural number!';
                    }
                    return null;
                  }
                },
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final value = int.parse(_textController.text);
            final squareRoot = pow(value, 1/2).toInt();
            final cubeRoot = pow(value, 1/3).toInt();

            print(value);
            print(pow(value, 1/2));
            print(pow(value, 1/3));

            if (squareRoot * squareRoot == value) {
              if (cubeRoot * cubeRoot * cubeRoot == value) {
                // it's both
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(_textController.text),
                        content: SingleChildScrollView(
                          child: Text('Number ${_textController.text} is both triangular and square'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                );
              }
              else {
                // it's square
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(_textController.text),
                        content: SingleChildScrollView(
                          child: Text('Number ${_textController.text} is SQUARE.'),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                );
              }
            }
            else if (cubeRoot * cubeRoot * cubeRoot == value) {
              // it's cube
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(_textController.text),
                      content: SingleChildScrollView(
                        child: Text('Number ${_textController.text} is CUBE.'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
              );

            } else {
              // it's neither
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(_textController.text),
                      content: SingleChildScrollView(
                        child: Text('Number ${_textController.text} is NEITHER triangular, nor square')
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  }
              );
            }
          }
        },
        tooltip: 'Check number',
        child: const Icon(Icons.check),
      ),
    );
  }
}
