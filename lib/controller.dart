//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class Controller {
  String testString = 'Test string';

//  final _correctedTimeController = StreamController<String>();
//  StreamSink get _correctedTimePublisher => _correctedTimeController.sink;
//  Stream<String> get correctedTimeOutput => _correctedTimeController.stream;

  List<Text> picker0To9 =
      Iterable<int>.generate(10).map<Text>((i) => Text(i.toString())).toList();

  //Stream<String> stream1;
  //Stream<String> stream2;

  var lapsIndexSubject = new PublishSubject<int>();
  var maxLapsIndexSubject = new PublishSubject<int>();
  Observable<String> lapRatioString;

  Controller() {
    lapRatioString = Observable.combineLatest2(
            lapsIndexSubject, maxLapsIndexSubject, (a, b) => a + b)
        .map((item) => item.toString());

    //Stream<String> concat =
    //   Observable.combineLatest2(stream1, stream2, (a, b) => a + b);
  }

//  void setLaps(int i) {
////    _correctedTimePublisher.add(i.toString());
//    lapsSubject.add(i.toString());
//  }
//
//  void setMaxLaps(int i) {
////    _correctedTimePublisher.add(i.toString());
//    maxLapsSubject.add(i.toString());
//  }

  void dispose() {
//    _correctedTimeController.close();
    maxLapsIndexSubject.close();
    lapsIndexSubject.close();
  }
}
