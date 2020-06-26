import 'dart:async';

import 'package:flutter_carros/utils/simple_bloc.dart';
import 'package:provider/provider.dart';

class Event {}

class EventBus {
  static EventBus get(context) => Provider.of<EventBus>(context, listen: false);

  final _streamController = StreamController<Event>.broadcast();

  Stream<Event> get stream => _streamController.stream.asBroadcastStream();

  sendEvent(Event event) {
    _streamController.add(event);
  }

  dispose() {
    _streamController.close();
  }
}
