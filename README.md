# Flutter Platform Inputs

Access native text fields from Flutter.

Use familar Flutter widget syntax to create native platform text fields to access native features such as password autofill.

Early work in progress, currently only supports iOS.


## Example

```
UiTextField(
    controller: TextEditingController("initial value"),
    focusNode: FocusNode()
    placeholder: "Placeholder",
    textContentType: TextContentType.password,
    keyboardType: KeyboardType.defaultType,
    obsecureText: true,
    onChanged: (value) {
      print("$value");
    },
    onSubmitted: (value) {
      print("$value");
    },
),
```