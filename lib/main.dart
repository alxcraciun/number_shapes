import 'dart:math' show pow;
import 'package:flutter/material.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

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
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
            child: Text('Please input a number to see if it is square or cube.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _textController,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter something!';
                  } else if (RegExp(r'^\d+$').hasMatch(value)) {
                    return 'The number provided is too big';
                  } else {
                    try {
                      int.parse(value);
                    } catch (e) {
                      return 'Please enter a natural number!';
                    }
                    if (int.parse(value) < 0) {
                      return 'Please enter a positive number!';
                    }
                  }
                  return null;
                },
              ),
            ),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final int value = int.parse(_textController.text);
            final int squareRoot = pow(value, 1 / 2).round();
            final int cubeRoot = pow(value, 1 / 3).round();

            if (squareRoot * squareRoot == value) {
              if (cubeRoot * cubeRoot * cubeRoot == value) {
                // it's both
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(_textController.text),
                        content: SingleChildScrollView(
                          child: Text('Number ${_textController.text} is both cube and square'),
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
                    });
              } else {
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
                    });
              }
            } else if (cubeRoot * cubeRoot * cubeRoot == value) {
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
                  });
            } else {
              // it's neither
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(_textController.text),
                      content: SingleChildScrollView(
                          child: Text('Number ${_textController.text} is NEITHER cube, nor square')),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            }
          }
        },
        tooltip: 'Check number',
        child: const Icon(Icons.check),
      ),
    );
  }
}
