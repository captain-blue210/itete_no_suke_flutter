import 'package:cloud_firestore/cloud_firestore.dart';

class Photo {
  late final DocumentReference<Photo>? photoRef;
  final String? painRecordsID;
  final String photoURL;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Photo({
    this.painRecordsID,
    required this.photoURL,
    this.createdAt,
    this.updatedAt,
  });

  Photo setPhotoRef(DocumentReference<Photo> _photoRef) {
    photoRef = _photoRef;
    return this;
  }

  Photo.fromJson(Map<String, Object?> json)
      : this(
          painRecordsID: json['painRecordsID'] as String? ?? '',
          photoURL: json['photoURL'] as String,
          createdAt: (json['createdAt'] as Timestamp).toDate(),
          updatedAt: (json['updatedAt'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() {
    return {
      'painRecordsID': painRecordsID,
      'photoURL': photoURL,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': updatedAt ?? FieldValue.serverTimestamp()
    };
  }
}
