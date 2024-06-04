import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OTPInput extends StatefulWidget {
  const OTPInput(
      {super.key,
      required this.authenticate,
      this.length = 16,
      this.enabled = true});

  final bool enabled;
  final int length;
  final Future<bool> Function(String)? authenticate;

  @override
  OTPInputState createState() => OTPInputState();
}

class OTPInputState extends State<OTPInput> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  bool? _isCodeCorrect;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_onFocusChange);

    // Add listener to convert text to uppercase
    pinController.addListener(_convertToUpperCase);
  }

  @override
  void dispose() {
    pinController.removeListener(_convertToUpperCase);
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (focusNode.hasFocus) {
      setState(() {
        _isCodeCorrect = null;
      });
    }
  }

  void _convertToUpperCase() {
    final text = pinController.text;
    if (text != text.toUpperCase()) {
      pinController.value = pinController.value.copyWith(
        text: text.toUpperCase(),
        // selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    // const fillColor = Colors.transparent;
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    var defaultPinTheme = PinTheme(
      width: 30,
      height: 28,
      textStyle: const TextStyle(
          fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        ),
      ),
    );

    final correctPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.redAccent,
            width: 2.0,
          ),
        ),
      ),
    );

    if (_isCodeCorrect == true) {
      defaultPinTheme = correctPinTheme;
    } else if (_isCodeCorrect == false) {
      defaultPinTheme = errorPinTheme;
    }

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              enabled: widget.enabled,
              enableSuggestions: false,
              length: widget.length,
              closeKeyboardWhenCompleted: true,
              keyboardType: TextInputType.text,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 5),

              onClipboardFound: (value) async {
                debugPrint('onClipboardFound: $value');
                var upperValue = value.toUpperCase();
                for (var i in upperValue.split('').toList()) {
                  await Future.delayed(Duration(milliseconds: 100));
                  pinController.text += i;
                }
              },
              // validator: (value) {
              //   if (value!.length < widget.length) return null;
              //   return value == widget.correctCode ? null : 'Pin is incorrect';
              // },
              onCompleted: (pin) async {
                // Perform authentication here
                var isAuthenticated = await widget.authenticate!(pin);
                setState(() {
                  _isCodeCorrect = isAuthenticated;
                });
              },
              onChanged: (value) {},
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 0),
                    width: 30,
                    height: 2,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                  ),
                ),
              ),
              submittedPinTheme: defaultPinTheme,
              errorPinTheme: errorPinTheme,
            ),
          ),
        ],
      ),
    );
  }
}
