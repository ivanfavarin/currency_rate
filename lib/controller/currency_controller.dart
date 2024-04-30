import 'package:flutter/material.dart';
import 'package:open_reply_proj/model/currency.dart';
import 'package:provider/provider.dart';

class CurrencyController {
  ConversionRate? currentCurrency;

  void onCurrencyChange(ConversionRate newCurrency, BuildContext context) {
    currentCurrency = newCurrency;

    List<ConversionRate> newCurrencyValues =
        context.read<Currency>().conversionRates;
    for (var currency in newCurrencyValues) {
      currency.value = (1 / newCurrency.valueInDollar) * currency.valueInDollar;
    }
    context.read<Currency>().changeConversionRates(rates: newCurrencyValues);
  }

  Future<void> loadRates(BuildContext context) async {
    context
        .read<Currency>()
        .loadRates()
        .then((value) => currentCurrency = value);
  }
}
