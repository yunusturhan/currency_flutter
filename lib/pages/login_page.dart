import 'package:biletinial_doviz/constants.dart';
import 'package:biletinial_doviz/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../translation/strings.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}
class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.h,
              ),
               Text(
                 Strings().signIn.tr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              SizedBox(height: 5.h,),

              Padding(
                padding:  EdgeInsets.all(2.h),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          hintText: Strings().enterYourMail.tr,
                          prefixIcon  : Icon(Icons.email,size: 3.h,),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText:Strings().enterYourPassword.tr,
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
                          authController.login(_emailController.text.trim(), _passwordController.text.trim());
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        ),
                        child: Text(
                            Strings().signIn.tr,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp
                          ),
                        ),
                      ),
                       SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Strings().notRegisteredYet.tr,style: TextStyle(fontSize: 12.sp),),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                  const Register(),
                                ),
                              );
                            },
                            child: Text(Strings().createAnAccount.tr,style: TextStyle(fontSize: 12.sp)),
                          ),
                        ],
                      ),
                       SizedBox(height: 3.h),
                      ElevatedButton.icon(
                        icon:Icon(Icons.mail_outline_outlined,size: 3.h,) ,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          authController.signInWithGoogle();
                        },
                        label:  Text(Strings().signInWithGoogle.tr,style: TextStyle(fontSize: 12.sp)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}