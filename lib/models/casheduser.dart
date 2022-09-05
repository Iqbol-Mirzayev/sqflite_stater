class CachedUser {
  int age;
  String name;
  int? id;
  CachedUser({required this.age, required this.name, this.id});

  Map<String, dynamic> toJson() {
    return {
      CachedUserFields.id: id,
      CachedUserFields.age: age,
      CachedUserFields.name: name,
    };
  }

  static CachedUser fromJson(Map<String, Object?> json) {
    return CachedUser(
      id: json[CachedUserFields.id] as int? ?? 0,
      age: json[CachedUserFields.age] as int? ?? 0,
      name: json[CachedUserFields.name] as String? ?? "",
    );
  }
}

class CachedUserFields {
  static String tableName = "cached_users";
  static String databaseName = "users";
  static String id = "id";
  static String name = "name";
  static String age = "age";
}
