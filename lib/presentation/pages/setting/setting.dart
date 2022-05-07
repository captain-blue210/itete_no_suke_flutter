import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/user/user_repository_interface.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('設定'),
        ),
        body: Container(
          color: Colors.grey.shade200,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'アカウント情報',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Row(
                        children: [
                          const Text('アカウント設定'),
                          const SizedBox(
                            width: 5,
                          ),
                          if (!context
                              .watch<UserRepositoryInterface>()
                              .isLinked())
                            const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                        ],
                      ),
                      subtitle: const Text(
                          '機種変更など端末を変える場合には、これまでの記録を引き継ぐためにアカウント登録が必要となります。',
                          style: TextStyle(fontSize: 12)),
                      onTap: () {},
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
