# Flutter Platform Inputs

Access native text fields from Flutter.

Use familar Flutter widget syntax to create native platform text fields to access native features such as password autofill.

Early work in progress, currently only supports iOS.

## Why would I want this?

Flutter provides excellent reproductions of iOS and Android text fields, but they aren't always as good as the real thing and lack support for some features.

For instance you can't access iOS password autofill with a Flutter `CupertinoTextField`, but you can with this package.

![](https://cdn-images-1.medium.com/max/1600/1*ckSaxYa7nznGlOuBAULmFQ.png)


## Example

```dart
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
