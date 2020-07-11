import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/Domain/memo_data.dart';

import '../Domain/memo.dart';

/* メモホームモデル */
class HomeMemoModel extends ChangeNotifier{
  /* field */
    List<Memo> memos = [];

    Future fetchMemos() async{
      // TODO ビューの更新
      final docs = await Firestore.instance.collection(Memo_data.MEMO_TABLE).getDocuments();
      final memos = docs.documents.map((doc) => Memo(doc)).toList();
      this.memos = memos;
      notifyListeners();
    }

    Future deleteMemo(Memo memo) async{
        // TODO メモの削除
        await Firestore.instance.collection(Memo_data.MEMO_TABLE).
              document(memo.documentID).delete();
    }
}