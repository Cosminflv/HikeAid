import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SSEClient {
  final String url;
  final Map<String, String>? headers;

  SSEClient({required this.url, this.headers});

  Stream<String> subscribe() {
    final controller = StreamController<String>();
    final client = http.Client();

    final request = http.Request('GET', Uri.parse(url));
    if (headers != null) {
      request.headers.addAll(headers!);
    }

    client.send(request).then((response) {
      final stream = response.stream;
      stream.listen(
        (List<int> data) {
          final sseData = utf8.decode(data);
          controller.add(sseData);
        },
        onDone: () => controller.close(),
        onError: (error) => controller.addError(error),
        cancelOnError: true,
      );
    }).catchError((error) {
      controller.addError(error);
      return null;
    });

    controller.onCancel = () {
      client.close();
    };

    return controller.stream;
  }
}
