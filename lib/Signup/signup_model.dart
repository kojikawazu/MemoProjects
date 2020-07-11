import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/Domain/memo_data.dart';
import 'package:modelapp/Domain/user.dart';
import 'package:modelapp/Domain/user_data.dart';

import '../Domain/memo.dart';

class SignupModel extends ChangeNotifier{

  /* field */
  static const String DEFAULT_MAIL = 'example@gmail.com';
  static const String DEFAULT_PASSWD = 'password';
  static const String SUCCESS_TITLE = '登録完了しました';
  static const String SET_BUTTON =  '登録する';

  String                mail = '';
  String                passwd = '';
  final FirebaseAuth    _auth = FirebaseAuth.instance;

  void Check() {
    // TODO 入力データチェック

    // 空白チェック
    if( mail.isEmpty){
      throw (User_data.SIGNUP_ERROR_MAIL);
    }
    if( passwd.isEmpty){
      throw (User_data.SIGNUP_ERROR_PASSWD);
    }
  }

  void Check_sameUser() async{
    // TODO データベースチェック
    final docs  = await Firestore.instance.collection(User_data.USER_TABLE).getDocuments();
    final list  = docs.documents.map((doc) => User(doc)).toList();
    List<User> users = list;

    for(User user in users){
      if( mail == user.mail ){
        throw (User_data.SIGNUP_ERROR_SAME);
      }
    }
  }

  Future Signup() async{
    // TODO 新規ユーザー登録
    await Check();
    await Check_sameUser();

    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: passwd,
    )).user;

    final email = user.email;

    await Firestore.instance.collection(User_data.USER_TABLE).add(
        {
          User_data.USER_EMAIL: email,
          User_data.USER_SIGNUPAT: Timestamp.now(),
        }
    );

  }
}