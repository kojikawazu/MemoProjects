import 'package:flutter/material.dart';
import 'package:modelapp/ResetPassword/reset_password_page.dart';
import 'package:modelapp/signup/signup_page.dart';
import 'package:modelapp/login/login_page.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';

void main() {
  runApp(MyApp());
}

/* 一番最初の画面 */
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final TITLE_MAIN =  'メモアプリ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'メモシミュレーション',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(TITLE_MAIN),
          ),
          body: Consumer<MainModel>(builder: (context, model, child){
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
      ),
    );
  }

  Column MainPanel(MainModel model, BuildContext context){
    return Column(
      children: <Widget>[
        /* タイトル */
        Title(model),
        WelcomeLabel(model),
        SetsignButton(model, context),
        ForgetPassLabel(model),
        ResetPasswordButton(model, context),
      ],
    );
  }

  Container Title(MainModel model){
    // TODO タイトル部品作成
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: Column(
        children: <Widget>[
          Text(
            model.H1_TITLE,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Column WelcomeLabel(MainModel model){
    // TODO メインラベル部品作成
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model.SIGNIN_LABEL,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Text(
          model.SIGNUP_LABEL,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Container SetsignButton(MainModel model, BuildContext context){
    // TODO ボタン部品作成
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            /* サインアップボタン */
            child: Text(model.SIGNUP_BUTTON),
            onPressed: (){
              // TODO サインアップビューへ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupPage()),
              );
            },
          ),
          RaisedButton(
            /* サインインボタン */
            child: Text(model.SIGNIN_BUTTON),
            onPressed: (){
              // TODO サインインビューへ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Column ForgetPassLabel(MainModel model) {
    // TODO 忘れた方用ラベル部品作成
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          model.SIGN_CANCEL_LABEL,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Container ResetPasswordButton(MainModel model, BuildContext context){
    // TODO ボタン部品作成
    return Container(
      margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(
            /* サインアップボタン */
            child: Text(model.RESET_PASS_BUTTON),
            onPressed: (){
              // TODO サインアップビューへ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResetPasswordPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}