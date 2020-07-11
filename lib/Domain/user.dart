
import 'package:cloud_firestore/cloud_firestore.dart';

/* メモデータ */
class User{
  String mail;
  String userID;

  User(DocumentSnapshot doc){
    // TODO コンストラクタ
    userID = doc.documentID;
    mail      = doc['email'];
  }
}