import 'package:biletinial_doviz/models/basket_model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class BasketController extends GetxController{
  final box =Hive.box("Basket");


  RxList<Basket> basketList = <Basket>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   init();
  }
  init(){
    basketList.clear();
    for (int i=0;i<box.length;i++) {
      basketList.add(Basket(type: box.values.elementAt(i).type, unit_price: box.values.elementAt(i).unit_price, piece: box.values.elementAt(i).piece));
    }
    update(basketList);
    print("basketlist büyüklüğü ${basketList.length}");
  }



  deletedBoxItem(int index){

  }


  changeBasketList(){
    init();
    basketList.refresh();
    update(basketList);
  }
}