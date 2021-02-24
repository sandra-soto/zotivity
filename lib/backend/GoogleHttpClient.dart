// source: https://stackoverflow.com/questions/48477625/how-to-use-google-api-in-flutter/48485898#48485898
import 'package:http/io_client.dart';
import 'package:http/http.dart';

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));

}