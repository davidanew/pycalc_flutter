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

  ReplaySubject<int> lapsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> maxLapsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> timeHoursIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> timeMinutesIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> timeSecondsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyThousandsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyHundredsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyTensIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyUnitsIndexSubject = ReplaySubject<int>();

  Observable<String> correctedTimeString;

  Observable<String> outputLabel;

  Controller() {
    //print(MediaQuery.of(context).size.width);

    Observable<dynamic> timeDouble = Observable.combineLatest3(
            timeHoursIndexSubject,
            timeMinutesIndexSubject,
            timeSecondsIndexSubject,
            (a, b, c) => a.toDouble() * 3600 + b.toDouble() * 60 + c.toDouble())
        .asBroadcastStream();

    //timeDouble.listen(print);

    Observable<dynamic> pyDouble = Observable.combineLatest4(
        pyThousandsIndexSubject,
        pyHundredsIndexSubject,
        pyTensIndexSubject,
        pyUnitsIndexSubject,
        (a, b, c, d) =>
            a.toDouble() * 1000 +
            b.toDouble() * 100 +
            c.toDouble() * 10 +
            d.toDouble()).asBroadcastStream();

    //pyDouble.listen(print);

    Observable<double> lapsDouble = lapsIndexSubject
        .map((i) => i.toDouble())
        //       .startWith(0)
        .asBroadcastStream();
    Observable<double> maxLapsDouble = maxLapsIndexSubject
        .map((i) => i.toDouble())
        //       .startWith(0)
        .asBroadcastStream();

    //lapsDouble.listen(print);
    //maxLapsDouble.listen(print);

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

    timeHoursIndexSubject.add(0);
    timeMinutesIndexSubject.add(0);
    timeSecondsIndexSubject.add(0);

    pyThousandsIndexSubject.add(0);
    pyHundredsIndexSubject.add(0);
    pyTensIndexSubject.add(0);
    pyUnitsIndexSubject.add(0);

    lapsIndexSubject.add(0);
    maxLapsIndexSubject.add(0);
  }

  String _calcCorrectedTimeString(
      {@required double time,
      @required double py,
      @required double laps,
      @required double maxLaps}) {
    if (time == 0 || py == 0 || laps == 0 || maxLaps == 0 || maxLaps < laps) {
      return ('');
    } else {
      final double correctedTime = (time * 1000 / py) * (maxLaps / laps);
      return correctedTime.toStringAsFixed(1);
    }
  }

  String _outputLabelText(
      {@required double time,
      @required double py,
      @required double laps,
      @required double maxLaps}) {
//    print('got here');
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
      return 'Corrected Time (seconds)';
    }
  }

  void dispose() {
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
