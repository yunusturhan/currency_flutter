import 'package:biletinial_doviz/pages/home_page.dart';
import 'package:biletinial_doviz/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;
  late UserCredential _credential;
  var ref = FirebaseFirestore.instance.collection("Person");
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    firebaseUser = (auth.currentUser).obs;
    googleSignInAccount =(googleSign.currentUser).obs;


    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);


    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const Login());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    print(googleSignInAccount);
    if (googleSignInAccount == null) {
      Get.offAll(() => const Login());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).whenComplete(() => ref.doc(auth.currentUser?.uid).set({'email':auth.currentUser?.email,'name':googleSignInAccount.displayName}));
        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }


    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e.toString());
    }
  }

  void register(String email, password) async {
    try {
      _credential= await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(_credential.user!.uid);
      ref.doc(_credential.user!.uid).set({'email':_credential.user!.email});
    } catch (firebaseAuthException) {}
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    await auth.signOut();
  }
}