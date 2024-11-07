// custom_http_client.dart
// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class TimeoutHttpClient extends http.BaseClient {
  final Duration timeout;
  final http.Client _client;

  TimeoutHttpClient({required this.timeout}) : _client = IOClient();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request).timeout(timeout);
  }
}
