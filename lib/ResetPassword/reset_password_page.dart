import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/Dialog/error_dialog.dart';
import 'package:modelapp/Dialog/success_dialog.dart';
import 'package:modelapp/ResetPassword/reset_pass_sendmail_page.dart';
import 'package:modelapp/ResetPassword/reset_password_model.dart';
import 'package:provider/provider.dart';

/*　パスワード再設定確認メールビュー */
class ResetPasswordPage extends StatelessWidget {
  /*　field */
  static const String   TITLE_SENDMAIL = 'パスワード再設定';
  final Success_dialog  _success = new Success_dialog();
  final Error_dialog    _error = new Error_dialog();

  @override
  Widget build(BuildContext context) {
    // メールコントローラー
    final mailEditingContorolar = TextEditingController();

    return ChangeNotifierProvider<ResetPasswordModel>(
      create: (_) => ResetPasswordModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(TITLE_SENDMAIL),
        ),
        body: Consumer<ResetPasswordModel>(
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
                  child: MainPanel(model, context, mailEditingContorolar),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding MainPanel(ResetPasswordModel model,
      BuildContext context,
      TextEditingController mailEditingContorolar){
    // TODO メインパネル取得
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          /* タイトルラベル */
          ForgetPassLabel(model),
          /* メール */
          MailText(model, mailEditingContorolar),
          /* ログインボタン */
          ResetPasswordButton(model, context),
        ],
      ),
    );
  }

  Container ForgetPassLabel(ResetPasswordModel model) {
    // TODO 忘れた方用ラベル部品作成
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ResetPasswordModel.RESET_SENDMAIL_LABEL,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  TextField MailText(ResetPasswordModel model, TextEditingController mailEditingContorolar){
    // TODO メールテキスト取得
    return TextField(
      decoration: InputDecoration(hintText: ResetPasswordModel.DEFAULT_MAIL),
      controller: mailEditingContorolar,
      onChanged: (text){
        model.mail = text;
      },
    );
  }

  RaisedButton ResetPasswordButton(ResetPasswordModel model, BuildContext context){
    // TODO パスワード再設定取得
    return RaisedButton(
      child: Text(ResetPasswordModel.SET_BUTTON),
      onPressed: () async{
        try{
          await model.ResetPassword();
          await Navigator.push(
            context,
            // TODO メール送信完了画面へ遷移
            MaterialPageRoute(builder: (context) => ResetPass_sendMailPage(email: model.mail)),
          );
        }catch(e){
          _error.ShowDialog(context, e.toString());
        }
      },
    );
  }
}