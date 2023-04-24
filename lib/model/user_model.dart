import 'package:firebase_auth/firebase_auth.dart';

class UserModel
{
  //TODO: ADD EMERGENCY NUMBERS
  String firstName;
  String lastName;
  String phoneNumber;
  String uid;
  String contactOne;
  String contactTwo;
  String contactThree;

  UserModel({
    required this.firstName, 
    required this.lastName, 
    required this.phoneNumber, 
    required this.uid,
    required this.contactOne, 
    required this.contactTwo, 
    required this.contactThree,

  });


  //GET USER DATA FROM THE SERVER
  factory UserModel.fromMap(Map<String, dynamic> map)
  {
    return UserModel(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '', 
      phoneNumber: map['phoneNumber'] ?? '', 
      uid: map['uid'] ?? '', 
      contactOne: map['contactOne'] ?? '',
      contactTwo: map['contactTwo'] ?? '',
      contactThree: map['contactThree'] ?? '',
    );

  }

  //SEND USER DATA TO THE SERVER
  Map<String, dynamic> toMap()
  {
    return{
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "uid": uid,
      "contactOne": contactOne,
      "contactTwo": contactTwo,
      "contactThree": contactThree,
    };
  }



}