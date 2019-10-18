import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Controller {
  final List<Widget> timeHoursPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('timeHours${i.toString()}'),
          ))
      .toList();

  final List<Widget> timeMinutesPicker = Iterable<int>.generate(60)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('timeMinutes${i.toString()}'),
          ))
      .toList();

  final List<Widget> timeSecondsPicker = Iterable<int>.generate(60)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('timeSeconds${i.toString()}'),
          ))
      .toList();

  final List<Widget> pyThousandsPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('pyThousands${i.toString()}'),
          ))
      .toList();

  final List<Widget> pyHundredsPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('pyHundreds${i.toString()}'),
          ))
      .toList();

  final List<Widget> pyTensPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('pyTens${i.toString()}'),
          ))
      .toList();

  final List<Widget> pyUnitsPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('pyUnits${i.toString()}'),
          ))
      .toList();

  final List<Widget> lapsPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('laps${i.toString()}'),
          ))
      .toList();

  final List<Widget> maxLapsPicker = Iterable<int>.generate(10)
      .map<Widget>((i) => Text(
            i.toString(),
            key: Key('maxLaps${i.toString()}'),
          ))
      .toList();

  //Input subjects. in the future try and make these input only
  ReplaySubject<int> lapsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> maxLapsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> timeHoursIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> timeMinutesIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> timeSecondsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyThousandsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyHundredsIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyTensIndexSubject = ReplaySubject<int>();
  ReplaySubject<int> pyUnitsIndexSubject = ReplaySubject<int>();

  //Outputs
  Observable<String> correctedTimeString;
  Observable<String> outputLabel;

  Controller() {
    //calculate time from pickers
    Observable<dynamic> timeDynamic = Observable.combineLatest3(
            timeHoursIndexSubject,
            timeMinutesIndexSubject,
            timeSecondsIndexSubject,
            (a, b, c) => a.toDouble() * 3600 + b.toDouble() * 60 + c.toDouble())
        .asBroadcastStream();

    //Calculate PY from pickers
    Observable<dynamic> pyDynamic = Observable.combineLatest4(
        pyThousandsIndexSubject,
        pyHundredsIndexSubject,
        pyTensIndexSubject,
        pyUnitsIndexSubject,
        (a, b, c, d) =>
            a.toDouble() * 1000 +
            b.toDouble() * 100 +
            c.toDouble() * 10 +
            d.toDouble()).asBroadcastStream();

    //Also get Laps and Max Laps values from pickers
    Observable<double> lapsDouble =
        lapsIndexSubject.map((i) => i.toDouble()).asBroadcastStream();
    Observable<double> maxLapsDouble =
        maxLapsIndexSubject.map((i) => i.toDouble()).asBroadcastStream();

    //Calculate corrected time and output to member stream
    correctedTimeString = Observable.combineLatest4(
        timeDynamic,
        pyDynamic,
        lapsDouble,
        maxLapsDouble,
        (a, b, c, d) =>
            _calcCorrectedTimeString(time: a, py: b, laps: c, maxLaps: d));

    //Work out corrected time and output to member stream
    outputLabel = Observable.combineLatest4(
        timeDynamic,
        pyDynamic,
        lapsDouble,
        maxLapsDouble,
        (a, b, c, d) => _outputLabelText(time: a, py: b, laps: c, maxLaps: d));

    //Add initial values as pickers don't do this

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
    if (time == 0) {
      return ('Please set Elapsed Time');
    } else if (py == 0) {
      return ('Please set PY');
    } else if (laps == 0) {
      return ('Please set Laps');
    } else if (maxLaps == 0) {
      return ('Please set Max laps');
    } else if (maxLaps < laps) {
      return ('Laps should be equal to or less than max laps');
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
