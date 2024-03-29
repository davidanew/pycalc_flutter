import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pycalc_flutter/controller.dart';
import 'package:pycalc_flutter/constants.dart';
import 'package:pycalc_flutter/statics.dart';
import 'package:pycalc_flutter/picker_container.dart';
import 'package:flutter/services.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//void main() => runApp(MyApp());

void main() {
  //Only run in portrait as rotation does not redraw correctly
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Controller does calculations and holds picker data
    final Controller controller = Controller();
    //Provide controller for stream builders
    return Provider<Controller>(
      builder: (context) => controller,
      child: MaterialApp(
        title: 'pyCalc',
        home: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: MainScreen(),
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //This class calculates various dimensions and sizes
    SizeConfig().init(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //All Pickers and their labels
          Expanded(
            flex: 27,
            child: Container(
              child: Row(
                children: <Widget>[
                  //Elapsed time and PY
                  Expanded(
                    flex: 17,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElapsedTimeLabelAndPicker(),
                          PYLabelAndPicker(),
                        ],
                      ),
                    ),
                  ),
                  //Laps and max laps
                  Expanded(
                    flex: 10,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          LapsLabelAndPicker(),
                          MaxLapsLabelAndPicker()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //output label and value (one card)
          new OutputLabelAndValue(),
        ],
      ),
    );
  }
}

class ElapsedTimeLabelAndPicker extends StatelessWidget {
  const ElapsedTimeLabelAndPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(SizeConfig.margin),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radius),
          color: kCardColor,
        ),
        child: Column(
          children: <Widget>[
            //Elapsed time label
            Expanded(
              child: Center(
                child: Text(
                  'Elapsed Time (H:M:S)',
                  style: TextStyle(fontSize: SizeConfig.inputTextSize),
                ),
              ),
            ),
            //Elapsed time pickers
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //Hours picker
                    Expanded(
                      child: PickerContainer(
                        contents:
                            Provider.of<Controller>(context).timeHoursPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .timeHoursIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('timeHoursPicker'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.spacing),
                    //Minutes picker
                    Expanded(
                      child: PickerContainer(
                        contents:
                            Provider.of<Controller>(context).timeMinutesPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .timeMinutesIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('timeMinutesPicker'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.spacing),
                    //Seconds picker
                    Expanded(
                      child: PickerContainer(
                        contents:
                            Provider.of<Controller>(context).timeSecondsPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .timeSecondsIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('timeSecondsPicker'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PYLabelAndPicker extends StatelessWidget {
  const PYLabelAndPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(SizeConfig.margin),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radius),
          color: kCardColor,
        ),
        child: Column(
          children: <Widget>[
            //PY Label
            Expanded(
                child: Center(
                    child: Text('Handcap (PY)',
                        style: TextStyle(fontSize: SizeConfig.inputTextSize)))),
            //PY Pickers
            Expanded(
              flex: 4,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //PY thousands picker
                    Expanded(
                      child: PickerContainer(
                        contents:
                            Provider.of<Controller>(context).pyThousandsPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .pyThousandsIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('pyThousandsPicker'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.spacing),
                    //PY hundreds picker
                    Expanded(
                      child: PickerContainer(
                        contents:
                            Provider.of<Controller>(context).pyHundredsPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .pyHundredsIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('pyHundredsPicker'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.spacing),
                    //PY tens picker
                    Expanded(
                      child: PickerContainer(
                        contents: Provider.of<Controller>(context).pyTensPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .pyTensIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('pyTensPicker'),
                      ),
                    ),
                    SizedBox(width: SizeConfig.spacing),
                    //PY units picker
                    Expanded(
                      child: PickerContainer(
                        contents:
                            Provider.of<Controller>(context).pyUnitsPicker,
                        onSelectedItemChanged: (i) {
                          Provider.of<Controller>(context)
                              .pyUnitsIndexSubject
                              .add(i);
                        },
                        pickerKey: Key('pyUnitsPicker'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LapsLabelAndPicker extends StatelessWidget {
  const LapsLabelAndPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(SizeConfig.margin),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radius),
          color: kCardColor,
        ),
        child: Column(
          children: <Widget>[
            //Laps Label
            Expanded(
                child: Center(
                    child: Text('Laps',
                        style: TextStyle(fontSize: SizeConfig.inputTextSize)))),
            //Laps picker
            Expanded(
              flex: 4,
              child: PickerContainer(
                contents: Provider.of<Controller>(context).lapsPicker,
                onSelectedItemChanged: (i) {
                  Provider.of<Controller>(context).lapsIndexSubject.add(i);
                },
                pickerKey: Key('lapsPicker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaxLapsLabelAndPicker extends StatelessWidget {
  const MaxLapsLabelAndPicker({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(SizeConfig.margin),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radius),
          color: kCardColor,
        ),
        child: Column(
          children: <Widget>[
            //max laps Label
            Expanded(
                child: Center(
                    child: Text('Max Laps',
                        style: TextStyle(fontSize: SizeConfig.inputTextSize)))),
            //Max laps picker
            Expanded(
              flex: 4,
              child: PickerContainer(
                contents: Provider.of<Controller>(context).maxLapsPicker,
                onSelectedItemChanged: (i) {
                  Provider.of<Controller>(context).maxLapsIndexSubject.add(i);
                },
                pickerKey: Key('maxLapsPicker'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OutputLabelAndValue extends StatelessWidget {
  const OutputLabelAndValue({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Container(
        margin: EdgeInsets.all(SizeConfig.margin),
        padding: EdgeInsets.all(SizeConfig.padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SizeConfig.radius),
          color: kCardColor,
        ),
        child: Column(
          children: <Widget>[
            //Output label
            Expanded(
              child: Center(
                child: StreamBuilder<String>(
                  stream: Provider.of<Controller>(context).outputLabel,
                  initialData: '',
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: SizeConfig.labelTextSize),
                      key: Key('outputText'),
                    );
                  },
                ),
              ),
            ),
            //Output value
            Expanded(
              child: Center(
                child: StreamBuilder<String>(
                    stream:
                        Provider.of<Controller>(context).correctedTimeString,
                    initialData: '',
                    builder: (context, snapshot) {
                      //If there is no corrected time data then display a help button
                      return LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (snapshot.data == '') {
                            return FlatButton(
                              padding: EdgeInsets.all(2),
                              textColor: Colors.white,
                              color: kBackgroundColor,
                              child: Text(
                                'Help',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.outputTextSize,
                                ),
                                key: Key('helpButton'),
                              ),
                              onPressed: () {
                                helpAlert(context);
                              },
                            );
                          } else {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  fontSize: SizeConfig.outputTextSize),
                              key: Key('correctedTime'),
                            );
                          }
                        },
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void helpAlert(BuildContext context) {
  Alert(
    context: context,
    title: 'INSTRUCTIONS',
    content: Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: '\nElapsed Time\n\n',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Time for the competitor to complete all laps.\n\n'),
          TextSpan(
              text: 'Handicap (PY)\n\n',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Portsmouth Yardstick handicap.\n\n'),
          TextSpan(
              text: 'Laps\n\n', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: 'Number of laps this competitor completed.\n\n'),
          TextSpan(
              text: 'Max Laps\n\n',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  'The maximum number of laps that any competitor completed.'),
        ],
      ),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 17),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
