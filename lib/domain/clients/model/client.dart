class Client {
  int id;
  String firstname;
  String lastname;
  String email;
  dynamic address;
  dynamic photo;
  dynamic caption;
  DateTime createdAt;
  DateTime updatedAt;
  int userId;

  Client({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.photo,
    required this.caption,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        address: json["address"],
        photo: json["photo"],
        caption: json["caption"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "address": address,
        "photo": photo,
        "caption": caption,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_id": userId,
      };
}
