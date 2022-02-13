import 'package:cloud_firestore/cloud_firestore.dart';

class BodyPart {
  late final DocumentReference<BodyPart>? bodyPartRef;
  late final String _bodyPartsID;
  final String? painRecordsID;
  final String name;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BodyPart({
    this.painRecordsID,
    required this.name,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  String get bodyPartsID => _bodyPartsID;
  set bodyPartsID(String bodyPartsID) => _bodyPartsID = bodyPartsID;

  BodyPart setBodyPartsID(String bodyPartsID) {
    _bodyPartsID = bodyPartsID;
    return this;
  }

  DocumentReference<BodyPart>? get bodyPartsRef => bodyPartRef;
  BodyPart setBodyPartRef(DocumentReference<BodyPart> _bodyPartRef) {
    bodyPartRef = _bodyPartRef;
    return this;
  }

  BodyPart.fromJson(Map<String, Object?> json)
      : this(
          painRecordsID: json['painRecordsID'] as String? ?? '',
          name: json['name'] as String,
          memo: json['memo'] as String? ?? '',
          createdAt: (json['createdAt'] as Timestamp).toDate(),
          updatedAt: (json['updatedAt'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() {
    return {
      'painRecordsID': painRecordsID,
      'name': name,
      'memo': memo,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp()
    };
  }
}
