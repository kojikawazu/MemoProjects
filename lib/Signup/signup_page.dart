
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/dialog/success_dialog.dart';
import 'package:provider/provider.dart';
import 'signup_model.dart';
import '../dialog/error_dialog.dart';

/* サインアップビュー */
class SignupPage extends StatelessWidget {
  /* field */
  static const String TITLE_SIGNUP = 'サインアップ';
  final Error_dialog   _error = new Error_dialog();
  final Success_dialog _success = new Success_dialog();

  @override
  Widget build(BuildContext context) {
    final mailEditingContorolar = TextEditingController();
    final passwordEditingContorolar = TextEditingController();

    return ChangeNotifierProvider<SignupModel>(
      create: (_) => SignupModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(TITLE_SIGNUP),
        ),
        body: Consumer<SignupModel>(
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
                  child: MainPanel(model, context, mailEditingContorolar, passwordEditingContorolar),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding MainPanel(SignupModel model,
                    BuildContext context,
                    TextEditingController mailEditingContorolar,
                    TextEditingController passwordEditingContorolar){
    // TODO メインパネル取得
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          /* メールテキスト */
          MailText(model, mailEditingContorolar),
          /* パスワードテキスト */
          PasswordText(model, passwordEditingContorolar),
          /* サインアップボタン*/
          SignupButton(model, context),
        ],
      ),
    );
  }

  TextField MailText(SignupModel model, TextEditingController mailEditingContorolar){
    // TODO メールテキスト取得
    return TextField(
      decoration: InputDecoration(hintText: SignupModel.DEFAULT_MAIL),
      controller: mailEditingContorolar,
      onChanged: (text){
        model.mail = text;
      },
    );
  }

  TextField PasswordText(SignupModel model, TextEditingController passwordEditingContorolar){
    // TODO パスワードテキスト取得
    return TextField(
      decoration: InputDecoration(hintText: SignupModel.DEFAULT_PASSWD),
      obscureText: true,
      controller: passwordEditingContorolar,
      onChanged: (text){
        model.passwd = text;
      },
    );
  }

  RaisedButton SignupButton(SignupModel model, BuildContext context){
    // TODO サインアップボタン取得
    return  RaisedButton(
      child: Text(SignupModel.SET_BUTTON),
      onPressed: () async{
        // TODO サインアップ処理
        try{
          await model.Signup();
          await _success.ShowDialog(context, SignupModel.SUCCESS_TITLE);
        }catch(e){
          await  _error.ShowDialog(context, e.toString());
        }
      },
    );
  }

}