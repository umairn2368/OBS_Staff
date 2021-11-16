class UserModel {
  String? uid;
  String? email;
  String? name;
  String? role;
  String? status;
  String? avatar;

  UserModel(
      {this.uid, this.email, this.name, this.role, this.status, this.avatar});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      role: map['role'],
      status: map['status'],
      avatar: map['avatar'],
    );
  }
}






// class UserModel {

//   final String uid;
//   final String email;
//   final String name;
//   final String role;
//   final String status;
//   final String avatar;

//   UserModel(
//       {required this.uid,
//       required this.email,
//       required this.name,
//       required this.role,
//       required this.status,
//       required this.avatar});

//   factory UserModel.fromMap(map) {
//     return UserModel(
//       uid: map['uid'],
//       email: map['email'],
//       name: map['name'],
//       role: map['role'],
//       status: map['status'],
//       avatar: map['avatar'],
//     );
//   }
// }

