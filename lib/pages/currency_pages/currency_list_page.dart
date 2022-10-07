import 'package:biletinial_doviz/models/basket_model.dart';
import 'package:biletinial_doviz/models/currency_price.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../../controller/basket_controller.dart';
import '../../translation/strings.dart';
class CurrencyListPage extends StatefulWidget {

  CurrencyListPage({Key? key,required this.data}) : super(key: key);
  final CurrencyPrice data;
  @override
  State<CurrencyListPage> createState() => _CurrencyListPageState();
}

class _CurrencyListPageState extends State<CurrencyListPage> {

  String secilenBirim="USD";
  double secilenBirimFiyati=0;
  BasketController controllerBasket= Get.put(BasketController());

  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.result!.data!.length,
        itemBuilder: (context, index) {
          return Container(
              height: 12.h,
              padding:  EdgeInsets.symmetric(vertical:2.h),

              decoration: BoxDecoration(
                  border: Border.all(width: .5.w, color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromRGBO(26, 56, 72, 1)),
              child: Center(
                  child: Column(
                    children: [
                      Text(
                        "${widget.data.result!.data![index].name}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans"),
                      ),
                      if (widget.data.result!.data![index].rate != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "1 ${widget.data.result!.data![index].code} - ${widget.data.result!.data![index].rate} ₺",
                              style:  TextStyle(
                                  color: Color.fromRGBO(255, 50, 75, 1),
                                  fontFamily: "DM Sans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.normal),
                            ),
                            InkWell(
                                child: Container(
                                  height: 4.h,
                                  width: 10.w,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      color: Color.fromRGBO(35, 170, 73, 1)),
                                  child: InkWell(
                                    child: Center(
                                        child:  Icon(Icons.add,
                                            color: Colors.white, size: 3.h)),

                                  ),
                                ),onTap: () async {
                                  secilenBirim=widget.data.result!.data![index].code!;
                                  secilenBirimFiyati=widget.data.result!.data![index].rate!;
                              _displayTextInputDialog(context);

                            }
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.warning_amber_outlined,
                                color: Colors.red, size: 12.h),
                            Text(
                              Strings().thisProductIsOutOfStock,
                              style: TextStyle(color: Colors.white,fontSize: 16.sp),
                            )
                          ],
                        )
                    ],
                  )));
        });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Strings().enterTheNumberOfProducts.tr,style: TextStyle(fontSize: 16.sp),),
            content: TextField(
              onChanged: (value) {
              },
              controller: _textFieldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText:Strings().enterTheNumberOfProducts.tr),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(Strings().add.tr.toUpperCase(),style: TextStyle(fontSize: 16.sp)),
                onPressed: ()async {
                  if(_textFieldController.text.isEmpty){
                    Fluttertoast.showToast(msg: Strings().itemCannotBeLeftBlank.tr);
                  }
                  else if(int.parse(_textFieldController.text)<1){
                    Fluttertoast.showToast(msg:Strings().youEnteredTheWrongNumber.tr);
                  }
                  else{
                    var box = Hive.box('Basket');
                    var basket=Basket(unit_price: secilenBirimFiyati,piece: double.parse(_textFieldController.text),type: secilenBirim,);
                    bool isAdded = false;
                    for (int i = 0;i<box.values.length;i++) {
                      if(box.values.elementAt(i).type==secilenBirim){
                        box.values.elementAt(i).piece+=double.parse(_textFieldController.text);
                        box.putAt(i,box.values.elementAt(i));
                        isAdded = true;
                      }
                    }

                    if(!isAdded) await box.add(basket);
                    Fluttertoast.showToast(msg: Strings().selectedProductAddedToBasket.tr);
                    Navigator.pop(context);
                  }

                  controllerBasket.changeBasketList();
                },
              ),

            ],
          );
        });
  }



}
