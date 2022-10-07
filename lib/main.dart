import 'package:biletinial_doviz/controller/language_controller.dart';
import 'package:biletinial_doviz/controller/message_controller.dart';
import 'package:biletinial_doviz/models/language.dart';
import 'package:biletinial_doviz/pages/home_page.dart';
import 'package:biletinial_doviz/pages/login_page.dart';
import 'package:biletinial_doviz/pages/message_pages/message_detail_page.dart';
import 'package:biletinial_doviz/translation/locale_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'auth_controller.dart';
import 'constants.dart';
import 'middleware/message_detail_list_middleware.dart';
import 'models/basket_model.dart';
import 'package:sizer/sizer.dart';

import 'pages/message_pages/message_detail_list.dart';

void main()async {
  Get.testMode=true;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketAdapter());
  Hive.registerAdapter(LanguageAdapter());
  await Hive.openBox("Basket");
  await Hive.openBox("Language");
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });

  LanguageController languageController=Get.put(LanguageController());
  Get.put(MessageController());
  Locale? locale;
  locale=languageController.boxLocale();
  print(locale);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    locale: locale??Get.deviceLocale,
    translations: LocaleString(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    getPages: [
      GetPage(
        name: '/messageDetail',
        page: () => MessageDetailPage(),
        middlewares: [GlobalMiddleware()],
      ),
    ],
    home: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  AuthController controllerAuth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {

    return  Sizer(builder: (context, orientation, deviceType){
      return (controllerAuth.firebaseUser.value?.email==null) ? Get.put(Login()) :Get.put(HomePage());
    });
  }
}
