class Medicine {
  final String? painRecordsID;
  final String name;
  final String memo;

  Medicine({this.painRecordsID, required this.name, required this.memo});

  Medicine.fromJson(Map<String, Object?> json)
      : this(
          painRecordsID: json['painRecordsID'] as String,
          name: json['name'] as String,
          memo: json['memo'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'painRecordsID': painRecordsID,
      'name': name,
      'memo': memo,
    };
  }
}
