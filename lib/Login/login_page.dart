
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modelapp/HomeMemo/main_memo_page.dart';
import 'package:modelapp/dialog/Success_dialog.dart';
import 'package:modelapp/dialog/error_dialog.dart';
import 'package:provider/provider.dart';
import 'login_model.dart';

/*　ログインページビュー */
class LoginPage extends StatelessWidget {
  /*　field */
  static const String   TITLE_SIGNIN = 'ログイン';


  final Error_dialog    _error = new Error_dialog();
  final Success_dialog  _success = new Success_dialog();

  @override
  Widget build(BuildContext context) {
    // メールコントローラー
    final mailEditingContorolar = TextEditingController();
    // パスワードコントローラー
    final passwordEditingContorolar = TextEditingController();

    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(TITLE_SIGNIN),
        ),
        body: Consumer<LoginModel>(
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

  Padding MainPanel(LoginModel model,
      BuildContext context,
      TextEditingController mailEditingContorolar,
      TextEditingController passwordEditingContorolar){
    // TODO メインパネル取得
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          /* メール */
          MailText(model, mailEditingContorolar),
          /* パスワード */
          PasswordText(model, passwordEditingContorolar),
          /* ログインボタン */
          LoginButton(model, context),
        ],
      ),
    );
  }

  TextField MailText(LoginModel model, TextEditingController mailEditingContorolar){
    // TODO メールテキスト取得
    return TextField(
      decoration: InputDecoration(hintText: LoginModel.DEFAULT_MAIL),
      controller: mailEditingContorolar,
      onChanged: (text){
        model.mail = text;
      },
    );
  }

  TextField PasswordText(LoginModel model, TextEditingController passwordEditingContorolar){
    // TODO パスワードテキスト取得
    return  TextField(
      decoration: InputDecoration(hintText: LoginModel.DEFAULT_PASSWD),
      obscureText: true,
      controller: passwordEditingContorolar,
      onChanged: (text){
        model.passwd = text;
      },
    );
  }

  RaisedButton LoginButton(LoginModel model, BuildContext context){
    // TODO サインインボタン取得
    return RaisedButton(
      child: Text(LoginModel.SET_BUTTON),
      onPressed: () async{
        try{
          await model.Signup();
          await _success.ShowDialog(context, LoginModel.SUCCESS_TITLE);
          await Navigator.push(
            context,
            // TODO ホームへ遷移
            MaterialPageRoute(builder: (context) => HomeMemoPage()),
          );
        }catch(e){
          _error.ShowDialog(context, e.toString());
        }
      },
    );
  }
}