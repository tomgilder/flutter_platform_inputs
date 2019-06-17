import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:platform_inputs/platform_inputs.dart';
import 'package:platform_inputs/ui_text_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

  }

  final TextEditingController _controller = TextEditingController(text: "Initial Text");
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Header("TextField:"),
                TextField(),

                Header("CupertinoTextField"),
                CupertinoTextField(placeholder: "Placeholder"),

                Header("UiTextField Text:"),
                UiTextField(focusNode: FocusNode(),),

                Header("UiTextField Password:"),
                UiTextField(
                  placeholder: "Placeholder",
                  textContentType: TextContentType.password,
                  keyboardType: KeyboardType.defaultType,
                  obsecureText: true,
                  onChanged: (value) {
                    print("UiTextField.onChanged: $value");
                  },
                  onSubmitted: (value) {
                    print("UiTextField.onSubmitted: $value");
                  },
                  controller: _controller,
                  focusNode: _focusNode
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String text;

  Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(text, style: TextStyle(fontSize: 15),),
    );
  }

}