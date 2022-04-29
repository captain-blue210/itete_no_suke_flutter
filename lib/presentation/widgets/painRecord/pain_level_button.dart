import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
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
      case PainLevel.moderate:
        return const Icon(Icons.sentiment_satisfied);
      case PainLevel.verySevere:
        return const Icon(Icons.sentiment_dissatisfied);
      case PainLevel.worst:
        return const Icon(Icons.sentiment_very_dissatisfied);
    }
  }

  Icon _getSelectedFaceIcon() {
    switch (widget.painLevel) {
      case PainLevel.noPain:
        return const Icon(
          Icons.sentiment_very_satisfied,
          color: Colors.blue,
        );
      case PainLevel.moderate:
        return const Icon(
          Icons.sentiment_satisfied,
          color: Colors.blue,
        );
      case PainLevel.verySevere:
        return const Icon(
          Icons.sentiment_dissatisfied,
          color: Colors.blue,
        );
      case PainLevel.worst:
        return const Icon(
          Icons.sentiment_very_dissatisfied,
          color: Colors.blue,
        );
    }
  }
}
