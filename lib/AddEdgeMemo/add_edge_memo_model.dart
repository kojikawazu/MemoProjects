import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/Domain/memo_data.dart';

import '../Domain/memo.dart';

/* メモ追加、編集モデル */
class AddEdgeMemoModel extends ChangeNotifier{
  /* field */
  String memoTitle = '';
  String memoMemo = '';

  static const String   BUTTON_EDGE = '更新する';
  static const String   BUTTON_ADD = '追加する';
  static const String   SUCCESS_EGDE = '更新しました';
  static const String   SUCCESS_ADD = '保存しました';

  void IsCheck(){
    // TODO 入力データチェック
    if( memoTitle.isEmpty){
      throw ('タイトルを入力してください');
    }
    if( memoMemo.isEmpty){
      throw ('メモを入力してください');
    }
  }

  Future AddMemoToFirebase() async{
      // TODO file-storeへメモ追加
      IsCheck();

      await Firestore.instance.collection(Memo_data.MEMO_TABLE).add(
          {
            Memo_data.MEMO_TITLE: memoTitle,
            Memo_data.MEMO_MEMO:  memoMemo,
            Memo_data.MEMO_CREATEAT: Timestamp.now(),
          }
      );
  }

  void UpdateCheck(Memo memo){
    // TODO データチェック
     if( !memoTitle.isEmpty && memoTitle != memo.title){
        memo.title = memoTitle;
     }
     if( !memoMemo.isEmpty && memoMemo != memo.memo){
       memo.memo = memoMemo;
     }
  }

  Future UpdateMemoToFirebase(Memo memo) async{
    UpdateCheck(memo);

    // TODO file-storeへメモ編集
    final document = Firestore.instance.collection(Memo_data.MEMO_TABLE).document(memo.documentID);
    await document.updateData({
      Memo_data.MEMO_TITLE: memo.title,
      Memo_data.MEMO_MEMO:  memo.memo,
      Memo_data.MEMO_UPDATEAT: Timestamp.now()
    });
  }
}