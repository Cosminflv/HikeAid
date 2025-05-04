import 'dart:async';

class OneToManyStream<T> {
  final Stream<T> _inputStream;
  final List<StreamController<T>> _outputControllers = [];

  OneToManyStream(Stream<T> inputStream) : _inputStream = inputStream {
    _inputStream.listen((event) {
      for (final outStreamController in _outputControllers) {
        outStreamController.add(event);
      }
    });
  }

  Stream<T> createNewStream() {
    final controller = StreamController<T>();
    controller.onCancel = () {
      _outputControllers.remove(controller);
    };

    _outputControllers.add(controller);

    return controller.stream;
  }
}
