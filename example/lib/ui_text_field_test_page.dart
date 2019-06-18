import 'package:flutter/material.dart';
import 'package:platform_inputs/ui_text_field.dart';

class UiTextFieldTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UiTextFieldTestPageState();
}

class _UiTextFieldTestPageState extends State<UiTextFieldTestPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _changeTextController = TextEditingController();

  String _onChangedText = "...it will show here";
  String _onSubmittedText = "...it will show here on submit";

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
            title: "onSubmitted test",
            child: Column(children: [
              UiTextField(
                placeholder: "Type something here and return...",
                onSubmitted: (value) {
                  setState(() {
                    _onSubmittedText = value;
                  });
                },
              ),
              Text(_onSubmittedText)
            ]),
          ),
          Item(
              title: "Focus test text field",
              child: Column(
                children: [
                  FlatButton(
                    child: Text("Tap here to focus text field"),
                    onPressed: () => FocusScope.of(context).requestFocus(_focusNode),
                  ),
                  UiTextField(
                    focusNode: _focusNode,
                  )
                ],
              )),
              
          Item(
              title: "Change text from Flutter",
              child: Column(
                children: [
                  FlatButton(
                    child: Text("Tap here to change text"),
                    onPressed: () => _changeTextController.text = DateTime.now().toString(),
                  ),
                  UiTextField(
                    controller: _changeTextController,  
                  )
                ],
              )),

          Item(
            title: "Aligned UiTextFields",
            child: Column(
              children: <Widget>[
                UiTextField(textAlign: TextAlign.left, controller: TextEditingController(text: "left"),),
                UiTextField(textAlign: TextAlign.right, controller: TextEditingController(text: "right"),),
                UiTextField(textAlign: TextAlign.center, controller: TextEditingController(text: "center"),),
                UiTextField(textAlign: TextAlign.justify, controller: TextEditingController(text: "justify"),),
                UiTextField(textAlign: TextAlign.start, controller: TextEditingController(text: "start"),),
                UiTextField(textAlign: TextAlign.end, controller: TextEditingController(text: "end"),),
              ],
            )
          ),

          Item(
            title: "UiTextFields Keyboard Types",
            child: Column(
              children: <Widget>[
                UiTextField(keyboardType: KeyboardType.defaultType, controller: TextEditingController(text: "KeyboardType.defaultType"),),
                UiTextField(keyboardType: KeyboardType.asciiCapable, controller: TextEditingController(text: "KeyboardType.asciiCapable"),),
                UiTextField(keyboardType: KeyboardType.numbersAndPunctuation, controller: TextEditingController(text: "KeyboardType.numbersAndPunctuation"),),
                UiTextField(keyboardType: KeyboardType.url, controller: TextEditingController(text: "KeyboardType.url"),),
                UiTextField(keyboardType: KeyboardType.numberPad, controller: TextEditingController(text: "KeyboardType.numberPad"),),
                UiTextField(keyboardType: KeyboardType.phonePad, controller: TextEditingController(text: "KeyboardType.phonePad"),),
                UiTextField(keyboardType: KeyboardType.namePhonePad, controller: TextEditingController(text: "KeyboardType.namePhonePad"),),
                UiTextField(keyboardType: KeyboardType.emailAddress, controller: TextEditingController(text: "KeyboardType.emailAddress"),),
                UiTextField(keyboardType: KeyboardType.decimalPad, controller: TextEditingController(text: "KeyboardType.decimalPad"),),
                UiTextField(keyboardType: KeyboardType.twitter, controller: TextEditingController(text: "KeyboardType.twitter"),),
                UiTextField(keyboardType: KeyboardType.webSearch, controller: TextEditingController(text: "KeyboardType.webSearch"),),
                UiTextField(keyboardType: KeyboardType.asciiCapableNumberPad, controller: TextEditingController(text: "KeyboardType.asciiCapableNumberPad"),),

              ],
            )
          ),

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
