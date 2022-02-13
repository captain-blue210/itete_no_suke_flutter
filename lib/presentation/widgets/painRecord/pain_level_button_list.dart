import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/presentation/widgets/painRecord/pain_level_button.dart';

class PainLevelButtonList extends StatefulWidget {
  final PainLevel selected;
  const PainLevelButtonList({Key? key, required this.selected})
      : super(key: key);

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
                  widget.selected,
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
