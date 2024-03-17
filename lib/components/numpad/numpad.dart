import 'package:flutter/material.dart';
import 'package:milunch_pos/providers/numpad.provider.dart';
import 'package:provider/provider.dart';

class NumberPad extends StatefulWidget {
  @override
  _NumberPadState createState() => _NumberPadState();
}

class _NumberPadState extends State<NumberPad> {
  void _appendToOutput(String value) {
    if (value.contains('.') &&
        Provider.of<NumberPadProvider>(context, listen: false)
            .currentValue
            .contains('.')) {
      return;
    } else {
      Provider.of<NumberPadProvider>(context, listen: false)
          .appendedValue(value);
    }
  }

  Widget numericInputButton(String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            _appendToOutput(value);
          },
          splashColor: Colors.red,
          child: Container(
            height: 50,
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19.0, color: Color(0xFF676767)),
            ),
          ),
        )
      ],
    );
  }

  Widget backButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
//Clicking on the back button removes erase the last number
            Provider.of<NumberPadProvider>(context, listen: false)
                .removeValue();
          },
          child: Container(
            height: 60,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(
              Icons.backspace,
              color: Color(0xFF676767),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 411.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 35.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      numericInputButton('1'),
                      numericInputButton('2'),
                      numericInputButton('3'),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      numericInputButton('4'),
                      numericInputButton('5'),
                      numericInputButton('6'),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      numericInputButton('7'),
                      numericInputButton('8'),
                      numericInputButton('9'),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      numericInputButton('.'),
                      numericInputButton('0'),
                      backButton()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
