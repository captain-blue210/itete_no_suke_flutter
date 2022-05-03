import 'package:cloud_firestore/cloud_firestore.dart';

class BodyPart {
  String? id;
  String? painRecordBodyPartId;
  DocumentReference<BodyPart>? bodyPartRef;
  String? name;
  String? memo;
  DateTime? createdAt;
  DateTime? updatedAt;

  BodyPart({
    this.id,
    this.painRecordBodyPartId,
    this.bodyPartRef,
    required this.name,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  BodyPart.fromJson(Map<String, Object?> json)
      : this(
          name: json['name'] as String? ?? '',
          memo: json['memo'] as String? ?? '',
          createdAt: (json['createdAt'] as Timestamp).toDate(),
          updatedAt: (json['updatedAt'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'memo': memo,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp()
    };
  }

  BodyPart copyWith(
      {String? id,
      String? painRecordBodyPartId,
      DocumentReference<BodyPart>? ref,
      String? name,
      String? memo,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return BodyPart(
        id: id ?? this.id,
        painRecordBodyPartId: painRecordBodyPartId ?? this.painRecordBodyPartId,
        bodyPartRef: ref ?? bodyPartRef,
        name: name ?? this.name,
        memo: memo ?? this.memo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
