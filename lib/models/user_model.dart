import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

///Model class representing the user data

class UserModel {
  final String id;
  String firstName;
  String lastName;
  String phoneNumber;
  final String userName;
  final String email;

  String password;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.userName,
      required this.email,
      required this.password,
      required this.profilePicture});

  ///Helper function to get the full name
  String get fullname => '$firstName $lastName';

  ///Helper function to get Formatted Phone Number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  // static List<String> nameParts(fullName) => fullname.split(" ");

  static String generateUsername(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstname = nameParts[0].toLowerCase();
    String lastname = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelcaseusername = '$firstname$lastname';
    String usernamewithprefix = 'K_$firstname$lastname';

    return usernamewithprefix;
  }

  ///Static function to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      userName: '',
      password: '',
      email: '',
      profilePicture: '');

  ///Convert model to Json struture for storing data in Firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': formattedPhoneNumber,
      'Password': password,
      'ProfilePicture': profilePicture,
    };
  }

  ///Factory method to create a user model from a firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        password: data['Password'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      throw 'No data ';
    }
  }
}
