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