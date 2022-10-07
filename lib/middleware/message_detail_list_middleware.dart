import 'package:biletinial_doviz/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class GlobalMiddleware extends GetMiddleware {
  final messageController = Get.find<MessageController>();

  @override
  Widget onPageBuilt(Widget page) {
    // messageController.scrollDown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      messageController.scrollDown();
    });
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}