import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String userId;
  String userName;
  String Phone;
  Timestamp creationTime;
  String About;
  String profilePictureUrl;
  String email;
  String password;
  bool isAdmin;

  UserModel(
      {required this.isAdmin,
      required this.password,
      required this.email,
      required this.profilePictureUrl,
      required this.About,
      required this.Phone,
      required this.userName,
      required this.userId,
      required this.creationTime});

  String get getUserId => userId;

  String get getUserName => userName;

  String get getPhone => Phone;

  Timestamp get getCreationTime => creationTime;

  String get getAbout => About;

  String get getProfilePictureUrl => profilePictureUrl;

  String get getEmail => email;

  String get getPassword => password;

  bool get getIsAdmin => isAdmin;

  set setUserId(e) {
    userId = e;
  }

  set setUseName(e) => userName = e;

  set setPhone(e) => Phone = e;

  set setCreationTime(e) => creationTime = e;

  set setAbout(e) => About = e;

  set setProfilePictureUrl(e) => profilePictureUrl = e;

  set setEmail(e) => email = e;

  set setPassword(e) => password = e;

  set setIsAdmin(e) => isAdmin = e;

  dynamic toJson() => {
        'userId': userId,
        'userName': userName,
        'Phone': Phone,
        'creationTime': creationTime.toString(),
        'About': About,
        'profilePictureUrl': profilePictureUrl,
        'email': email,
        'password': password,
        'isAdmin': isAdmin,
      };

  static fromJson(json) {
    return (json != null)
        ? UserModel(
            userId: json['userId'],
            userName: json['userName'],
            Phone: json['Phone'],
            creationTime:
                Timestamp.fromDate(DateTime.parse(json['creationTime'])),
            About: json['About'],
            profilePictureUrl: json['profilePictureUrl'],
            email: json['email'],
            password: json['password'],
            isAdmin: json['isAdmin'],
          )
        : {};
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : assert(map["userId"] != null),
        assert(map["email"] != null),
        assert(map["userName"] != null),
        assert(map["creationTime"] != null),
        userId = map['userId'],
        userName = map['userName'],
        Phone = map['Phone'] ?? 'NoPhone',
        creationTime = map['creationTime'],
        About = map['About'] ?? 'NoAbout',
        profilePictureUrl = map['profilePictureUrl'] ?? 'NoProfilePictureUrl',
        email = map['email'],
        password = map['password'] ?? 'NoPassword',
        isAdmin = map['isAdmin'] ?? false;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'Phone': Phone,
      'creationTime': creationTime,
      'About': About,
      'profilePictureUrl': profilePictureUrl,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
    };
  }

  UserModel copyWith({
    String? userId,
    String? userName,
    String? Phone,
    Timestamp? creationTime,
    String? About,
    String? profilePictureUrl,
    String? email,
    String? password,
    bool? isAdmin,
    String? church,
    String? team,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      Phone: Phone ?? this.Phone,
      creationTime: creationTime ?? this.creationTime,
      About: About ?? this.About,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      email: email ?? this.email,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }
}
