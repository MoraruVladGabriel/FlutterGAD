import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double? number;
  double? changedNumber;
  String? text;
  String? error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Currency convertor'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/6607/6607631.png',
              fit: BoxFit.cover,
            ),
            TextField(
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Enter the amount in EUR',
                errorText: error,
              ),
              onChanged: (String value) {
                setState(() {
                  text = value;
                  number = double.tryParse(value)!;
                  if (number == null) {
                    error = 'Value must be a number!';
                  } else {
                    error = null;
                  }
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (number != null) {
                    changedNumber = number! * 4.5;
                  } else {
                    changedNumber = 0;
                  }
                });
              },
              child: const Text('CONVERT!'),
            ),
            Text('$changedNumber')
          ],
        ),
      ),
    );
  }
}
