import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_inputs/ui_text_field.dart';

import 'ui_text_field_test_page.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController(text: "Initial Text");

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Hello! Welcome to the example app."),
                  MaterialButton(
                      child: Text("UiTextField test page"),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => UiTextFieldTestPage()));
                      }),
                  Header("TextField:"),
                  TextField(),
                  Header("CupertinoTextField"),
                  CupertinoTextField(placeholder: "Placeholder"),
                  Header("UiTextField Text:"),
                  UiTextField(
                    focusNode: FocusNode(),
                  ),
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
                      focusNode: _focusNode),
                ],
              ),
            ),
          ),
        ));
  }
}

class Header extends StatelessWidget {
  final String text;

  Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
