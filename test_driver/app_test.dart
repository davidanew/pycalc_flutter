//import 'package:flutter/foundation.dart';
//import 'package:pycalc_flutter/constants.dart';
//import 'package:tuple/tuple.dart';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//flutter drive --target=test_driver/app.dart

void main() {
  group('Counter App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

//    test('Set All Pickers To 1', () async {
//// Use the `driver.getText` method to verify the counter starts at 0.
////      await driver.tap(hoursPicker);
//      //expect(await driver.getText(counterTextFinder), "0");
//
//      await Future.delayed(const Duration(seconds: 2), () {});
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('timeHoursPicker'),
//        find.byValueKey('timeHours1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('timeMinutesPicker'),
//        find.byValueKey('timeMinutes1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('timeSecondsPicker'),
//        find.byValueKey('timeSeconds1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('pyThousandsPicker'),
//        find.byValueKey('pyThousands1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('pyHundredsPicker'),
//        find.byValueKey('pyHundreds1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('pyTensPicker'),
//        find.byValueKey('pyTens1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('pyUnitsPicker'),
//        find.byValueKey('pyUnits1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('lapsPicker'),
//        find.byValueKey('laps1'),
//        dyScroll: -30.0,
//      );
//
//      await driver.scrollUntilVisible(
//        find.byValueKey('maxLapsPicker'),
//        find.byValueKey('maxLaps1'),
//        dyScroll: -30.0,
//      );
//    });

//    test('Test Procedure', () async {
//      await procedure(driver);
//    });

    test('Test Set Value', () async {
      //InputData inputData = InputData()

      InputData inputData = InputData(
          timeHours: 2,
          timeMinutes: 2,
          timeSeconds: 2,
          pyThousands: 2,
          pyHundreds: 2,
          pyTens: 2,
          pyUnits: 2,
          laps: 2,
          maxLaps: 2);

      OutputData outputData = OutputData(
          outputLabel: '',
          correctedTime: calcCorrectedTime(inputData: inputData));

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
//        timeTuple: Tuple3(2, 2, 2),
//        pyTuple: Tuple4(2, 2, 2, 2),
//        laps: 2,
//        maxLaps: 2,
      );
    });

//
//    test('increments the counter', () async {
//// First, tap the button.
//      await driver.tap(buttonFinder);
//
//// Then, verify the counter text is incremented by 1.
//      expect(await driver.getText(counterTextFinder), "1");
//    });
  });
}

//Future<void> procedure(FlutterDriver driver) async {
//  await driver.scrollUntilVisible(
//    find.byValueKey('timeHoursPicker'),
//    find.byValueKey('timeHours2'),
//    dyScroll: -30.0,
//  );
//}

Future<void> setAndCheck({
  FlutterDriver driver,
  InputData inputData,
  OutputData outputData,
}) async {
  //const timeTuple = const Tuple3<int, int, int>(4, 5, 6);

//  num timeHours = timeTuple.item1;
//  num timeMinutes = timeTuple.item2;
//  num timeSeconds = timeTuple.item3;
//  num pyThousands = pyTuple.item1;
//  num pyHundreds = pyTuple.item2;
//  num pyTens = pyTuple.item3;
//  num pyUnits = pyTuple.item4;

  var list = [
    ['timeHours', inputData.timeHours],
    ['timeMinutes', inputData.timeMinutes],
    ['timeSeconds', inputData.timeSeconds],
    ['pyThousands', inputData.pyThousands],
    ['pyHundreds', inputData.pyHundreds],
    ['pyTens', inputData.pyTens],
    ['pyUnits', inputData.pyUnits],
    ['laps', inputData.laps],
    ['maxLaps', inputData.maxLaps],
  ];

  for (var i in list) {
    //   print('Got here XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    await driver.scrollUntilVisible(
      find.byValueKey('${i.first}Picker'),
      find.byValueKey('${i.first}${i.last}'),
      dyScroll: -30.0,
    );
  }

//  num time = timeHours * 60 * 60 + timeMinutes * 60 + timeSeconds;
//  num py = pyThousands * 1000 + pyHundreds * 100 + pyTens * 10 + pyUnits;
//  num correctedTime = (1000.0 * time * maxLaps) / (py * laps);
  print('Expected corrected time:${outputData.correctedTime}');

  //expect(driver.getText(find.byValueKey('correctedTime')),
  // outputData.correctedTime);

//
  await Future.delayed(const Duration(seconds: 5), () {});
  expect(await driver.getText(find.byValueKey('correctedTime')),
      outputData.correctedTime);

  //// Then, verify the counter text is incremented by 1.
//      expect(await driver.getText(counterTextFinder), "1");
//    });
}

String calcCorrectedTime({InputData inputData}) {
  num time = inputData.timeHours * 60 * 60 +
      inputData.timeMinutes * 60 +
      inputData.timeSeconds;
  num py = inputData.pyThousands * 1000 +
      inputData.pyHundreds * 100 +
      inputData.pyTens * 10 +
      inputData.pyUnits;
  num correctedTime =
      (1000.0 * time * inputData.maxLaps) / (py * inputData.laps);
  return (correctedTime.toStringAsFixed(1));
}

class InputData {
  num timeHours;
  num timeMinutes;
  num timeSeconds;
  num pyThousands;
  num pyHundreds;
  num pyTens;
  num pyUnits;
  num laps;
  num maxLaps;

  InputData(
      {this.timeHours,
      this.timeMinutes,
      this.timeSeconds,
      this.pyThousands,
      this.pyHundreds,
      this.pyTens,
      this.pyUnits,
      this.laps,
      this.maxLaps});
}

class OutputData {
  String outputLabel;
  String correctedTime;

  OutputData({this.outputLabel, this.correctedTime});
}

//3295.2
