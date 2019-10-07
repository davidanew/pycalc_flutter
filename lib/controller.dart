import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Controller {
  String testString = 'Test string';

  List<Text> picker0To9 =
      Iterable<int>.generate(10).map<Text>((i) => Text(i.toString())).toList();

  PublishSubject<int> lapsIndexSubject = PublishSubject<int>();
  PublishSubject<int> maxLapsIndexSubject = PublishSubject<int>();
  PublishSubject<int> timeIndexSubject = PublishSubject<int>();
  PublishSubject<int> pyIndexSubject = PublishSubject<int>();

  Observable<String> resultString;

  Controller() {
    Observable<double> lapsDouble =
        lapsIndexSubject.map((i) => i.toDouble()).startWith(0);
    Observable<double> maxLapsDouble =
        maxLapsIndexSubject.map((i) => i.toDouble()).startWith(0);
    Observable<double> timeDouble =
        timeIndexSubject.map((i) => i.toDouble()).startWith(0);
    Observable<double> pyDouble =
        pyIndexSubject.map((i) => i.toDouble()).startWith(0);

    //could just pass in all variables here to standard function
    //it would be much simpler that what is in ios version

    Observable<double> result = Observable.combineLatest4(timeDouble, pyDouble,
        lapsDouble, maxLapsDouble, (a, b, c, d) => (a / b) * (c / d));

    resultString = result.map((item) => item.toString());

    //similar function needed for output string
  }

  void dispose() {
//    _correctedTimeController.close();
    maxLapsIndexSubject.close();
    lapsIndexSubject.close();
    timeIndexSubject.close();
    pyIndexSubject.close();
  }
}
