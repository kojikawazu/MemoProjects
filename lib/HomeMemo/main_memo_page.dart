
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/AddEdgeMemo/add_edge_memo_page.dart';
import 'package:modelapp/Domain/memo.dart';
import 'package:modelapp/dialog/error_dialog.dart';
import 'package:provider/provider.dart';

import 'main_memo_model.dart';

/* ホームビュー */
class HomeMemoPage extends StatelessWidget {
  /* field */
  static const String   TITLE_MEMOLIST = 'メモリスト';
  final Error_dialog    _error = new Error_dialog();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeMemoModel>(
      create: (_) => HomeMemoModel()..fetchMemos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(TITLE_MEMOLIST),
        ),
        body: Consumer<HomeMemoModel>( /* ホームメモモデル */
          builder: (context, model, child){
            /* メモリスト取得 */
            return SetMemoList(model, context);
          },
        ),
        floatingActionButton: Consumer<HomeMemoModel>(
            builder: (context, model, child){
              return SetAddButton(context, model);
          }
        ),
      ),
    );
  }

  Center SetMemoList(HomeMemoModel model, BuildContext context){
    // TODO メモリスト取得
    /* メモの取得 */
    final memos = model.memos;
    final listTiles = memos.map(
            (memo) => Card(
              child: ListTile(
              title: Text(memo.title),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async{
                  // TODO 編集ビューへ遷移
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEdgeMemoPage(memo: memo),
                      fullscreenDialog:  true
                    ),
                 );
                 model.fetchMemos();
                },
              ),
              onLongPress: () async{
                // TODO 削除処理
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DeleteAlert(context, model, memo);
                  },
                );
              }
          ),
        ),
    ).toList();
    // TODO メモリストビューを返却
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
          child: ListView(
            children: listTiles,
          ),
        ),
      ),
    );
  }

  FloatingActionButton SetAddButton(BuildContext context, HomeMemoModel model){
    // TODO 追加ボタン取得
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () async{
        // TODO 追加ビューへ遷移
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddEdgeMemoPage(),
              fullscreenDialog:  true
          ),
        );
        model.fetchMemos();
      },
    );
  }

  AlertDialog DeleteAlert(BuildContext context, HomeMemoModel model, Memo memo){
    // TODO 削除アラート表示
    return AlertDialog(
      title: Text('${memo.title}を削除しますか？'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () async {
            Navigator.of(context).pop();

            // TODO 削除API実行
            await DeleteMemo(context, model, memo);
          },
        ),
      ],
    );
  }

  Future DeleteMemo(BuildContext context, HomeMemoModel model, Memo memo) async{
    try {
      // TODO file-storeにメモを削除
      //await _ShowDialog(context, '削除しました');
      await model.deleteMemo(memo);
      await model.fetchMemos();
    }catch(e) {
      await _error.ShowDialog(context, e);
    }
  }
}