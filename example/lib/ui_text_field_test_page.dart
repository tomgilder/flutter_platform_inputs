import 'package:flutter/material.dart';
import 'package:platform_inputs/ui_text_field.dart';

class UiTextFieldTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UiTextFieldTestPageState();
}

class _UiTextFieldTestPageState extends State<UiTextFieldTestPage> {
  final FocusNode _focusNode = FocusNode();

  String _onChangedText = "...it will show here";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UiTextField tests"),
      ),
      body: ListView(
        children: [
          Item(title: "Plain UiTextField", child: UiTextField()),
          
          Item(
              title: "Placeholder UiTextField",
              child: UiTextField(
                placeholder: "Placeholder",
              )),

          Item(
              title: "Pre-filled UiTextField",
              child: UiTextField(
                controller: TextEditingController(text: "Text"),
              )),

          Item(
              title: "Password UiTextField",
              child: UiTextField(
                obsecureText: true,
                textContentType: TextContentType.password,
              )),

          Item(
            title: "onChanged test",
            child: Column(children: [
              UiTextField(
                placeholder: "Type something here",
                onChanged: (value) {
                  setState(() {
                    _onChangedText = value;
                  });
                },
              ),
              Text(_onChangedText)
            ]),
          ),
          
          Item(
              title: "TODO: Focus test text field",
              child: Column(
                children: [
                  FlatButton(
                    child: Text("TODO: Tap here to focus text field"),
                    onPressed: () => FocusScope.of(context).requestFocus(_focusNode),
                  ),
                  UiTextField(
                    focusNode: _focusNode,
                  )
                ],
              )),
          SizedBox(
            height: 1000,
          )
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String title;
  final Widget child;

  Item({this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(title), child],
          ),
        ));
  }
}
