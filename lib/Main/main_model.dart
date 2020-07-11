import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier{
    final String H1_TITLE = 'ログイン画面';

    final String SIGNIN_LABEL = '登録されている方は、ログインボタンへ';
    final String SIGNUP_LABEL = '未登録の方は、新規登録ボタンへ';
    final String SIGN_CANCEL_LABEL = 'パスワードを忘れた方はこちら';

    final String SIGNUP_BUTTON = '新規登録';
    final String SIGNIN_BUTTON = 'ログイン';
    final String RESET_PASS_BUTTON = 'パスワードリセット';



    void changeDebugText(){
        // TODO debug
       notifyListeners();
    }
}