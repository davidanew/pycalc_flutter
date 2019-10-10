import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pycalc_flutter/controller.dart';
import 'package:pycalc_flutter/constants.dart';
import 'package:pycalc_flutter/picker_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller controller = Controller();

    return Provider<Controller>(
      builder: (context) => controller,
      child: MaterialApp(
        title: 'pyCalc Flutter',
        home: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SafeArea(
            child: new Experiment(),
          ),
        ),
      ),
    );
  }
}

class Experiment extends StatelessWidget {
  const Experiment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // Contains everything
        children: <Widget>[
          //All pickers
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
                          //elapsed time label and picker
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kMarginFraction),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width *
                                        kRadiusFraction),
                                color: kCardColor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Elapsed time label
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        'Elapsed Time (H:M:S)',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                kInputTextFraction),
                                      ),
                                    ),
                                  ),
                                  //Elapsed time pickers
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          //Hours picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To9,
                                              onSelectedItemChanged: (i) {
                                                print(MediaQuery.of(context)
                                                    .size
                                                    .width);
                                                Provider.of<Controller>(context)
                                                    .timeHoursIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          //Minutes picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To59,
                                              onSelectedItemChanged: (i) {
                                                Provider.of<Controller>(context)
                                                    .timeMinutesIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          //Seconds picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To59,
                                              onSelectedItemChanged: (i) {
                                                Provider.of<Controller>(context)
                                                    .timeSecondsIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //MARK: PY label and picker
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kMarginFraction),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kPaddingFraction),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width *
                                        kRadiusFraction),
                                color: kCardColor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  //PY Label
                                  Expanded(
                                      child: Center(
                                          child: Text('Handcap (PY)',
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      kInputTextFraction)))),
                                  //PY Pickers
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          //PY thousands picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To9,
                                              onSelectedItemChanged: (i) {
                                                Provider.of<Controller>(context)
                                                    .pyThousandsIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          //PY hundreds picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To9,
                                              onSelectedItemChanged: (i) {
                                                Provider.of<Controller>(context)
                                                    .pyHundredsIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          //PY tens picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To9,
                                              onSelectedItemChanged: (i) {
                                                Provider.of<Controller>(context)
                                                    .pyTensIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          //PY units picker
                                          Expanded(
                                            child: PickerContainer(
                                              contents: Provider.of<Controller>(
                                                      context)
                                                  .picker0To9,
                                              onSelectedItemChanged: (i) {
                                                Provider.of<Controller>(context)
                                                    .pyUnitsIndexSubject
                                                    .add(i);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                          //Laps label and picker
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kMarginFraction),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kPaddingFraction),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width *
                                        kRadiusFraction),
                                color: kCardColor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Laps Label
                                  Expanded(
                                      child: Center(
                                          child: Text('Laps',
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      kInputTextFraction)))),
                                  //Laps picker
                                  Expanded(
                                    flex: 4,
                                    child: PickerContainer(
                                        contents:
                                            Provider.of<Controller>(context)
                                                .picker0To99,
                                        onSelectedItemChanged: (i) {
                                          Provider.of<Controller>(context)
                                              .lapsIndexSubject
                                              .add(i);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Max laps label and picker
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kMarginFraction),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width *
                                      kPaddingFraction),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width *
                                        kRadiusFraction),
                                color: kCardColor,
                              ),
                              child: Column(
                                children: <Widget>[
                                  //max laps Label
                                  Expanded(
                                      child: Center(
                                          child: Text('Max Laps',
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      kInputTextFraction)))),
                                  //Max laps picker
                                  Expanded(
                                    flex: 4,
                                    child: PickerContainer(
                                        contents:
                                            Provider.of<Controller>(context)
                                                .picker0To99,
                                        onSelectedItemChanged: (i) {
                                          Provider.of<Controller>(context)
                                              .maxLapsIndexSubject
                                              .add(i);
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //output label and value
          Expanded(
            flex: 10,
            child: Container(
              margin: EdgeInsets.all(
                  MediaQuery.of(context).size.width * kMarginFraction),
              padding: EdgeInsets.all(
                  MediaQuery.of(context).size.width * kPaddingFraction),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * kRadiusFraction),
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
                            style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width *
                                    kLabelTextFraction),
                          );
                        },
                      ),
                    ),
                  ),
                  //Output value
                  Expanded(
                    child: Center(
                      child: StreamBuilder<String>(
                          stream: Provider.of<Controller>(context)
                              .correctedTimeString,
                          initialData: '',
                          builder: (context, snapshot) {
                            return Text(
                              snapshot.data,
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width *
                                      kOutputTextFraction),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
