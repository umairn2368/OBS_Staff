class AttendenceModel {
  String? uid;
  String? checkInTime;
  String? checkOutTime;
  String? date;

  AttendenceModel(
      {this.uid, this.checkInTime, this.checkOutTime, this.date});

  // receiving data from server
  factory AttendenceModel.fromMap(map) {
    return AttendenceModel(
      uid: map['uid'],
      checkInTime: map['checkInTime'],
      checkOutTime: map['checkOutTime'],
      date: map['date'],
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

