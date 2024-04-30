import 'package:http/http.dart' as http;

const String apiKey = "83df1af85d7fca7d574007fd";

class Base {
  String baseUrl;

  Base({this.baseUrl = "https://v6.exchangerate-api.com/v6/$apiKey"});

  static Future<http.StreamedResponse> executeRequest(
      http.Request request) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    return response;
  }
}
