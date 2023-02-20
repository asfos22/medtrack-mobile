import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

import './numpad_controller.dart';

class NumPadKeyboard extends StatefulWidget {
  final Color clearKeyBackgroundColor,
      backKeyBackgroundColor,
      keyColor,
      keyFontColor;
  final Color? backKeyFontColor, clearKeyFontColor;
  final int pinInputLength;
  final TextEditingController pinInputController;
  final NumPadController? numPadController;

  const NumPadKeyboard({
    Key? key,
    this.pinInputLength = 5,
    required this.clearKeyBackgroundColor,
    this.backKeyBackgroundColor = Colors.black38,
    this.keyColor = Colors.black26,
    this.keyFontColor = Colors.white,
    this.backKeyFontColor = Colors.white,
    this.clearKeyFontColor = Colors.white,
    required this.pinInputController,
    this.numPadController,
  }) : super(key: key);

  @override
  State<NumPadKeyboard> createState() => _NumPadKeyboardState();
}

class _NumPadKeyboardState extends State<NumPadKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              NumPadKey(
                digit: '1',
                alpha: '',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '1';
                  }
                },
              ),
              NumPadKey(
                digit: '2',
                alpha: 'A B C',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '2';
                  }
                },
              ),
              NumPadKey(
                digit: '3',
                alpha: 'D E F',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '3';
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumPadKey(
                digit: '4',
                alpha: 'G H I',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '4';
                  }
                },
              ),
              NumPadKey(
                digit: '5',
                alpha: 'J K L',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '5';
                  }
                },
              ),
              NumPadKey(
                digit: '6',
                alpha: 'M N O',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '6';
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              NumPadKey(
                digit: '7',
                alpha: 'P Q R S',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '7';
                  }
                },
              ),
              NumPadKey(
                digit: '8',
                alpha: 'T U V',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '8';
                  }
                },
              ),
              NumPadKey(
                digit: '9',
                alpha: 'W X Y Z',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '9';
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              /*NumPadKey(
                  digit: Icon(
                    Icons.clear,
                    size: 20,
                    color: widget.clearKeyFontColor,
                  ),
                  keyBackgroundColor: widget.clearKeyBackgroundColor,
                  onPressed: () {
                    NumPadController.shakeAnimation!.forward();
                    widget.pinInputController.clear();
                  }),*/
              NumPadKey(
                digit: '0',
                alpha: '',
                keyBackgroundColor: widget.keyColor,
                keyContentColor: widget.keyFontColor,
                onPressed: () {
                  if (widget.pinInputController.text.length <
                      widget.pinInputLength) {
                    widget.pinInputController.text += '0';
                  }
                },
              ),
              NumPadKey(
                  digit: Icon(
                    Icons.backspace,
                    size: 20,
                    color: widget.backKeyFontColor,
                  ),
                  alpha: '',
                  keyBackgroundColor: widget.backKeyBackgroundColor,
                  onPressed: () {
                    String text = widget.pinInputController.text;
                    int length = text.length;
                    widget.pinInputController.text = text.substring(0, length - 1);
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class NumPadKeyContent extends StatefulWidget {
  final content, color;

  const NumPadKeyContent({Key? key, this.content, this.color})
      : super(key: key);

  @override
  State<NumPadKeyContent> createState() => _NumPadKeyContentState();
}

class _NumPadKeyContentState extends State<NumPadKeyContent> {
  @override
  Widget build(BuildContext context) {
    if (widget.content is String) {
      return Container(
        alignment: Alignment.center,
        child: Text(
          widget.content,
          style: TextStyle(
              fontSize: 25, color: widget.color, fontWeight: FontWeight.normal),
        ),
      );
    } else if (widget.content is Icon) {
      return Container(
        alignment: Alignment.center,
        child: widget.content,
      );
    }
    return Container();
  }
}

class NumPadKey extends StatelessWidget {
  final digit;
  final String alpha;
  final Color? keyBackgroundColor, keyContentColor;
  final Function() onPressed;

  const NumPadKey(
      {Key? key,
      this.digit,
      required this.alpha,
      this.keyBackgroundColor,
      this.keyContentColor,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    //var width = screenSize.width;
    var height = screenSize.height;
    double margin = 15.0;

    var size = (height / 10);
    return Container(
      child: FittedBox(
          fit: BoxFit.cover,
          child: /*MaterialButton(
            child: NumPadKeyContent(content: digit, color: keyContentColor),
            onPressed: onPressed,
            elevation: 1.0,
            color: keyBackgroundColor,
            padding: EdgeInsets.all(margin),
            shape: const CircleBorder(),
          )*/
              FlatButton(
            padding: EdgeInsets.all(margin),
            color: keyBackgroundColor,
            shape: const CircleBorder(),
            child: Column(
              children: [
                NumPadKeyContent(content: digit, color: keyContentColor),
                alpha.isNotEmpty
                    ? Text(alpha,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.subLabelColor))
                    : Container()
                //NumPadKeyContent(content: digit, color: keyContentColor)
              ],
            ),
            /* Append new digit to current text string. */
            onPressed: onPressed,
          )),
      margin: EdgeInsets.fromLTRB(margin - 3, margin - 11, margin, margin - 11),
      height: size + 10,
      width: size + 10,
    );
  }
}
