import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Constants {
  static final List<Text> testList = [
    Text('1'),
    Text('2'),
    Text('3'),
  ];
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final List<Text> testList = [
    Text('1'),
    Text('2'),
    Text('3'),
  ];

  final String testString = 'test string';

  //Provider.of<String>(context)

  @override
  Widget build(BuildContext context) {
    return Provider<String>(
      builder: (context) => 'pyCalc Flutter',
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
        // Contains everything
        children: <Widget>[
          Expanded(
            //Pickers here
            flex: 2,
            child: Container(
              color: Colors.red,
              child: Row(
                children: <Widget>[
                  Expanded(
                    //Elapsed time and PY
                    flex: 2,
                    child: Container(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  Expanded(
                    //Laps and max laps
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            //Max laps
                            child: Container(
                              color: Colors.black,
                              child: CupertinoPicker(
                                itemExtent: 32,
                                onSelectedItemChanged: (i) {
                                  print(Provider.of<String>(context));
                                },
                                children: Constants.testList,
                              ),
                            ),
                          ),
                          Expanded(
                            //Max laps
                            child: Container(
                              color: Colors.green,
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
          Expanded(
            //Output here
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
