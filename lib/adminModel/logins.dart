class LoginRecord {
  final String id;
  final Map<String, dynamic> fields;

  LoginRecord({
    required this.id,
    required this.fields,
  });

  factory LoginRecord.fromFirestore(Map<String, dynamic> data, String id) {
    return LoginRecord(
      id: id,
      fields: data, // Store all fields dynamically
    );
  }
}