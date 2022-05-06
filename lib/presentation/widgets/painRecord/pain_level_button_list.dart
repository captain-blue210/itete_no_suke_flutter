import 'package:flutter/material.dart';
import 'package:itete_no_suke/model/painRecord/pain_level.dart';
import 'package:itete_no_suke/presentation/request/painRecord/pain_record_request_param.dart';
import 'package:provider/provider.dart';

class PainLevelButtonList extends StatefulWidget {
  final PainLevel registered;
  const PainLevelButtonList({Key? key, required this.registered})
      : super(key: key);

  @override
  State<PainLevelButtonList> createState() => _PainLevelButtonListState();
}

class _PainLevelButtonListState extends State<PainLevelButtonList> {
  late PainLevel selected;

  @override
  void initState() {
    super.initState();
    selected = widget.registered;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        PainLevel.values.length,
        (index) => IconButton(
          icon: PainLevel.values[index] == selected
              ? _getSelectedFaceIcon(selected)
              : _getFaceIcon(PainLevel.values[index]),
          onPressed: () {
            context.read<PainRecordRequestParam>().painLevel =
                PainLevel.values[index];
            setState(() {
              selected = PainLevel.values[index];
            });
          },
        ),
      ),
    );
  }

  Icon _getFaceIcon(PainLevel painLevel) {
    switch (painLevel) {
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

  Icon _getSelectedFaceIcon(PainLevel painLevel) {
    switch (painLevel) {
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
