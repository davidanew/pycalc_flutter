//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'dart:async';

class Controller {
  String testString = 'Test string';

  final _correctedTimeController = StreamController<String>();
  StreamSink get _correctedTimePublisher => _correctedTimeController.sink;
  Stream<String> get correctedTimeOutput => _correctedTimeController.stream;

  List<Text> picker0To9 =
      Iterable<int>.generate(10).map<Text>((i) => Text(i.toString())).toList();

  Controller() {}

  void setMaxLaps(int i) {
    _correctedTimePublisher.add(i.toString());
  }

  void dispose() {
    _correctedTimeController.close();
  }
}
