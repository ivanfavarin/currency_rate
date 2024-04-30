import 'package:flutter/material.dart';
import 'package:open_reply_proj/model/currency.dart';
import 'package:open_reply_proj/view/home/currency.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrencyResponse(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CurrencyView(),
    );
  }
}
