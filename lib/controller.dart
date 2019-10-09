import 'package:flutter/material.dart';
//import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Controller {
  String testString = 'Test string';

  final List<Text> picker0To9 =
      Iterable<int>.generate(10).map<Text>((i) => Text(i.toString())).toList();
  final List<Text> picker0To59 =
      Iterable<int>.generate(60).map<Text>((i) => Text(i.toString())).toList();
  final List<Text> picker0To99 =
      Iterable<int>.generate(100).map<Text>((i) => Text(i.toString())).toList();

  PublishSubject<int> lapsIndexSubject = PublishSubject<int>();
  PublishSubject<int> maxLapsIndexSubject = PublishSubject<int>();
  PublishSubject<int> timeHoursIndexSubject = PublishSubject<int>();
  PublishSubject<int> timeMinutesIndexSubject = PublishSubject<int>();
  PublishSubject<int> timeSecondsIndexSubject = PublishSubject<int>();
  PublishSubject<int> pyThousandsIndexSubject = PublishSubject<int>();
  PublishSubject<int> pyHundredsIndexSubject = PublishSubject<int>();
  PublishSubject<int> pyTensIndexSubject = PublishSubject<int>();
  PublishSubject<int> pyUnitsIndexSubject = PublishSubject<int>();

  Observable<String> correctedTimeString;

  Observable<String> outputLabel;

  Controller() {
    Observable<dynamic> timeDouble = Observable.combineLatest3(
            timeHoursIndexSubject,
            timeMinutesIndexSubject,
            timeSecondsIndexSubject,
            (a, b, c) => a.toDouble() * 3600 + b.toDouble() * 60 + c.toDouble())
        .startWith(0.toDouble())
        .asBroadcastStream();

    timeDouble.listen(print);

    timeHoursIndexSubject.add(0);
    timeMinutesIndexSubject.add(0);
    timeSecondsIndexSubject.add(0);

//    Observable<dynamic> timeDouble = Observable.combineLatest3(
//        timeHoursIndexSubject,
//        timeMinutesIndexSubject,
//        timeSecondsIndexSubject,
//        (a, b, c) =>
//            (a.toDouble() * 3600 + b.toDouble() * 60 + c.toDouble() + .1)
//                .toDouble()).asBroadcastStream();

    Observable<dynamic> pyDouble = Observable.combineLatest4(
        pyThousandsIndexSubject,
        pyHundredsIndexSubject,
        pyTensIndexSubject,
        pyUnitsIndexSubject,
        (a, b, c, d) =>
            a.toDouble() * 1000 +
            b.toDouble() * 100 +
            c.toDouble() * 10 +
            d.toDouble()).startWith(0.toDouble()).asBroadcastStream();
//
//    Observable<double> timeDouble =
//        timeSecondsIndexSubject.map((i) => i.toDouble()).startWith(0);
//    Observable<double> pyDouble =
//        pyUnitsIndexSubject.map((i) => i.toDouble()).startWith(0);

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
            _calcCorrectedTimeString(time: a, py: b, laps: c, maxLaps: d));

    outputLabel = Observable.combineLatest4(
        timeDouble,
        pyDouble,
        lapsDouble,
        maxLapsDouble,
        (a, b, c, d) => _outputLabelText(time: a, py: b, laps: c, maxLaps: d));
  }

  String _calcCorrectedTimeString(
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

  String _outputLabelText(
      {@required double time,
      @required double py,
      @required double laps,
      @required double maxLaps}) {
    print('got here');
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
//    maxLapsIndexSubject.close();
//    lapsIndexSubject.close();
//    timeIndexSubject.close();
//    pyIndexSubject.close();

    lapsIndexSubject.close();
    maxLapsIndexSubject.close();
    timeHoursIndexSubject.close();
    timeMinutesIndexSubject.close();
    timeSecondsIndexSubject.close();
    pyThousandsIndexSubject.close();
    pyHundredsIndexSubject.close();
    pyTensIndexSubject.close();
    pyUnitsIndexSubject.close();
  }
}
