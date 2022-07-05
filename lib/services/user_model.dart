import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const String uidFeild = 'uid';
  static const String emailFeild = 'email';
  static const String fnameFeild = 'firstName';
  static const String lnameFeild = 'secondName';
  static const String bookingsFeild = 'bookings';

  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  List<String>? bookings;
  //String? points;

  UserModel(
      {this.uid, this.email, this.firstName, this.secondName, this.bookings});

//UserModel DATA FROM SERVER
  factory UserModel.fromMap(DocumentSnapshot map) {
    return UserModel(
      uid: map.id,
      email: map[emailFeild],
      firstName: map[fnameFeild],
      secondName: map[lnameFeild],
      bookings: map[bookingsFeild].map<String>((e) => e.toString()).toList(),
    );
  }

//SENDING DATA TO OUR SERVER
  Map<String, dynamic> toMap() {
    return {
      uidFeild: uid,
      emailFeild: email,
      fnameFeild: firstName,
      lnameFeild: secondName,
      bookingsFeild: bookings ?? [],
    };
  }

  UserModel copyWith(
          {String? firstName, String? secondName, List<String>? bookings}) =>
      UserModel(
        uid: uid,
        email: email,
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        bookings: bookings ?? this.bookings,
      );
}
