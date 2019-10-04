import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'dart:async';
import 'package:pycalc_flutter/controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final String testString = 'test string';

  final Controller controller = Controller();

  @override
  Widget build(BuildContext context) {
    return Provider<Controller>(
      builder: (context) => controller,
      child: MaterialApp(
        title: 'pyCalc Flutter',
        home: SafeArea(
          child: new NewWidget(),
        ),
      ),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
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
            //Pickers here
            flex: 2,
            child: Container(
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  //Elapsed time and PY
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  //Laps and max laps
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          //Laps
                          Expanded(
                            child: pickerContainer(),
                          ),
                          //Max laps
                          Expanded(
                            child: pickerContainer(),
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
            //Output here
            child: Container(
              color: Colors.blue,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StreamBuilder<String>(
                        stream: Provider.of<Controller>(context)
                            .correctedTimeOutput,
                        initialData: '',
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data,
                          );
                        }),
                  ),
                  Expanded(
                    child: Text(
                      'and here',
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

class pickerContainer extends StatelessWidget {
//  const pickerContainer({
////    Key key,
////  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: LayoutBuilder(builder: (context, constraint) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                pickerTextStyle: TextStyle(
              fontSize: constraint.maxHeight * 0.2,
            )
                // height: constraint.maxHeight * 1.2),
                ),
          ),
          child: CupertinoPicker(
            itemExtent: constraint.maxHeight * 0.2,
            onSelectedItemChanged: (i) {
              Provider.of<Controller>(context).setMaxLaps(i);
            },
            children: Provider.of<Controller>(context).picker0To9,
          ),
        );
      }),
    );
  }
}
