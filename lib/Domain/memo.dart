
import 'package:cloud_firestore/cloud_firestore.dart';

/* メモデータ */
class Memo{
  String title;
  String memo;
  String documentID;

  Memo(DocumentSnapshot doc){
     // TODO コンストラクタ
     documentID = doc.documentID;
     title      = doc['title'];
     memo       = doc['memo'];
  }
}