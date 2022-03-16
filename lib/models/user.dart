import 'package:cloud_firestore/cloud_firestore.dart';

class AppUserModel {
  String name;
  String profilePhoto;
  String email;
  String uid;
  final String? androidNotificationToken;

  AppUserModel(
      {required this.name,
      required this.email,
      required this.uid,  this.androidNotificationToken,

      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,        "androidNotificationToken": androidNotificationToken,

      };

  static AppUserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return AppUserModel(
      email: snapshot['email'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],      androidNotificationToken: snapshot['androidNotificationToken'],

    );
  }
}
