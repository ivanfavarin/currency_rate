import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_reply_proj/http/base.dart';
import 'package:open_reply_proj/model/currency.dart';

const String currencyUrl = "/latest/USD";

class CurrencyWebClient {
  List<ConversionRate> rates = <ConversionRate>[];

  Future<List<ConversionRate>> getCurrencies() async {
    await Future.delayed(Duration(seconds: 10));
    var requestUrl = "${Base().baseUrl}$currencyUrl";
    var request = http.Request('GET', Uri.parse(requestUrl));

    var response = await Base.executeRequest(request);

    if (response.statusCode == 200) {
      var jsonValue = await response.stream
          .bytesToString()
          .then((value) => json.decode(value));

      return Currency().getFromJson(jsonValue);
    }
    return <ConversionRate>[];
  }
}
