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

  Observable<String> correctedTimeString;

  Observable<String> outputLabel;

  Controller() {
    Observable<double> timeDouble =
        timeIndexSubject.map((i) => i.toDouble()).startWith(0);
    Observable<double> pyDouble =
        pyIndexSubject.map((i) => i.toDouble()).startWith(0);
    Observable<double> lapsDouble =
        lapsIndexSubject.map((i) => i.toDouble()).startWith(0);
    Observable<double> maxLapsDouble =
        maxLapsIndexSubject.map((i) => i.toDouble()).startWith(0);

    correctedTimeString = Observable.combineLatest4(
        timeDouble,
        pyDouble,
        lapsDouble,
        maxLapsDouble,
        (a, b, c, d) =>
            calcCorrectedTimeString(time: a, py: b, laps: c, maxLaps: d));

    outputLabel = Observable.combineLatest4(
        timeDouble,
        pyDouble,
        lapsDouble,
        maxLapsDouble,
        (a, b, c, d) => outputLabelText(time: a, py: b, laps: c, maxLaps: d));
  }

  String calcCorrectedTimeString(
      {@required double time,
      @required double py,
      @required double laps,
      @required double maxLaps}) {
    if (time == 0 || py == 0 || laps == 0 || maxLaps == 0 || maxLaps < laps) {
      return ('');
    } else {
      final double correctedTime = (time / py) * (maxLaps / laps);
      return correctedTime.toString();
    }
  }

  String outputLabelText(
      {@required double time,
      @required double py,
      @required double laps,
      @required double maxLaps}) {
    if (time == 0) {
      return ('Please set elapsed time');
    } else if (py == 0) {
      return ('Please set PY');
    } else if (laps == 0) {
      return ('Please set Laps');
    } else if (maxLaps == 0) {
      return ('Please set Max laps');
    } else if (maxLaps < laps) {
      return ('Laps should be equal or less than max laps');
    } else {
      return 'Corrected Time';
    }
  }

  void dispose() {
    maxLapsIndexSubject.close();
    lapsIndexSubject.close();
    timeIndexSubject.close();
    pyIndexSubject.close();
  }
}
