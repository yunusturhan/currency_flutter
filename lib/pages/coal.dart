import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:biletinial_doviz/pages/currency_pages/currency.dart';
import 'package:biletinial_doviz/pages/gold_page/gold_page.dart';
import 'package:biletinial_doviz/pages/silver_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class CoalScreen extends StatefulWidget {
  const CoalScreen({Key? key}) : super(key: key);

  @override
  State<CoalScreen> createState() => _CoalScreenState();
}

class _CoalScreenState extends State<CoalScreen> {
  List<Widget> page=[GoldScreen(),SilverScreen()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        body: Column(
          children: <Widget>[

            SizedBox(
              height: 8.h,
              child: Container(
                color: Colors.grey.shade700.withOpacity(.4),
                child: TabBar(
                  indicatorColor: Colors.black,

                  tabs: [
                    Tab(
                      icon: Icon(Icons.toll,color: Colors.yellow.shade800,size: 5.h),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.toll,color: Colors.grey,size: 5.h
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // create widgets for each tab bar here
            Expanded(
              child: TabBarView(
                children: [
                 GoldScreen(),

                 SilverScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
