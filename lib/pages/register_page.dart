import 'package:biletinial_doviz/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../translation/strings.dart';
import 'login_page.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(3.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Text(
               Strings().signUp.tr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40.sp,
              ),
            ),
             SizedBox(
              height: 2.h,
            ),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: Strings().enterYourMail.tr,
                      prefixIcon: Icon(Icons.email,size: 3.h,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon:  Icon(Icons.lock,size: 3.h,),
                      hintText: Strings().enterYourPassword.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 2.h,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authController.register(_emailController.text.trim(), _passwordController.text.trim());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child:  Text(
                      Strings().signUp.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 12.sp
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(Strings().alreadyRegistered.tr,style: TextStyle(fontSize: 12.sp),),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                              const Login(),
                            ),
                          );
                        },
                        child:  Text(Strings().signIn.tr,style: TextStyle(fontSize: 12.sp)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
