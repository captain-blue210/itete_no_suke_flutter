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
          child: context.watch<AuthState>().isLinked
              ? logoutModules(context)
              : Column(
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

  Widget logoutModules(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextButton(
          onPressed: () async {
            context
                .read<AuthState>()
                .linked(await context.read<UserService>().signout());
          },
          child: const Text(
            'ログアウト',
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        TextButton(
          onPressed: () async {
            await context.read<UserService>().withdrawal();
            context
                .read<AuthState>()
                .linked(context.read<UserService>().isLinked());
          },
          child: const Text(
            '退会する',
            style: TextStyle(color: Colors.red),
          ),
        )
      ],
    );
  }
}
