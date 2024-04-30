import 'package:flutter/material.dart';
import 'package:open_reply_proj/http/webclients/currency_webclient.dart';

class Currency extends ChangeNotifier {
  List<ConversionRate> conversionRates = <ConversionRate>[];

  List<ConversionRate> getFromJson(Map<String, dynamic> json) {
    json['conversion_rates'].forEach((key, value) {
      conversionRates.add(ConversionRate(
        currency: key,
        value: value.toDouble(),
        valueInDollar: value.toDouble(),
      ));
    });

    conversionRates.removeWhere((item) => item.currency == 'ALL');
    conversionRates.sort((a, b) => a.currency.compareTo(b.currency));
    return conversionRates;
  }

  void changeConversionRates({required List<ConversionRate> rates}) {
    conversionRates = rates;
    notifyListeners();
  }

  Future<ConversionRate> loadRates() async {
    conversionRates = await CurrencyWebClient().getCurrencies();
    notifyListeners();
    //return USD as the default currency
    return conversionRates.firstWhere((e) => e.currency == 'USD');
  }
}

class ConversionRate {
  late String currency;
  late double value;
  late double valueInDollar;

  ConversionRate({
    required this.currency,
    required this.value,
    required this.valueInDollar,
  });

  String getFormatedValue() {
    return "$currency - $value";
  }
}
