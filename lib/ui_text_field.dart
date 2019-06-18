import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum TextContentType {
  name,
  namePrefix,
  givenName,
  middleName,
  familyName,
  nameSuffix,
  nickname,
  jobTitle,
  organizationName,
  location,
  fullStreetAddress,
  streetAddressLine1,
  streetAddressLine2,
  addressCity,
  addressState,
  addressCityAndState,
  sublocality,
  countryName,
  postalCode,
  telephoneNumber,
  emailAddress,
  url,
  creditCardNumber,
  username,
  password,
  newPassword, // iOS12+
  oneTimeCode // iOS12+
}

enum KeyboardType {
  /// Default type for the current input method.
  defaultType,

  /// Displays a keyboard which can enter ASCII characters
  asciiCapable,

  /// Numbers and assorted punctuation.
  numbersAndPunctuation,

  /// A type optimized for URL entry (shows . / .com prominently).
  url,

  /// A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN
  numberPad,

  /// A phone pad (1-9, *, 0, #, with letters under the numbers).
  phonePad,

  /// A type optimized for entering a person's name or phone number.
  namePhonePad,

  /// A type optimized for multiple email address entry (shows space @ . prominently).
  emailAddress,

  /// A number pad with a decimal point. iOS 4.1+.
  decimalPad,

  /// A type optimized for twitter text entry (easy access to @ #).
  twitter,

  /// A default keyboard type with URL-oriented addition (shows space . prominently).
  webSearch,
  // A number pad (0-9) that will always be ASCII digits. Falls back to KeyboardType.numberPad below iOS 10.
  asciiCapableNumberPad
}

class UiTextField extends StatefulWidget {
  const UiTextField({
    Key key,
    this.controller,
    this.placeholder,
    this.textContentType,
    this.keyboardType = KeyboardType.defaultType,
    this.obsecureText = false,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController controller;

  /// A lighter colored placeholder hint that appears on the first line of the
  /// text field when the text entry is empty.
  ///
  /// Defaults to having no placeholder text.
  ///
  /// The text style of the placeholder text matches that of the text field's
  /// main text entry except a lighter font weight and a grey font color.
  final String placeholder;

  final TextContentType textContentType;

  final KeyboardType keyboardType;

  final bool obsecureText;

  final ValueChanged<String> onChanged;

  final ValueChanged<String> onSubmitted;

  final FocusNode focusNode;

  final TextAlign textAlign;

  @override
  State<StatefulWidget> createState() => _UiTextFieldState();
}

class _UiTextFieldState extends State<UiTextField> {
  MethodChannel _channel;

  TextEditingController _controller;
  TextEditingController get _effectiveController => widget.controller ?? (_controller ??= TextEditingController());

  FocusNode _focusNode;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();

    if (widget.focusNode != null) {
      // TODO: remove listener
      // TODO: handle didUpdateWidget
      widget.focusNode.addListener(() {
        if (widget.focusNode.hasFocus) {
          _channel.invokeMethod("focus");
        }
      });
    }

    if (widget.controller != null) {
      // TODO: remove listener
      // TODO: handle didUpdateWidget
      widget.controller.addListener(() {
        _channel.invokeMethod("setText", {"text": widget.controller.text ?? ""});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 31, maxHeight: 31),
      child: UiKitView(
          viewType: "dev.gilder.tom/uitextfield",
          creationParamsCodec: const StandardMessageCodec(),
          creationParams: _buildCreationParams(),
          onPlatformViewCreated: _createMethodChannel),
    );
  }

  void _createMethodChannel(int nativeViewId) {
    _channel = MethodChannel("dev.gilder.tom/uitextfield_$nativeViewId")..setMethodCallHandler(_onMethodCall);
  }

  Map<String, dynamic> _buildCreationParams() {
    return {
      "text": _effectiveController.text ?? "",
      "placeholder": widget.placeholder ?? "",
      "textContentType": widget.textContentType?.toString(),
      "keyboardType": widget.keyboardType?.toString(),
      "obsecureText": widget.obsecureText,
      "textAlign": widget.textAlign.toString()
    };
  }

  Future<bool> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case "onChanged":
        final String text = call.arguments["text"];
        _onTextFieldChanged(text);
        return null;

      case "textFieldDidBeginEditing":
        _textFieldDidBeginEditing();
        return null;

      case "textFieldDidEndEditing":
        final String text = call.arguments["text"];
        _textFieldDidEndEditing(text);
        return null;
    }

    throw MissingPluginException("UiTextField._onMethodCall: No handler for ${call.method}");
  }

  void _onTextFieldChanged(String text) {
    if (text != null && widget?.onChanged != null) {
      widget.onChanged(text);
    }
  }

  // UITextFieldDelegate methods

  void _textFieldDidBeginEditing() {
    FocusScope.of(context).requestFocus(_effectiveFocusNode);
    _scrollIntoView();
  }

  /// Editing stopped for the specified text field.
  void _textFieldDidEndEditing(String text) {
    if (widget?.onSubmitted != null) {
      widget.onSubmitted(text);
    }
  }

  static const Duration _caretAnimationDuration = Duration(milliseconds: 100);
  static const Curve _caretAnimationCurve = Curves.fastOutSlowIn;

  void _scrollIntoView() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.findRenderObject().showOnScreen(
            duration: _caretAnimationDuration,
            curve: _caretAnimationCurve,
          );
    });
  }
}
