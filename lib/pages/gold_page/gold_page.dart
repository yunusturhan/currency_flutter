import 'dart:convert';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import '../../models/gold_price.dart';
import '../../translation/strings.dart';
import 'gold_list_page.dart';
import 'package:sizer/sizer.dart';

class GoldScreen extends StatefulWidget {
  const GoldScreen({Key? key}) : super(key: key);

  @override
  State<GoldScreen> createState() => _GoldScreenState();
}

Map<String, String> header = {
  "authorization": "apikey your-apikey",
  "content-type": "application/json",
};


class _GoldScreenState extends State<GoldScreen> {
  Future<GoldPrice> fetchPricesGold() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/economy/goldPrice'),
        headers: header);

    if (response.statusCode == 200) {
      var elem = GoldPrice.fromJson(jsonDecode(response.body));

      return elem;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
      body: Center(child:
      Column(
        children: [
          Shimmer.fromColors(
              baseColor: Colors.black,
              highlightColor: Colors.grey,
              child: Text(Strings().gold.tr,style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold))),
          Expanded(
            child: FutureBuilder<GoldPrice>(
              future: fetchPricesGold(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return  Center(
                    child: Text(
                      Strings().anErrorHasOccurred.tr,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return GoldListPage(data: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),),
    );
  }
}
