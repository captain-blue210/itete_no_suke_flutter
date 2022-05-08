import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/user/user_service.dart';
import 'package:itete_no_suke/presentation/widgets/auth/auth_state.dart';
import 'package:provider/provider.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({Key? key}) : super(key: key);

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              TextButton(
                onPressed: () async {
                  await context
                      .read<UserService>()
                      .linkWithEmailAndPassword(email, password);
                  context
                      .read<AuthState>()
                      .linked(context.read<UserService>().isLinked());
                },
                child: const Text(
                  '登録する',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
              ),
              OutlinedButton(
                onPressed: () async {
                  await context
                      .read<UserService>()
                      .signinWithEmailAndPassword(email, password);
                  context
                      .read<AuthState>()
                      .linked(context.read<UserService>().isLinked());
                },
                child: const Text(
                  'ログインする',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '※アカウント登録いただくと、これまで入力いただいた記録も引き継がれます。',
                overflow: TextOverflow.clip,
              ),
              const Text(
                '※機種変更時にデータを引き継ぐにはアカウント登録が必要です。',
                overflow: TextOverflow.clip,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
