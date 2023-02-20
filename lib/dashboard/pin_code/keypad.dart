/**import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class Keypad extends StatefulWidget {
  const Keypad({Key? key}) : super(key: key);

  @override
  _KeypadState createState() => _KeypadState();
}

/// Building keypad is just a lot of rounded buttons creation, so nothing too
/// interesting here.
///
/// The only thing worth point attention to is the adaptive text size and phone
/// number formatting when a number gets too long.

class _KeypadState extends State<Keypad> {
  String typedNumber = "";

  TextStyle rebuildTextStyle() {
    /// Return different text styles depending on the number of symbols in it
    if (typedNumber.length <= 10) {
      return const TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      );
    } else if (typedNumber.length < 13) {
      return const TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w400,
      );
    } else {
      return const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w400,
      );
    }
  }

  late final int pinInputLength = 5; // Limit how many characters can be typed.
  late final String pinPlaceholder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.primaryColor,
        bottomSheet: Container(
          width: 200,
          height: 50,
          color: AppConstants.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Text("Create a pin "), Text("Create a pin ")],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.lock, color: AppConstants.whiteColor),
            const SizedBox(height: 24.0),
            const Text("Create a pin "),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 24),
              child: SizedBox(
                height: 50,
                child: Text(
                  /// If number gets really long, I truncate it to show only the
                  /// last 15 symbols, and everything else gets replaced by ...
                  typedNumber.length > 5
                      ? '...' +
                          typedNumber.substring(
                              typedNumber.length - 5, typedNumber.length)
                      : typedNumber,
                  style: rebuildTextStyle(),
                ),
              ),
            ),
            Visibility(
              /// if there is any number entered I should be able to add this medtrack pass codes
              child: const Padding(
                padding: EdgeInsets.only(
                  bottom: 12,
                ),
                child: Text(
                  "Add metrack password",
                ),
              ),
              maintainState: true,
              visible: typedNumber.isNotEmpty,
              maintainAnimation: true,
              maintainSize: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                NumberedRoundButton(
                    num: "1",
                    onPressed: () {
                      setState(() {
                        typedNumber += "1";
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                NumberedRoundButton(
                    num: "2",
                    onPressed: () {
                      setState(() {
                        typedNumber += "2";
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                NumberedRoundButton(
                    num: "3",
                    onPressed: () {
                      setState(() {
                        typedNumber += "3";
                      });
                    }),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NumberedRoundButton(
                    num: "4",
                    onPressed: () {
                      setState(() {
                        typedNumber += "4";
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                NumberedRoundButton(
                    num: "5",
                    onPressed: () {
                      setState(() {
                        typedNumber += "5";
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                NumberedRoundButton(
                    num: "6",
                    onPressed: () {
                      setState(() {
                        typedNumber += "6";
                      });
                    }),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                NumberedRoundButton(
                    num: "7",
                    onPressed: () {
                      setState(() {
                        typedNumber += "7";
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                NumberedRoundButton(
                    num: "8",
                    onPressed: () {
                      setState(() {
                        typedNumber += "8";
                      });
                    }),
                const SizedBox(
                  width: 20,
                ),
                NumberedRoundButton(
                    num: "9",
                    onPressed: () {
                      setState(() {
                        typedNumber += "9";
                      });
                    }),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  width: 100,
                ),
                GestureDetector(
                  /// When doing a long tap on 0 button, enter +
                  onLongPress: () {
                    setState(() {
                      typedNumber += '+';
                    });
                  },
                  child: NumberedRoundButton(
                      num: "0",
                      onPressed: () {
                        setState(() {
                          typedNumber += "0";
                        });
                      }),
                ),
                const SizedBox(
                  width: 20,
                ),
                DeleteButton(
                  onPressed: () {
                    setState(() {
                      typedNumber =
                          typedNumber.substring(0, typedNumber.length - 1);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}

class NumberedRoundButton extends StatelessWidget {
  const NumberedRoundButton({Key? key, this.num, this.onPressed})
      : super(key: key);

  final String? num;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return RoundButton(
      onPressed: onPressed!,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("$num", style: AppConstants.kKeyPadNumberTextStyle),
            AppConstants.numToTextMapping[num]!.isNotEmpty
                ? Text(
                    "${AppConstants.numToTextMapping[num]}",
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.subLabelColor),
                  )
                : Container(),
          ]),
    );
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  final Widget child;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: child,
      onPressed: onPressed,
      elevation: 0.0,
      constraints: const BoxConstraints.tightFor(
        width: 76.0,
        height: 76.0,
      ),
      shape: const CircleBorder(),
      fillColor: AppConstants.blackColor.withOpacity(0.5),
    );
  }
}

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key, this.onPressed}) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(
        Icons.backspace,
        size: 45,
        color: Colors.grey.shade300,
      ),
      onPressed: onPressed,
      elevation: 0.0,
      constraints: const BoxConstraints.tightFor(
        width: 76.0,
        height: 76.0,
      ),
      shape: const CircleBorder(),
      fillColor: null,
    );
  }
}
*/