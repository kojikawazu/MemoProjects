import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/Domain/user_data.dart';

import '../Domain/memo.dart';

/* ログインモデル */
class LoginModel extends ChangeNotifier{
  /* field */
  static const String   DEFAULT_MAIL = 'example@gmail.com';
  static const String   DEFAULT_PASSWD = 'password';
  static const String   SUCCESS_TITLE = 'ログインしました';
  static const String   SET_BUTTON =  'ログイン';

  String                  mail   = '';
  String                  passwd = '';
  final FirebaseAuth      _auth  = FirebaseAuth.instance;

  void Check(){
    // TODO 入力データチェック処理
    if( mail.isEmpty ){
      throw (User_data.SIGNUP_ERROR_MAIL);
    }
    if( passwd.isEmpty ){
      throw (User_data.SIGNUP_ERROR_PASSWD);
    }
  }

  Future Signup() async{
    // TODO ログインする
    Check();

    final result = (await _auth.signInWithEmailAndPassword(
      email: mail,
      password: passwd,
    ));
  }
}