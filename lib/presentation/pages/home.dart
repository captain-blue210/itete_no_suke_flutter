import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itete_no_suke/application/photo/photo_service.dart';
import 'package:itete_no_suke/presentation/pages/bodyParts/body_parts_list.dart';
import 'package:itete_no_suke/presentation/pages/medicine/medicine_list.dart';
import 'package:itete_no_suke/presentation/pages/painRecord/pain_record_list.dart';
import 'package:itete_no_suke/presentation/pages/photo/photo_list.dart';
import 'package:itete_no_suke/presentation/request/photo/PhotoRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/home/add_button.dart';
import 'package:itete_no_suke/presentation/widgets/home/add_button_index.dart';
import 'package:itete_no_suke/presentation/widgets/photo/photo_mode_state.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AddButton addButton = AddButton();
  static const List<Widget> _pages = <Widget>[
    PhotoList(),
    BodyPartsList(),
    MedicineList(),
    PainRecordList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('いててのすけ'),
        actions: createSelectPhotoButton(context),
      ),
      body: Center(
        child: _pages.elementAt(addButton.getCurrentIndex()),
      ),
      floatingActionButton: createFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: createBottomNavigationBar(context),
    );
  }

  Widget createBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_album),
          label: '写真',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings_accessibility),
          label: '部位',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.medical_services),
          label: 'お薬',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: addButton.getCurrentIndex(),
      onTap: (index) {
        setState(() {
          addButton.index = AddButtonIndex.values[index];
        });
      },
    );
  }

  void showInputForm(BuildContext context) {
    if (addButton.getCurrentIndex() == AddButtonIndex.photo.index) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return addButton.getAddButton();
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return addButton.getAddButton();
        },
      );
    }
  }

  List<Widget>? createSelectPhotoButton(BuildContext context) {
    if (isPhotoPage()) {
      return <Widget>[
        TextButton(
          child: Text(
            !context.watch<PhotoModeState>().isPhotoSelectMode ? '選択' : 'キャンセル',
            style: const TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (context.read<PhotoModeState>().isPhotoSelectMode) {
              context.read<PhotoRequestParam>().removeAll();
            }
            context.read<PhotoModeState>().togglePhotoSelectMode();
          },
        )
      ];
    }
  }

  bool isPhotoPage() {
    return addButton.getCurrentIndex() == AddButtonIndex.photo.index;
  }

  Widget createFloatingActionButton(BuildContext context) {
    if (isPhotoPage() && context.watch<PhotoModeState>().isPhotoSelectMode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          getDeleteFloatingActionButton(context),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showInputForm(context);
            },
            child: const Icon(Icons.add),
          )
        ],
      );
    }
  }

  Widget getDeleteFloatingActionButton(BuildContext context) {
    if (isPhotoPage() && context.watch<PhotoModeState>().isPhotoSelectMode) {
      return FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
        onPressed: () {
          context
              .read<PhotoService>()
              .deletePhotos(context.read<PhotoRequestParam>().selectedPhotos);
          context.read<PhotoRequestParam>().removeAll();
        },
      );
    } else {
      return Container();
    }
  }
}
