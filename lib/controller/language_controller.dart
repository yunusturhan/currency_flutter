import 'dart:ui';
import 'package:biletinial_doviz/models/language.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class LanguageController extends GetxController{


  final box =Hive.box("Language");

  RxString code="tr".obs;
  RxString country="TR".obs;

  final RxList locale =[

    {'name':'TÜRKÇE','locale_code':'tr','locale_country':'TR'},
    {'name':'ENGLISH','locale_code':'en','locale_country':'US'},

  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  updateLanguage(Locale locale) async{
    await Get.updateLocale(locale);
    Get.back();

  }

  Locale? boxLocale(){
   if(box.isNotEmpty) {
     return Locale(box.values.elementAt(0).code ?? "en",box.values.elementAt(0).country ?? "US");
   }
   else {
     return null;
   }
  }
  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){


                        if(box.isNotEmpty) {
                          box.put(0, Language(name: locale[index]["name"], code: locale[index]['locale_code'], country: locale[index]['locale_country']));
                        }
                        else {
                          box.add(Language(name: locale[index]["name"], code: locale[index]['locale_code'], country: locale[index]['locale_country']));
                        }

                        updateLanguage(Locale(locale[index]['locale_code'],locale[index]['locale_country']));
                        boxLocale();
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Colors.blue,
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }

}