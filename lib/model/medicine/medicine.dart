import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  late final String medicineID;
  final String? painRecordsID;
  final String name;
  final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Medicine({
    this.painRecordsID,
    required this.name,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  String? get medicinesID => medicineID;

  Medicine setMedicineID(String _medicineID) {
    medicineID = _medicineID;
    return this;
  }

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
