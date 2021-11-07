import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/presentation/request/painRecord/PainRecordRequestParam.dart';
import 'package:provider/src/provider.dart';

class PainLevelButton extends StatefulWidget {
  final PainLevel painLevel;
  final bool isSelected;

  const PainLevelButton({
    Key? key,
    required this.painLevel,
    required this.isSelected,
  }) : super(key: key);

  @override
  State<PainLevelButton> createState() => _PainLevelButtonState();
}

class _PainLevelButtonState extends State<PainLevelButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: widget.isSelected ? _getSelectedFaceIcon() : _getFaceIcon(),
      onPressed: () {
        context.read<PainRecordRequestParam>().painLevel = widget.painLevel;
      },
    );
  }

  Icon _getFaceIcon() {
    switch (widget.painLevel) {
      case PainLevel.noPain:
        return const Icon(Icons.sentiment_very_satisfied);
        break;
      case PainLevel.moderate:
        return const Icon(Icons.sentiment_satisfied);
        break;
      case PainLevel.verySevere:
        return const Icon(Icons.sentiment_dissatisfied);
        break;
      case PainLevel.worst:
        return const Icon(Icons.sentiment_very_dissatisfied);
        break;
    }
  }

  Icon _getSelectedFaceIcon() {
    switch (widget.painLevel) {
      case PainLevel.noPain:
        return const Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.blue,
        );
        break;
      case PainLevel.moderate:
        return const Icon(
          Icons.sentiment_satisfied,
          color: Colors.blue,
        );
        break;
      case PainLevel.verySevere:
        return const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.blue,
        );
        break;
      case PainLevel.worst:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.blue,
        );
        break;
    }
  }
}
