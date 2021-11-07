import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_level_button.dart';
import 'package:provider/src/provider.dart';

class PainLevelButtonList extends StatefulWidget {
  const PainLevelButtonList({Key? key}) : super(key: key);

  @override
  State<PainLevelButtonList> createState() => _PainLevelButtonListState();
}

class _PainLevelButtonListState extends State<PainLevelButtonList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          PainLevel.values.length,
          (index) => PainLevelButton(
                painLevel: PainLevel.values[index],
                isSelected: isSelected(
                  PainLevel.values[index],
                  context.select(
                      (PainRecordRequestParam param) => param.painLevel),
                ),
              )),
    );
  }

  bool isSelected(PainLevel currentPainLevel, PainLevel selectedPainLevel) {
    if (currentPainLevel == selectedPainLevel) {
      return true;
    }
    return false;
  }
}
