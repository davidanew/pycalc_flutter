import 'package:flutter/foundation.dart';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

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

    test('Set All Pickers To 1', () async {
// Use the `driver.getText` method to verify the counter starts at 0.
//      await driver.tap(hoursPicker);
      //expect(await driver.getText(counterTextFinder), "0");

      await Future.delayed(const Duration(seconds: 2), () {});

      await driver.scrollUntilVisible(
        find.byValueKey('timeHoursPicker'),
        find.byValueKey('timeHours1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('timeMinutesPicker'),
        find.byValueKey('timeMinutes1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('timeSecondsPicker'),
        find.byValueKey('timeSeconds1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('pyThousandsPicker'),
        find.byValueKey('pyThousands1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('pyHundredsPicker'),
        find.byValueKey('pyHundreds1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('pyTensPicker'),
        find.byValueKey('pyTens1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('pyUnitsPicker'),
        find.byValueKey('pyUnits1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('lapsPicker'),
        find.byValueKey('laps1'),
        dyScroll: -30.0,
      );

      await driver.scrollUntilVisible(
        find.byValueKey('maxLapsPicker'),
        find.byValueKey('maxLaps1'),
        dyScroll: -30.0,
      );
    });

//    test('Test Procedure', () async {
//      await procedure(driver);
//    });

//    test('Test Set Value', () async {
//      await setTimeValue(
//        driver: driver,
//        timeTuple: Tuple3(2, 2, 2),
//        pyTuple: Tuple4(2, 2, 2, 2),
//        lapsInt: 2,
//        maxLapsInt: 2,
//      );
//    });

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

Future<void> procedure(FlutterDriver driver) async {
  await driver.scrollUntilVisible(
    find.byValueKey('timeHoursPicker'),
    find.byValueKey('timeHours2'),
    dyScroll: -30.0,
  );
}

Future<void> setTimeValue({
  @required FlutterDriver driver,
  @required Tuple3 timeTuple,
  @required Tuple4 pyTuple,
  @required int lapsInt,
  @required int maxLapsInt,
}) async {
  //const timeTuple = const Tuple3<int, int, int>(4, 5, 6);

  var list = [
    ['timeHours', timeTuple.item1],
    ['timeMinutes', timeTuple.item2],
    ['timeSeconds', timeTuple.item3],
    ['pyThousands', timeTuple.item1],
    ['pyHundreds', timeTuple.item1],
    ['pyTens', timeTuple.item1],
    ['pyUnits', timeTuple.item1],
    ['laps', lapsInt],
    ['maxLaps', maxLapsInt],
  ];

  for (var i in list) {
    //   print('Got here XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX');
    await driver.scrollUntilVisible(
      find.byValueKey('${i.first}Picker'),
      find.byValueKey('${i.first}${i.last}'),
      dyScroll: -30.0,
    );
//    await Future.delayed(const Duration(seconds: 2), () {});
  }
}
