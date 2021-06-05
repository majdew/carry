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

  DriverInfo(
    this.firstname,
    this.lastname,
    this.mobileNo,
    this.address,
    this.email,
    this.carbrand,
    this.carModelYear,
    this.carModel,
    this.carType,
    this.driverLicense,
    this.carAssurance,
    this.carLicense,
  );
}

class Drivers {

  Future<void> addDriver(DriverInfo driver) async {
    await Firebase.initializeApp();
    final CollectionReference driverCollection =
        FirebaseFirestore.instance.collection('drivers');


    await driverCollection.add({
      "firstName": driver.firstname,
      "lastName": driver.lastname,
      "mobileNO": driver.mobileNo,
      "email": driver.email,
      "address": driver.address,
      "carBrand": driver.carbrand,
      "model": driver.carModel,
      "carModelYear": driver.carModelYear,
      "carType": driver.carType,
      "driverLicense": driver.driverLicense,
      "carLicense": driver.carLicense,
      "carAssurance": driver.carAssurance,
    });
  }
}
