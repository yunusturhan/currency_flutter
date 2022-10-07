import 'dart:convert';

import 'package:biletinial_doviz/models/gold_price.dart';
import 'package:biletinial_doviz/models/silver_price.dart';
import 'package:biletinial_doviz/pages/gold_page/gold_list_page.dart';
import 'package:biletinial_doviz/pages/silver_list_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SilverScreen extends StatefulWidget {
  const SilverScreen({Key? key}) : super(key: key);

  @override
  State<SilverScreen> createState() => _SilverScreenState();
}

Map<String, String> header = {
  "authorization": "apikey your-apikey",
  "content-type": "application/json",
};

class _SilverScreenState extends State<SilverScreen> {

  Future<SilverPrice> fetchPricesSilver() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/economy/silverPrice'),
        headers: header);

    if (response.statusCode == 200) {
      var elem = SilverPrice.fromJson(jsonDecode(response.body));

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
          Text("Silver",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
          Expanded(
            child: FutureBuilder<SilverPrice>(
              future: fetchPricesSilver(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'An error has occurred!',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return SilverListPage(data: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          SizedBox(width: 10,height: 30,),
        ],
      ),),
    );
  }
}
