import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/currency_controller.dart';
import 'package:sizer/sizer.dart';
import '../../translation/strings.dart';
import 'currency_list_page.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}


class _CurrencyScreenState extends State<CurrencyScreen> {

  CurrencyController controller = Get.put(CurrencyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.transparent,
      body: Center(child:
        Obx(() => Column(
          children: [
            Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.grey,
                child: Text(Strings().currency.tr.toUpperCase(),style: TextStyle(fontSize: 24.sp,fontWeight: FontWeight.bold))),
            Expanded(
              child: controller.currencyPrices.value.result != null ? CurrencyListPage(data: controller.currencyPrices.value) : Container(height: 5.h,width: 5.w,child: CircularProgressIndicator())
            ),
          ],
        ),)),
    );
  }
}
