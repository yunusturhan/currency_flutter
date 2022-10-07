import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:biletinial_doviz/models/basket_model.dart';
import '../auth_controller.dart';
import '../models/history_model.dart';
import '../models/person_model.dart';
import '../models/tarih.dart';

class FirebaseSaveController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AuthController controllerAuth = Get.put(AuthController());
  RxList<BasketHistory> dataList=<BasketHistory>[].obs;
  RxList<Tarih> tarihList= <Tarih>[].obs;
  RxList<Sort> sortList = <Sort>[].obs;
  RxList<Person> personList = <Person>[].obs;


  RxInt currentTab=0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }

  init() async{
    await getBasketHistoryData();
    await getPerson();
  }

  changeTabIndex(int val){
    currentTab.value=val;
  }

  Future<void> getBasketHistoryData() async {
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('History')
          .orderBy("time" , descending: true)
          .where("email", isEqualTo: controllerAuth.firebaseUser.value!.email)
          .get();
      // snapshot.docs.toList().sort((a, b){
      //   a
      //   return data..compareTo(datb[time]);
      //
      // });
      for(var data in snapshot.docs){

        sortList.add(Sort(data["type"],data["piece"]*data["unit_price"]));
        if(sortList.where((element) => element.type==data["type"]).toList().length>1){
          sortList.last.total+=sortList.first.total;
          sortList.remove(sortList.where((element) => element.type == data["type"]).toList().first);
        }

        dataList.add(BasketHistory(data["email"], data["type"], data["unit_price"], data["piece"], data["time"]));
        tarihList.add(Tarih(day: (data["time"] as Timestamp).toDate().day, month: (data["time"] as Timestamp).toDate().month, year: (data["time"] as Timestamp).toDate().year));
        if(tarihList.where((element) => element.day == (data["time"] as Timestamp).toDate().day && element.month == (data["time"] as Timestamp).toDate().month && element.year == (data["time"] as Timestamp).toDate().year ).toList().length > 1) tarihList.remove(tarihList.where((element) => element.day == (data["time"] as Timestamp).toDate().day && element.month == (data["time"] as Timestamp).toDate().month && element.year == (data["time"] as Timestamp).toDate().year).toList().first);

      }

    }catch(e){
      print(e.toString());
    }
  }

  Future<Basket> BasketHistoryAdd(
      String? mail, String? type, double? unit_price, double? piece) async {
    var ref = _firestore.collection("History");
    var documentRef = ref.add({
      "type": type,
      "unit_price": unit_price,
      "piece": piece,
      "time": DateTime.now(),
      "email":controllerAuth.firebaseUser.value!.email
    });
    return Basket(type: type!, unit_price: unit_price!, piece: piece!);
  }

  changeExpension(index,value){
    tarihList[index].expanded = !value;
    tarihList.refresh();
    update(tarihList);
  }













  Future<void> getPerson() async {
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('Person')
          .where('email',isNotEqualTo:controllerAuth.firebaseUser.value!.email )
          .get();

      for(var data in snapshot.docs){

        personList.add(Person(data["name"], data["email"]));

      }

    }catch(e){
      print(e.toString());
    }
  }

}



class Sort{
  String type;
  double total;

  Sort(this.type,this.total);
  @override
  String toString() {
    // TODO: implement toString
    return "{$type,$total}";
  }

}