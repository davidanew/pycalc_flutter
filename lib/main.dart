import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'dart:async';
import 'package:pycalc_flutter/controller.dart';

void main() => runApp(MyApp());

const double kMarginFraction = 0.025;
const double kPaddingFraction = 0.025;
const double kSpacingFraction = 0.025;
const double kRadiusFraction = 0.025;
const double kInputTextFraction = 0.05;
const double kLabelTextFraction = 0.075;
const double kOutputTextFraction = 0.1;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  //const test = MediaQuery.of(context).size.width;

  //final String testString = 'test string';

  @override
  Widget build(BuildContext context) {
    //final Controller controller = Controller(MediaQuery.of(context).size.width);
    final Controller controller = Controller(10);
    //print(MediaQuery.of(context).size.width);

    return Provider<Controller>(
      builder: (context) => controller,
      child: MaterialApp(
        title: 'pyCalc Flutter',
        home: Scaffold(
          backgroundColor: Colors.blue,
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
              //color: Colors.red,
              child: Row(
                children: <Widget>[
                  //Elapsed time and PY
                  Expanded(
                    flex: 17,
                    child: Container(
                      //padding: EdgeInsets.only(left: 20, right: 20),
                      //                    color: Colors.lightBlueAccent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
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
                                color: Colors.blue[50],
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Label
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    'Elapsed time',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                kInputTextFraction),
                                  ))),
                                  //Elapsed time
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          //SizedBox(width: 10),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To9,
                                                  onSelectedItemChanged: (i) {
                                                    print(MediaQuery.of(context)
                                                        .size
                                                        .width);
                                                    Provider.of<Controller>(
                                                            context)
                                                        .timeHoursIndexSubject
                                                        .add(i);
                                                  })),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To59,
                                                  onSelectedItemChanged: (i) {
                                                    Provider.of<Controller>(
                                                            context)
                                                        .timeMinutesIndexSubject
                                                        .add(i);
                                                  })),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To59,
                                                  onSelectedItemChanged: (i) {
                                                    Provider.of<Controller>(
                                                            context)
                                                        .timeSecondsIndexSubject
                                                        .add(i);
                                                  })),
                                          //SizedBox(width: 10),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                color: Colors.blue[50],
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Label
                                  Expanded(
                                      child: Center(
                                          child: Text('PY',
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      kInputTextFraction)))),
                                  //PY
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          //SizedBox(width: 10),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To9,
                                                  onSelectedItemChanged: (i) {
                                                    Provider.of<Controller>(
                                                            context)
                                                        .pyThousandsIndexSubject
                                                        .add(i);
                                                  })),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To9,
                                                  onSelectedItemChanged: (i) {
                                                    Provider.of<Controller>(
                                                            context)
                                                        .pyHundredsIndexSubject
                                                        .add(i);
                                                  })),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To9,
                                                  onSelectedItemChanged: (i) {
                                                    Provider.of<Controller>(
                                                            context)
                                                        .pyTensIndexSubject
                                                        .add(i);
                                                  })),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  kSpacingFraction),
                                          Expanded(
                                              child: PickerContainer(
                                                  contents:
                                                      Provider.of<Controller>(
                                                              context)
                                                          .picker0To9,
                                                  onSelectedItemChanged: (i) {
                                                    Provider.of<Controller>(
                                                            context)
                                                        .pyUnitsIndexSubject
                                                        .add(i);
                                                  })),
                                          //SizedBox(width: 10),
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
                      //padding: EdgeInsets.only(left: 20, right: 20),
                      //color: Colors.white,
                      child: Column(
                        children: <Widget>[
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
                                color: Colors.blue[50],
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Label

                                  Expanded(
                                      child: Center(
                                          child: Text('Laps',
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      kInputTextFraction)))),
                                  //Laps

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
                                color: Colors.blue[50],
                              ),
                              child: Column(
                                children: <Widget>[
                                  //Label

                                  Expanded(
                                      child: Center(
                                          child: Text('Max Laps',
                                              style: TextStyle(
                                                  fontSize: MediaQuery.of(
                                                              context)
                                                          .size
                                                          .width *
                                                      kInputTextFraction)))),
                                  //Max laps

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
          //All output
          Expanded(
            flex: 10,
            child: Container(
              margin: EdgeInsets.all(
                  MediaQuery.of(context).size.width * kMarginFraction),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * kRadiusFraction),
                color: Colors.blue[50],
              ),
              //color: Colors.blue,
              child: Column(
                children: <Widget>[
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
                          }),
                    ),
                  ),
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

class PickerContainer extends StatelessWidget {
  final void Function(int) onSelectedItemChanged;
  final List<Widget> contents;

  PickerContainer(
      {@required this.contents, @required this.onSelectedItemChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(
//        borderRadius: BorderRadius.circular(10.0),
//        color: Colors.blue[50],
//      ),
      //color: Colors.white,
      child: LayoutBuilder(builder: (context, constraint) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            //brightness: Brightness.dark,
            //primaryColor: Colors.green,
            //primaryContrastingColor: Colors.red,
            //barBackgroundColor: Colors.purple,
            //scaffoldBackgroundColor: Colors.teal,
            textTheme: CupertinoTextThemeData(
                pickerTextStyle: TextStyle(
              // foreground: Paint(),

              //backgroundColor: Colors.blue.shade900,
              //decorationColor: Colors.green,
              fontSize: constraint.maxHeight * 0.18,
              color: Colors.black,
              textBaseline: TextBaseline.alphabetic,
            )
                // height: constraint.maxHeight * 1.2),
                ),
          ),
          child: CupertinoPicker(
            magnification: 1.5,
            useMagnifier: true,
            //backgroundColor: Color(0xFF0000FF),
            backgroundColor: Colors.blue[50],

            itemExtent: constraint.maxHeight * 0.20,
            onSelectedItemChanged: (i) {
//              Provider.of<Controller>(context).setMaxLaps(i);
              onSelectedItemChanged(i);
            },
            children: contents,
          ),
        );
      }),
    );
  }
}
