import 'package:biletinial_doviz/models/basket_model.dart';
import 'package:biletinial_doviz/models/currency_price.dart';
import 'package:biletinial_doviz/models/gold_price.dart';
import 'package:biletinial_doviz/models/silver_price.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
class SilverListPage extends StatefulWidget {

  SilverListPage({Key? key,required this.data}) : super(key: key);
  final SilverPrice data;
  @override
  State<SilverListPage> createState() => _SilverListPageState();
}

class _SilverListPageState extends State<SilverListPage> {

  String secilenBirim="USD";
  double secilenBirimFiyati=0;

  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.result!.length,
        itemBuilder: (context, index) {
          return Container(
              width: 163,
              height: 75,
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromRGBO(26, 56, 72, 1)),
              child: Center(
                  child: Column(
                    children: [
                      Text(
                        "${widget.data.result![index].currency}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans"),
                      ),
                      if (widget.data.result![index].currency != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "1 ${widget.data.result![index].currency} - ${widget.data.result![index].buying} ₺",
                              style: const TextStyle(
                                  color: Color.fromRGBO(255, 50, 75, 1),
                                  fontFamily: "DM Sans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal),
                            ),
                            InkWell(
                                child: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                      color: Color.fromRGBO(35, 170, 73, 1)),
                                  child: InkWell(
                                    child: Center(
                                        child: const Icon(Icons.add,
                                            color: Colors.white, size: 16)),

                                  ),
                                ),onTap: () async {
                              secilenBirim=widget.data.result![index].currency!;
                              secilenBirimFiyati=widget.data.result![index].buying!;
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
                                color: Colors.red, size: 32),
                            Text(
                              "This product is out of stock.",
                              style: TextStyle(color: Colors.white),
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
            title: Text('Enter the number of products'),
            content: TextField(
              onChanged: (value) {
              },
              controller: _textFieldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter the number of products:"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('ADD'),
                onPressed: ()async {
                  if(_textFieldController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Item cannot be left blank!");
                  }
                  else if(int.parse(_textFieldController.text)<1){
                    Fluttertoast.showToast(msg: "You entered the wrong number!");
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
                    Fluttertoast.showToast(msg: "Selected product added to basket");
                    Navigator.pop(context);
                  }
                },
              ),

            ],
          );
        });
  }



}
