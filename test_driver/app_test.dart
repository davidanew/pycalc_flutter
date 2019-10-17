// Imports the Flutter Driver API.
//import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter App', () {
// First, define the Finders and use them to locate widgets from the
// test suite. Note: the Strings provided to the `byValueKey` method must
// be the same as the Strings we used for the Keys in step 1.
//    final counterTextFinder = find.byValueKey('counter');
//    final buttonFinder = find.byValueKey('increment');
    //final hoursPicker = find.byValueKey('hoursPicker');

    final SerializableFinder hoursPicker = find.byType('CupertinoPicker');

    //Finder hoursPicker = find.byKey(Key('hoursPicker'));

    //String hoursPickerString = hoursPicker.toString();

    //print('Got here !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
    //print('hours picker is $hoursPickerString');

//
    FlutterDriver driver;
//
//// Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });
//
//// Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

//    driver.scrollUntilVisible(
//      find.byValueKey('hoursPicker'),
//      find.byValueKey('testKey'),
//      dyScroll: -300.0,
//    );

    //await driver.tap(hoursPicker);

//
    test('starts at 0', () async {
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
