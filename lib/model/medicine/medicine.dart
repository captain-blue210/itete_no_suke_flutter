import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  String? id;
  String? painRecordMedicineId;
  DocumentReference<Medicine>? medicineRef;
  String? name;
  late final String? memo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Medicine({
    this.id,
    this.painRecordMedicineId,
    this.medicineRef,
    required this.name,
    this.memo,
    this.createdAt,
    this.updatedAt,
  });

  // String? get medicineID => id;
  Medicine setPainRecordMedicineId(String? painRecordMedicineId) {
    painRecordMedicineId = painRecordMedicineId;
    return this;
  }

  Medicine setMedicineRef(DocumentReference<Medicine> _medicineRef) {
    medicineRef = _medicineRef;
    return this;
  }

  Medicine.fromJson(Map<String, Object?> json)
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

  Medicine copyWith({
    String? id,
    String? painRecordMedicineId,
    DocumentReference<Medicine>? ref,
    String? name,
    String? memo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Medicine(
        id: id ?? this.id,
        painRecordMedicineId: painRecordMedicineId ?? this.painRecordMedicineId,
        medicineRef: ref ?? medicineRef,
        name: name ?? this.name,
        memo: memo ?? this.memo,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }
}
