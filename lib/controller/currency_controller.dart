import 'dart:convert';

import 'package:get/get.dart';

import '../models/currency_price.dart';
import 'package:http/http.dart' as http;

class CurrencyController extends GetxController{

  Map<String, String> header = {
    "authorization": "apikey your-apikey",
    "content-type": "application/json",
  };

  Rx<CurrencyPrice> currencyPrices = CurrencyPrice().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  init() async{
    await fetchPricesCurrency();
  }

  Future<void> fetchPricesCurrency() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/economy/currencyToAll?base=TRY'),
        headers: header);

    if (response.statusCode == 200) {
      currencyPrices.value = CurrencyPrice.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

}