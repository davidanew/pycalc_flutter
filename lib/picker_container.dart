import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pycalc_flutter/constants.dart';

class PickerContainer extends StatelessWidget {
  final void Function(int) onSelectedItemChanged;
  final List<Widget> contents;

  PickerContainer(
      {@required this.contents, @required this.onSelectedItemChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      //Layout builder used to calculate font size and item extent
      child: LayoutBuilder(builder: (context, constraint) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              pickerTextStyle: TextStyle(
                fontSize: constraint.maxHeight * 0.18,
                color: Colors.black,
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          child: CupertinoPicker(
            magnification: 1.5,
            useMagnifier: true,
            backgroundColor: kCardColor,
            itemExtent: constraint.maxHeight * 0.20,
            onSelectedItemChanged: (i) {
              onSelectedItemChanged(i);
            },
            children: contents,
          ),
        );
      }),
    );
  }
}
