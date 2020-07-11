import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/Dialog/error_dialog.dart';
import 'package:modelapp/HomeMemo/main_memo_page.dart';
import 'package:modelapp/ResetPassword/reset_pass_sendmail_model.dart';
import 'package:provider/provider.dart';

/* パスワード再設定メール送信完了ビュー */
class ResetPass_sendMailPage extends StatelessWidget {
  /*　field */
  static const String   TITLE_SENDMAIL = 'パスワード再設定メール送信完了';
  final Error_dialog    _error = new Error_dialog();
  final String          email;

  ResetPass_sendMailPage({this.email});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<ResetPass_sendMailModel>(
      create: (_) => ResetPass_sendMailModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(TITLE_SENDMAIL),
        ),
        body: Consumer<ResetPass_sendMailModel>(
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
                  child: MainPanel(model, context),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding MainPanel(ResetPass_sendMailModel model, BuildContext context){
    // TODO メインパネル取得
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          /* タイトルラベル */
          SendMailLabel(model),
          /* ログインボタン */
          SuccessButton(model, context),
        ],
      ),
    );
  }

  Container SendMailLabel(ResetPass_sendMailModel model) {
    // TODO 忘れた方用ラベル部品作成
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.email + '\n' + ResetPass_sendMailModel.RESET_SENDMAIL_LABEL,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  RaisedButton SuccessButton(ResetPass_sendMailModel model, BuildContext context){
    // TODO パスワード再設定取得
    return RaisedButton(
      child: Text(ResetPass_sendMailModel.SET_BUTTON),
      onPressed: () async{
        try{
          await Navigator.pop(context);
          await Navigator.pop(context);
        }catch(e){
          _error.ShowDialog(context, e.toString());
        }
      },
    );
  }
}