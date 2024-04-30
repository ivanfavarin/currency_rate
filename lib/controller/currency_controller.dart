import 'package:flutter/material.dart';
import 'package:open_reply_proj/model/currency.dart';
import 'package:provider/provider.dart';

class CurrencyController {
  ConversionRate? currentCurrency;

  void onCurrencyChange(ConversionRate newCurrency, BuildContext context) {
    currentCurrency = newCurrency;

    List<ConversionRate> newCurrencyValues =
        context.read<CurrencyResponse>().conversionRates;
    for (var currency in newCurrencyValues) {
      currency.value = (1 / newCurrency.valueInDollar) * currency.valueInDollar;
    }
    context
        .read<CurrencyResponse>()
        .changeConversionRates(rates: newCurrencyValues);
  }

  Future<void> loadRates(BuildContext context) async {
    context
        .read<CurrencyResponse>()
        .loadRates()
        .then((value) => currentCurrency = value);
  }
}
