/*
run test in terminal:

flutter drive --target=test_driver/app.dart

Random tests could fail of one of the values goes to zero, check log file

Manual tests:

Icon test on simulator

MotoG3, Samsung galaxy, iphone 6s, Samsung galaxy tab A, HTC

Check icon
Do one result
Check help button
check rotation lock

*/

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:math' show Random;
import 'package:meta/meta.dart';

void main() {
  group('pyCalc App', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Test extremes', () async {
      //div zero

      InputData inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 0,
          pyThousands: 0,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 0,
          laps: 0,
          maxLaps: 1);

      OutputData outputData = OutputData(
          outputText: 'Please set PY', correctedTime: null, helpButton: 'Help');

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

      //    //low value
//    setTimePicker(time: TimePickerInput(hours: 0, minutes: 0, seconds: 1))
//    setPyPicker(py: PyPickerInput(thousands: 9, hundreds: 9, tens: 9, units: 9))
//    setLapsPicker(numLaps: 1)
//    setMaxLapsPicker(numLaps: 1)
//    Thread.sleep(forTimeInterval: 1.0)
//    XCTAssertEqual("0.1", correctedTime.label)

      inputData = InputData(
          timeHours: 0,
          timeMinutes: 0,
          timeSeconds: 1,
          pyThousands: 9,
          pyHundreds: 9,
          pyTens: 9,
          pyUnits: 9,
          laps: 1,
          maxLaps: 1);

      outputData = OutputData(
          outputText: 'Corrected Time (seconds)',
          correctedTime: '0.1',
          helpButton: null);

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

      //    setTimePicker(time: TimePickerInput(hours: 9, minutes: 59, seconds: 59))
//    setPyPicker(py: PyPickerInput(thousands: 0, hundreds: 0, tens: 0, units: 1))
//    setLapsPicker(numLaps: 1)
//    setMaxLapsPicker(numLaps: 99)
//    Thread.sleep(forTimeInterval: 1.0)
//    //let expectedValue = (9.0 * 60.0 * 60.0 + 59.0 * 60.0 + 59) * (99.0 / 1.0) * (1000.0 / 1)
//    //print ("expected value is \(expectedValue)")
//    //print (correctedTime.label)
//    XCTAssertEqual("3.5639007e+09", correctedTime.label)

      inputData = InputData(
          timeHours: 9,
          timeMinutes: 59,
          timeSeconds: 59,
          pyThousands: 0,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 1,
          laps: 1,
          maxLaps: 99);

      outputData = OutputData(
          outputText: 'Corrected Time (seconds)',
          correctedTime: '3563901000.0',
          helpButton: null);

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );
    }, timeout: new Timeout.factor(10));

    test('Test Label', () async {
      InputData inputData = InputData(
          timeHours: 0,
          timeMinutes: 0,
          timeSeconds: 0,
          pyThousands: 0,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 0,
          laps: 0,
          maxLaps: 0);

      OutputData outputData = OutputData(
          outputText: 'Please set Elapsed Time',
          correctedTime: null,
          helpButton: 'Help');

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

      inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 0,
          pyThousands: 0,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 0,
          laps: 0,
          maxLaps: 0);

      outputData = OutputData(
          outputText: 'Please set PY', correctedTime: null, helpButton: 'Help');

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

      inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 0,
          pyThousands: 1,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 0,
          laps: 0,
          maxLaps: 0);

      outputData = OutputData(
          outputText: 'Please set Laps',
          correctedTime: null,
          helpButton: 'Help');

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

      inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 0,
          pyThousands: 1,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 0,
          laps: 1,
          maxLaps: 0);

      outputData = OutputData(
          outputText: 'Please set Max laps',
          correctedTime: null,
          helpButton: 'Help');

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

      inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 0,
          pyThousands: 1,
          pyHundreds: 0,
          pyTens: 0,
          pyUnits: 0,
          laps: 2,
          maxLaps: 1);

      outputData = OutputData(
          outputText: 'Laps should be equal to or less than max laps',
          correctedTime: null,
          helpButton: 'Help');

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );
    }, timeout: new Timeout.factor(10));
    //});

    test('Test Set Value', () async {
      //      //Laser radial 60.20 5/5 3162
//      setTimePicker(time: TimePickerInput(hours: 1, minutes: 0, seconds: 20))
//      setPyPicker(py: PyPickerInput(thousands: 1, hundreds: 1, tens: 4, units: 5))
//      setLapsPicker(numLaps: 5)
//      setMaxLapsPicker(numLaps: 5)
      //      XCTAssertEqual("3161.57", correctedTime.label)

      InputData inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 20,
          pyThousands: 1,
          pyHundreds: 1,
          pyTens: 4,
          pyUnits: 5,
          laps: 5,
          maxLaps: 5);

      OutputData outputData = OutputData(
          outputText: 'Corrected Time (seconds)',
//          correctedTime: calcCorrectedTime(inputData: inputData));
          correctedTime: '3161.6',
          helpButton: null);

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

//      //Laser std 60.14 5/5 3288
//      setTimePicker(time: TimePickerInput(hours: 1, minutes: 0, seconds: 14))
//      setPyPicker(py: PyPickerInput(thousands: 1, hundreds: 0, tens: 9, units: 9))
//      setLapsPicker(numLaps: 5)
//      setMaxLapsPicker(numLaps: 5)
//      Thread.sleep(forTimeInterval: 1.0)
//      XCTAssertEqual("3288.44", correctedTime.label)

      inputData = InputData(
          timeHours: 1,
          timeMinutes: 0,
          timeSeconds: 14,
          pyThousands: 1,
          pyHundreds: 0,
          pyTens: 9,
          pyUnits: 9,
          laps: 5,
          maxLaps: 5);

      outputData = OutputData(
          outputText: 'Corrected Time (seconds)',
          correctedTime: '3288.4',
          helpButton: null);

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );

//      //British Moth 56.28 4/5 3666.67
//      setTimePicker(time: TimePickerInput(hours: 0, minutes: 56, seconds: 28)) //3388
//      setPyPicker(py: PyPickerInput(thousands: 1, hundreds: 1, tens: 5, units: 5))
//      setLapsPicker(numLaps: 4)
//      setMaxLapsPicker(numLaps: 5)
//      XCTAssertEqual("3666.67", correctedTime.label)
      inputData = InputData(
          timeHours: 0,
          timeMinutes: 56,
          timeSeconds: 28,
          pyThousands: 1,
          pyHundreds: 1,
          pyTens: 5,
          pyUnits: 5,
          laps: 4,
          maxLaps: 5);

      outputData = OutputData(
          outputText: 'Corrected Time (seconds)',
          correctedTime: '3666.7',
          helpButton: null);

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );
    }, timeout: new Timeout.factor(5));

    test('Test random', () async {
      InputData inputData = InputData(
          timeHours: Random().nextInt(10),
          timeMinutes: Random().nextInt(60),
          timeSeconds: Random().nextInt(60),
          pyThousands: Random().nextInt(10),
          pyHundreds: Random().nextInt(10),
          pyTens: Random().nextInt(10),
          pyUnits: Random().nextInt(10),
          laps: Random().nextInt(100),
          maxLaps: Random().nextInt(100));

      if (inputData.laps >= inputData.maxLaps) {
        inputData.laps = inputData.maxLaps;
      }

      OutputData outputData = OutputData(
          outputText: 'Corrected Time (seconds)',
          correctedTime: calcCorrectedTime(inputData: inputData),
          helpButton: null);

      await setAndCheck(
        driver: driver,
        inputData: inputData,
        outputData: outputData,
      );
    }, timeout: new Timeout.factor(10));
  });
}

Future<void> setAndCheck({
  @required FlutterDriver driver,
  @required InputData inputData,
  @required OutputData outputData,
}) async {
  print('test params '
      '${inputData.timeHours}'
      '${inputData.timeMinutes}'
      '${inputData.timeSeconds} '
      '${inputData.pyThousands}'
      '${inputData.pyHundreds}'
      '${inputData.pyTens}'
      '${inputData.pyUnits} '
      '${inputData.laps} '
      '${inputData.maxLaps} '
      '${outputData.outputText} '
      '${outputData.correctedTime} '
      '${outputData.helpButton}');

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

  //reset wheels first

  print('Resetting wheels');

  for (var i in list) {
    await driver.scrollUntilVisible(
      find.byValueKey('${i.first}Picker'),
      find.byValueKey('${i.first}0'),
      dyScroll: 30.0,
    );
  }

  print('Setting values');

  for (var i in list) {
    await driver.scrollUntilVisible(
      find.byValueKey('${i.first}Picker'),
      find.byValueKey('${i.first}${i.last}'),
      dyScroll: -30.0,
    );
  }

  print('Expected output text:${outputData.outputText}');
  //print('Actual output text:${}');

  print('Expected corrected time:${outputData.correctedTime}');
  print('Expected help button:${outputData.helpButton}');

  expect(await driver.getText(find.byValueKey('outputText')),
      outputData.outputText);

  if (outputData.helpButton != null) {
    expect(await driver.getText(find.byValueKey('helpButton')),
        outputData.helpButton);
  }
  if (outputData.correctedTime != null) {
    expect(await driver.getText(find.byValueKey('correctedTime')),
        outputData.correctedTime);
  }
}

String calcCorrectedTime({@required InputData inputData}) {
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
      {@required this.timeHours,
      @required this.timeMinutes,
      @required this.timeSeconds,
      @required this.pyThousands,
      @required this.pyHundreds,
      @required this.pyTens,
      @required this.pyUnits,
      @required this.laps,
      @required this.maxLaps});
}

class OutputData {
  String outputText;
  String correctedTime;
  String helpButton;

  OutputData(
      {@required this.outputText,
      @required this.correctedTime,
      @required this.helpButton});
}
