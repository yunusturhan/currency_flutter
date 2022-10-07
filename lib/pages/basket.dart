import 'package:biletinial_doviz/controller/basket_controller.dart';
import 'package:biletinial_doviz/controller/firebase_save_controller.dart';
import 'package:biletinial_doviz/pages/history_page.dart';
import 'package:biletinial_doviz/translation/strings.dart';
import 'package:biletinial_doviz/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth_controller.dart';
import '../models/basket_model.dart';
import 'package:sizer/sizer.dart';
class BasketPage extends StatelessWidget {
   BasketPage({Key? key}) : super(key: key);

  FirebaseSaveController controllerFirebase = Get.find(tag : "FirebaseSaveController");
  AuthController controllerAuth = Get.put(AuthController());
  BasketController controllerBasket= Get.put(BasketController());

  @override
  void initState() {
    // TODO: implement initState

    basketTotalPrice=0;
    double totalPrice=0;
    for(Basket elem in controllerBasket.basketList){
      totalPrice += elem.piece * elem.unit_price;
    }
      basketTotalPrice+=totalPrice;

  }


  @override
  Widget build(BuildContext context) {
    return Obx(() =>  Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 2.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Image.asset(
                    "assets/images/back_button.png",
                    height: 3.h,
                    width: 3.w,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                 Text(
                   Strings().basket.tr,
                  style: TextStyle(fontSize: 20.sp, fontFamily: "DM Sans"),
                ),
                ElevatedButton.icon(onPressed: (){
                  Get.to(()=>HistoryPage());
                }, icon:Icon(FontAwesomeIcons.clockRotateLeft,size: 3.h,), label: Text(Strings().history.tr,style: TextStyle(fontSize: 16.sp),),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.black)),),
              ],
            ), //Üst panel


            Expanded(
              child: ListView.builder(itemCount: controllerBasket.basketList.length,itemBuilder: (context,index){
                return Card(
                  shape:  StadiumBorder(side: BorderSide(
                    color: Colors.white,width: 1.w,
                  )),
                  color: const Color.fromRGBO(26, 56, 72, 1),
                  child: ListTile(
                    title: Center(child: Text(controllerBasket.basketList.elementAt(index).type,style: TextStyle(color: Colors.white,fontSize: 16.sp))),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${Strings().unitPrice.tr}: ${controllerBasket.basketList.elementAt(index).unit_price}  PCS ${Strings().piece.tr}: ${controllerBasket.basketList.elementAt(index).piece}",style: TextStyle(color: Colors.white,fontSize: 12.sp)),
                        Text("${Strings().totalPrice.tr} : ${controllerBasket.basketList.toList()[index].unit_price * controllerBasket.basketList.toList()[index].piece}",style: TextStyle(color: Colors.white,fontSize: 12.sp))
                      ],
                    ),
                    trailing: ElevatedButton(child: Text(Strings().delete.tr,style: TextStyle(color: Colors.white,fontSize: 12.sp)),onPressed: (){

                      _displayDialog(context,index);
                    }),
                  ),
                );

              }),

            ),
            Container(
              padding: const EdgeInsets.all(10),
              height:15.h,
              decoration: const BoxDecoration(
                color: Colors.black,borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(children: [
                Text("${Strings().basketTotal.tr.toUpperCase()}: $basketTotalPrice",style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(onPressed: (){
                        if(controllerBasket.box.isNotEmpty){
                          for(int i=0;i<controllerBasket.box.length;i++){
                            controllerFirebase.BasketHistoryAdd(controllerAuth.firebaseUser.value!.email,controllerBasket.box.values.elementAt(i).type, controllerBasket.box.values.elementAt(i).unit_price, controllerBasket.box.values.elementAt(i).piece);
                          }
                          Get.snackbar(Strings().congratulations.tr,Strings().basketIsSavedInFirebase.tr);
                          controllerBasket.changeBasketList();
                          controllerBasket.box.clear();

                        }
                        else{
                          Fluttertoast.showToast(msg: Strings().youHaveToAddBeforeSavingToDatabase.tr);
                        }

                      }, icon:Icon(FontAwesomeIcons.upload,size: 3.h), label:Text(Strings().saveDatabase.tr,style: TextStyle(color: Colors.white,fontSize: 10.sp)) ,style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green.shade400))),
                      ElevatedButton.icon(onPressed: (){

                        controllerBasket.changeBasketList();
                        Fluttertoast.showToast(msg:Strings().basketIsClear.tr);

                        controllerBasket.box.clear();


                      }, icon:Icon(FontAwesomeIcons.trashCan,size: 3.h,), label:Text(Strings().clearBasket.tr,style: TextStyle(color: Colors.white,fontSize: 10.sp)),style:ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red.shade400))),

                    ],
                  ),
                )
              ],),
            )
          ],
        ),
      ),
      endDrawer: MyDrawer(),
      ));
  }


  ListView list_basket(){
    totalPrice=0;

    int totalPieceLenght;
    return ListView.builder(itemCount: controllerBasket.box.length,itemBuilder: (context,index){

      totalPieceLenght=(controllerBasket.box.values.elementAt(index).piece*controllerBasket.box.values.elementAt(index).unit_price).toString().length;

      return Card(
        shape: StadiumBorder(side: BorderSide(
          color: Colors.white,width: 1.h,
        )),
        color: const Color.fromRGBO(26, 56, 72, 1),
        child: ListTile(
          title: Text("${controllerBasket.box.values.elementAt(index).type}",style: TextStyle(color: Colors.white,fontSize: 16.sp)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${Strings().unitPrice.tr}: ${controllerBasket.box.values.elementAt(index).unit_price}  PCS ${Strings().piece.tr}: ${controllerBasket.box.values.elementAt(index).piece}",style: TextStyle(color: Colors.white,fontSize: 10.sp)),
                  Text("${Strings().totalPrice.tr}: ${(controllerBasket.box.values.elementAt(index).piece*controllerBasket.box.values.elementAt(index).unit_price).toString().substring(0,totalPieceLenght<5? totalPieceLenght:5)}",style: TextStyle(color: Colors.white,fontSize: 10.sp))
            ],
          ),
          trailing: ElevatedButton(child: Text(Strings().delete.tr,style: TextStyle(color: Colors.white,fontSize: 10.sp)),onPressed: (){
            _displayDialog(context,index);


          }),
        ),
      );

    });
  }




  Future<void> _displayDialog(BuildContext context,int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:  Text('Do you really want to delete?',style: TextStyle(color: Colors.white,fontSize: 10.sp)),
            content: Text("Are you sure that this unit you added to the basket will be deleted?",style: TextStyle(color: Colors.white,fontSize: 10.sp)),
            actions: <Widget>[
              ElevatedButton(
                child: Text('YES',style: TextStyle(color: Colors.white,fontSize: 10.sp)),
                onPressed: ()async {
                    basketTotalPrice-=controllerBasket.box.values.toList()[index].unit_price * controllerBasket.box.values.toList()[index].piece;
                    controllerBasket.box.deleteAt(index);

                    controllerBasket.changeBasketList();
                  Fluttertoast.showToast(msg: "Selected product deleted to basket");
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('NO',style: TextStyle(color: Colors.white,fontSize: 10.sp)),
                onPressed: ()async {
                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }



}
double totalPrice=0;
double basketTotalPrice=0;

