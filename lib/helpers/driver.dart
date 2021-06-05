import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DriverInfo {
  final String firstname;
  final String lastname;
  final String mobileNo;
  final String address;
  final String email;
  final String carbrand;
  final String carModelYear;
  final String carModel;
  final String carType;
  final String driverLicense;
  final String carAssurance;
  final String carLicense;
  final String profilePicture;

  DriverInfo(
    this.firstname,
    this.lastname,
    this.mobileNo,
    this.address,
    this.email,
    this.carbrand,
    this.carModelYear,
    this.carModel,
    this.carType, {
    this.driverLicense = "",
    this.carAssurance = "",
    this.carLicense = "",
    this.profilePicture = "",
  });
}

class Drivers {
  Future<DocumentReference> addDriver(DriverInfo driver) async {
    await Firebase.initializeApp();
    final CollectionReference driverCollection =
        FirebaseFirestore.instance.collection('drivers');

    return await driverCollection.add({
      "firstName": driver.firstname,
      "lastName": driver.lastname,
      "mobileNO": driver.mobileNo,
      "email": driver.email,
      "address": driver.address,
      "carBrand": driver.carbrand,
      "model": driver.carModel,
      "carModelYear": driver.carModelYear,
      "carType": driver.carType,

    });
  }

  Future<void> updateDriver(Map<String, String> data, String documentId) async {
    await Firebase.initializeApp();
    final CollectionReference driverCollection =
        FirebaseFirestore.instance.collection('drivers');
    driverCollection.doc(documentId).update(data);
  }
}
