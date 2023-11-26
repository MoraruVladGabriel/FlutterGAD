import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const ScrollableApp());
}

class ScrollableApp extends StatelessWidget {
  const ScrollableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int random = Random().nextInt(100) + 1;
  int? number;
  bool status = false;
  String? message;
  String? error;
  String? input;
  bool isTextFieldEnabled = true;
  bool isGuessButtonEnabled = true;

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess my number'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I'm thinking of a number",
                  style: TextStyle(fontSize: 28),
                ),
                Text(
                  "between 1 and 100.",
                  style: TextStyle(fontSize: 28),
                ),
              ],
            ),
            const Text(
              "It's your turn to guess my number!",
              style: TextStyle(fontSize: 22),
            ),
            Visibility(
              visible: status,
              child: Column(
                children: <Widget>[
                  Text(
                    "You tried $number",
                    style: const TextStyle(fontSize: 50),
                  ),
                  Text(
                    "Try $message",
                    style: const TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  const Text(
                    "Try a number!",
                    style: TextStyle(fontSize: 32),
                  ),
                  TextField(
                    controller: _textController,
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    decoration: InputDecoration(
                      errorText: error,
                    ),
                    onChanged: _onTextChanged,
                    enabled: isTextFieldEnabled,
                  ),
                  ElevatedButton(
                    onPressed: isGuessButtonEnabled
                        ? _onGuessPressed
                        : _onResetPressed,
                    child: Text(isGuessButtonEnabled ? 'GUESS' : 'RESET'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onTextChanged(String value) {
    // ignore: avoid_print
    print(random);
    setState(() {
      if (value.isNotEmpty) {
        int? nr = int.tryParse(value);
        if (nr == null) {
          error = "Value must be a number!";
        } else if (nr < 1 || nr > 100) {
          error = "Value must be a number between 1 and 100";
        } else {
          error = null;
          number = nr;
        }
      }
    });
  }

  void _onGuessPressed() {
    setState(() {
      if (number! < random) {
        status = true;
        message = "higher";
      } else if (number! > random) {
        status = true;
        message = "lower";
      } else {
        _showAlertDialog();
        isTextFieldEnabled = true;
      }
      _textController.text = '';
    });
  }

  void _onResetPressed() {
    setState(() {
      random = Random().nextInt(100) + 1; // Generează un nou număr aleatoriu
      number = null;
      status = false;
      message = null;
      error = null;
      input = null;
      isTextFieldEnabled = true;
      isGuessButtonEnabled = true;
      _textController.text = '';
    });
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You guessed right'),
          content: Text('It was $random.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _onResetPressed();
              },
              child: const Text('Try again!'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isTextFieldEnabled = false;
                  isGuessButtonEnabled = false;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
