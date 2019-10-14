import 'package:pycalc_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  static double margin;
  static double padding;
  static double spacing;
  static double radius;
  static double inputTextSize;
  static double labelTextSize;
  static double outputTextSize;
  //Should be with other constants
  static const maxAspectRatio = 0.6;
  static double aspectRatio;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    aspectRatio = screenWidth / screenHeight;
    print('Aspect ratio is $aspectRatio');

    /*

    Aspect ratio calculation:
    dart aspect ratio width / length
    work out what max aspect ratio can be tolerated with the above calculation
    lets say max aspect ratio is 0.6
    if aspect ratio is > 0.6 we need to know what the font size would have been
    if it was at 0.6
    say the current aspect ratio is 0.8
    font size = font size at 0.8 * 0.6/0.8
    so the above values need to be multiplied by the above factor,
    but only if the actual aspect ratio is more than the max aspect ratio

    say 100 height and 60 width
    font scale factor 0.1
    at max aspect the font size will be 0.06 (6% of height)
    say the device is rotated so now 60 height and 100 width
    font size will now be 100 * 0.1 * 0.6/1.6666  =   10*0.36 = 3.6
    = 6 % of height

    So this is right

    Now need method to calculate this. Scaling should always be 1 or less than

    */

    final double scaleFactor = maxAspectRatio / aspectRatio;

    //rename height limited scale factor

    final double fontScale = min(scaleFactor, 1);

    inputTextSize = screenWidth * kInputTextFraction * fontScale;
    labelTextSize = screenWidth * kLabelTextFraction * fontScale;
    outputTextSize = screenWidth * kOutputTextFraction * fontScale;

    margin = screenWidth * kMarginFraction * fontScale;
    padding = screenWidth * kPaddingFraction * fontScale;
    spacing = screenWidth * kSpacingFraction * fontScale;
    radius = screenWidth * kRadiusFraction * fontScale;
  }
}
