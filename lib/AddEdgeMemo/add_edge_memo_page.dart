
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/HomeMemo/main_memo_page.dart';
import 'package:modelapp/Domain/memo.dart';
import 'package:modelapp/dialog/error_dialog.dart';
import 'package:modelapp/dialog/success_dialog.dart';
import 'package:provider/provider.dart';
import 'add_edge_memo_model.dart';

/* 追加,編集ビュー */
class AddEdgeMemoPage extends StatelessWidget {
  /* field */
  final Memo            memo;
  static const String   TITLE_EDGE = 'メモ編集';
  static const String   TITLE_ADD = 'メモ追加';
  final Error_dialog    _error = new Error_dialog();
  final Success_dialog  _success = new Success_dialog();

  final textEditingContorolar = TextEditingController();
  final memoEditingContorolar = TextEditingController();

  /* コンストラクタ */
  AddEdgeMemoPage({this.memo});

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = (memo != null);

    if( isUpdate ){
      textEditingContorolar.text = memo.title;
      memoEditingContorolar.text = memo.memo;
    }

    return ChangeNotifierProvider<AddEdgeMemoModel>(
      create: (_) => AddEdgeMemoModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? TITLE_EDGE : TITLE_ADD),
        ),
        body: Consumer<AddEdgeMemoModel>(
          builder: (context, model, child){
            return Center(
              child: Container(
                color: Color.fromARGB(100, 100, 100, 100),
                width: double.infinity,
                height: double.infinity,
                child: Container(
                  color: Color.fromARGB(255, 250, 250, 255),
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.all(20.0),
                  child: MainPanel(model, context, isUpdate),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding MainPanel(  AddEdgeMemoModel model,
                      BuildContext context,
                      bool isUpdate){
    // TODO メインパネル取得
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          /* メモ編集テキスト */
          EdgeTitleField(model),
          EdgeMemoField(model),

          /* スペース */
          SizedBox(height: 16),

          /* 編集、追加ボタン */
          AddUpdateButton(model, context, isUpdate),
        ],
      ),
    );
  }

  Row EdgeTitleField(AddEdgeMemoModel model){
    // TODO タイトルテキスト編集パネル取得
    return Row(
      children: <Widget>[
        Text('タイトル: '),
        new Expanded(
            child: TextField(
              controller: textEditingContorolar,
              onChanged: (text){
                model.memoTitle = text;
              },
            ),
        ),
      ],
    );
  }

  Row EdgeMemoField(AddEdgeMemoModel model){
    // TODO メモテキスト編集パネル取得
    return  Row(
      children: <Widget>[
        Text('メモ:         '),
        new Expanded(
          child: TextField(
            controller: memoEditingContorolar,
            onChanged: (text){
              model.memoMemo  = text;
            },
          ),
        ),
      ],
    );
  }

  RaisedButton AddUpdateButton(AddEdgeMemoModel model,
                                BuildContext context,
                                bool isUpdate){
    // TODO 追加、編集ボタン取得
    return  RaisedButton(
      child: Text(isUpdate ? AddEdgeMemoModel.BUTTON_EDGE : AddEdgeMemoModel.BUTTON_ADD),
      onPressed: () async{
        if( isUpdate ){
          // TODO メモ更新
          await UpdateMemo(model, context);
        }
        else {
          // TODO メモ追加
          await AddMemo(model, context);
        }
      },
    );
  }

  Future AddMemo(AddEdgeMemoModel model, BuildContext context) async{
    try{
      // TODO file-storeに本を追加
      await model.AddMemoToFirebase();
      await _success.ShowDialog(context, AddEdgeMemoModel.SUCCESS_ADD);
    }catch(e) {
      await _error.ShowDialog(context, e.toString());
    }
  }

  Future UpdateMemo(AddEdgeMemoModel model, BuildContext context) async{
    try{
      // TODO file-storeに本を追加
      await model.UpdateMemoToFirebase(memo);
      await _success.ShowDialog(context, AddEdgeMemoModel.SUCCESS_EGDE);
    }catch(e) {
      await _error.ShowDialog(context, e.toString());
    }
  }
}