import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  final String? painRecordsID;
  final String name;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Medicine(
      {this.painRecordsID,
      required this.name,
      this.memo,
      this.createdAt,
      this.updatedAt});

  Medicine.fromJson(Map<String, Object?> json)
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
