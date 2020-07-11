import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:modelapp/Domain/user.dart';
import 'package:modelapp/Domain/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

/* パスワード再設定確認用モデル */
class ResetPasswordModel extends ChangeNotifier{
  /* field */
  static const String                   RESET_SENDMAIL_LABEL = 'パスワードを再設定を行います。\b\n登録済のメールアドレスと新しいパスワードを\n入力してください。';
  static const String                   DEFAULT_MAIL = 'example@gmail.com';
  static const String                   DEFAULT_PASSWD = 'password';
  static const String                   SET_BUTTON =  'パスワードリセット';
  static const String                   SAME_ERROR_PASSWD = 'パスワード一致してません';

  String                                mail   = '';
  final FirebaseAuth                    _auth  = FirebaseAuth.instance;

  void Check(){
    // TODO 入力データチェック処理
    if( mail.isEmpty ){
      throw (User_data.SIGNUP_ERROR_MAIL);
    }
  }

  void Check_sameUser() async{
    // TODO データベースチェック
    final docs  = await Firestore.instance.collection(User_data.USER_TABLE).getDocuments();
    final list  = docs.documents.map((doc) => User(doc)).toList();
    List<User> users = list;

    bool isSame = false;
    for(User user in users){
      if( mail == user.mail ){
         isSame = true;
         break;
      }
    }
    if(!isSame){
      throw (User_data.RESET_ERROR_PASSWORD);
    }
  }

  Future ResetPassword() async{
    // TODO 外部メール送信処理
    Check();
    Check_sameUser();

    // メール送信
    await _auth.sendPasswordResetEmail(email: mail);
  }
}