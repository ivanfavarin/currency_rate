import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_reply_proj/http/base.dart';
import 'package:open_reply_proj/model/currency.dart';

const String currencyUrl = "/latest/USD";

class CurrencyWebClient {
  Future<List<ConversionRate>> getCurrencies() async {
    var requestUrl = "${Base().baseUrl}$currencyUrl";
    var request = http.Request('GET', Uri.parse(requestUrl));

    var response = await Base.executeRequest(request);

    if (response.statusCode == 200) {
      return await response.stream
          .bytesToString()
          .then((value) => json.decode(value))
          .then((value) => CurrencyResponse().getFromJson(value));
    }
    return <ConversionRate>[];
  }
}
