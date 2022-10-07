import 'package:biletinial_doviz/controller/message_controller.dart';
import 'package:biletinial_doviz/pages/message_pages/message_list_page.dart';
import 'package:biletinial_doviz/pages/person_list_page.dart';
import 'package:biletinial_doviz/translation/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../controller/firebase_save_controller.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with SingleTickerProviderStateMixin {

  MessageController messageController = Get.put(MessageController());
  late Animation<double> _animation;
  late AnimationController _animationController;
  FirebaseSaveController controllerFirebase = Get.find(tag : "FirebaseSaveController");
  TextEditingController groupNameController=TextEditingController();
  List<bool> isButtonClicked=[];

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),

    );

    final curvedAnimation =
    CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    for(int i=0;i<controllerFirebase.personList.length;i++){
      isButtonClicked.add(false);
    }
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //Init Floating Action Bubble
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          Bubble(
            title:"Yeni Shobet",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.person,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              _startSingleChat(context);
              _animationController.reverse();
            },
          ),
          // Floating action menu item
          Bubble(
            title:"Yeni Grup",
            iconColor :Colors.white,
            bubbleColor : Colors.blue,
            icon:Icons.people,
            titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
            onPress: () {
              messageController.groupList.clear();
              _startGroupChat(context);
              _animationController.reverse();
            },
          ),

        ],
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Flaoting Action button Icon
        iconData: Icons.add_comment,
        backGroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:5.h ,),
          Text("Message",style: TextStyle(fontSize: 16.sp),),
          Expanded(
              child: MessageListPage(),
          ),
        ],
      ),

    );
  }

  Future<void> _startSingleChat(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Obx(() =>  AlertDialog(
            title: Text("Kişi seçin",style: TextStyle(fontSize: 16.sp),),
            content: SizedBox(
              height: 50.h,
              width: 90.w,
              child:ListView.builder(itemCount: controllerFirebase.personList.length,itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    messageController.SingleMessageCreateControl(controllerFirebase.personList[index].email,controllerFirebase.personList[index].name);

                  },
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                        border: Border.all(width: .25.h, color: Colors.grey.shade400),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: const Color.fromRGBO(26, 56, 72, 1)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Text(
                                controllerFirebase.personList[index].name,
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DM Sans"),
                              ),
                              Text(
                                controllerFirebase.personList[index].email,
                                style:  TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "DM Sans"),
                              ),

                            ],
                          ),
                          SizedBox(width: 1.h,),
                        ],
                      ),
                    ),
                  ),
                );
              }) ,
            )
          ));
        });
  }


  Future<void> _startGroupChat(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Obx(() =>  AlertDialog(
              title: Text("Grup oluştur",style: TextStyle(fontSize: 16.sp),),
              content: SizedBox(
                height: 70.h,
                width: 90.w,
                child:Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                      },
                      controller: groupNameController,
                      decoration: InputDecoration(hintText:"Grup adı girin"),
                    ),
                    SizedBox(height: 1.h,),
                    Expanded(
                      flex: 2,
                      child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,childAspectRatio: 2,crossAxisSpacing: 20,mainAxisSpacing: 20),
                          itemCount: messageController.groupList.length,
                          itemBuilder: (context,index){
                        var shortMail=messageController.groupList[index].substring(0,16);
                        return Container(
                          height: 2.h,
                          decoration: BoxDecoration(
                              border: Border.all(width: .25.h, color: Colors.grey.shade400),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: const Color.fromRGBO(26, 56, 72, 1)),
                          child: Center(child: Text(shortMail,style: TextStyle(color: Colors.white,fontSize: 10.sp))),
                        );
                          }),
                    ),
                    Expanded(
                      flex: 5,
                      child: ListView.builder(itemCount: controllerFirebase.personList.length,itemBuilder: (context,index){
                        return ElevatedButton(onPressed:(){


                          isButtonClicked[index]= !isButtonClicked[index];
                          if(isButtonClicked[index]==false) {
                            messageController.groupList.add(controllerFirebase.personList[index].email);
                            print(0);

                          } else {
                            messageController.groupList.remove(controllerFirebase.personList[index].email);
                            print(1);
                          }
                        },style: ButtonStyle(backgroundColor: isButtonClicked[index]==true? MaterialStateProperty.all(Colors.blue):MaterialStateProperty.all(Colors.green)), child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              controllerFirebase.personList[index].name,
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM Sans"),
                            ),
                            Text(
                              controllerFirebase.personList[index].email,
                              style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "DM Sans"),
                            ),

                          ],
                        ),);

                      }),
                    ),
                        ElevatedButton(onPressed: ()async{
                          if(messageController.groupList.length>1){

                            await messageController.GroupMessageCreate(groupNameController.text);
                            messageController.groupList.clear();
                            groupNameController.text="";
                          }
                          else {
                            Get.snackbar("Hata", "message");
                          }
                    },child:Text("Oluştur",style: TextStyle(fontSize: 14.sp),)),
                  ],
                ) ,
              )
          ));
        });
  }


}
