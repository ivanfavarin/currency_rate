// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:open_reply_proj/controller/currency_controller.dart';
import 'package:open_reply_proj/model/currency.dart';
import 'package:provider/provider.dart';

class CurrencyView extends StatefulWidget {
  static const routeName = '/';
  const CurrencyView({super.key});

  @override
  State<CurrencyView> createState() => _CurrencyViewState();
}

class _CurrencyViewState extends State<CurrencyView> {
  final CurrencyController _controller = CurrencyController();

  @override
  Widget build(BuildContext context) {
    //load the rates automatically if haven´t already
    if (context.read<Currency>().conversionRates.isEmpty) {
      _controller.loadRates(context);
    }

    return Consumer<Currency>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Currency Rates',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              currencyDropdown(value.conversionRates),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: currencyList(value.conversionRates),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget currencyList(List<ConversionRate> conversionRates) {
    return ListView.builder(
      itemCount: conversionRates.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          conversionRates[index].getFormatedValue(),
        ),
      ),
    );
  }

  Widget currencyDropdown(List<ConversionRate> conversionRates) {
    return DropdownButton<ConversionRate>(
      items: conversionRates
          .map((currency) => DropdownMenuItem<ConversionRate>(
                child: Text(currency.currency),
                value: currency,
              ))
          .toList(),
      onChanged: (value) => _controller.onCurrencyChange(value!, context),
      value: _controller.currentCurrency,
    );
  }
}
