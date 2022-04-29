import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Photo {
  String? id;
  String? painRecordPhotoId;
  DocumentReference<Photo>? photoRef;
  XFile? image;
  String? photoURL;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  Photo({
    this.id,
    this.painRecordPhotoId,
    this.photoRef,
    this.image,
    this.photoURL,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  Photo.fromJson(Map<String, Object?> json)
      : this(
          photoURL: json['photoURL'] as String? ?? '',
          createdAt: (json['createdAt'] as Timestamp).toDate(),
          updatedAt: (json['updatedAt'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() {
    return {
      'photoURL': photoURL,
      'createdAt': createdAt ?? Timestamp.now(),
      'updatedAt': updatedAt ?? Timestamp.now()
    };
  }

  Photo copyWith({
    String? id,
    String? painRecordPhotoId,
    DocumentReference<Photo>? ref,
    XFile? image,
    String? photoURL,
    bool? deleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Photo(
      id: id ?? this.id,
      painRecordPhotoId: painRecordPhotoId ?? this.painRecordPhotoId,
      photoRef: ref ?? photoRef,
      image: image ?? this.image,
      photoURL: photoURL ?? this.photoURL,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
