import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/user/user_service.dart';
import 'package:itete_no_suke/application/util/version.dart';
import 'package:itete_no_suke/presentation/pages/setting/account_setting.dart';
import 'package:itete_no_suke/presentation/widgets/auth/auth_state.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  void initState() {
    super.initState();
    context.read<AuthState>().linked(context.read<UserService>().isLinked());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey.shade200,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 0, 5),
                child: Text(
                  'アカウント情報',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          const Text('アカウント設定'),
                          const SizedBox(
                            width: 5,
                          ),
                          if (!context.watch<AuthState>().isLinked)
                            const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                        ],
                      ),
                      subtitle: const Text(
                          '機種変更など端末を変える場合には、これまでの記録を引き継ぐためにアカウント登録が必要となります。',
                          style: TextStyle(fontSize: 12)),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AccountSetting())),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 5),
                child: Text(
                  'ヘルプ&フィードバック',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('アプリの使い方'),
                      dense: true,
                      onTap: () {},
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      title: const Text('よくある質問'),
                      dense: true,
                      onTap: () {},
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      title: const Text('お問い合わせ'),
                      dense: true,
                      onTap: () {},
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 5),
                child: Text(
                  'アプリについて',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('利用規約'),
                      dense: true,
                      onTap: () {},
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    ListTile(
                      title: const Text('プライバシーポリシー'),
                      dense: true,
                      onTap: () {},
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    FutureBuilder<String>(
                        future: Version.getAppVersion(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListTile(
                                  title: const Text('バージョン'),
                                  dense: true,
                                  onTap: () {},
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data!),
                                    ],
                                  ),
                                )
                              : Container();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
