import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart' as pth;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import './helpers/driver.dart';

import 'package:file_picker/file_picker.dart';

class DriverRegistrationForm extends StatefulWidget {
  @override
  _DriverRegistrationFormState createState() => _DriverRegistrationFormState();
}

class _DriverRegistrationFormState extends State<DriverRegistrationForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  List<dynamic> pickedFiles = [];

  String carAssuranceLink = "";
  String carLicenseLink = "";
  String driverLicenseLink = "";
  dynamic document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Join'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FormBuilder(
                    key: _formKey,
                    child: Stepper(
                      type: stepperType,
                      physics: ScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue: continued,
                      onStepCancel: cancel,
                      steps: <Step>[
                        Step(
                          title: new Text(
                            'Personal Information',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'firstName',
                                decoration: InputDecoration(
                                  labelText: 'First Name',
                                  hintText: 'Enter your first Name',
                                ),
                                //  onChanged: onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.maxLength(context, 70),
                                ]),
                              ),
                              FormBuilderTextField(
                                name: 'lastName',
                                decoration: InputDecoration(
                                  labelText: 'Last Name',
                                  hintText: 'Enter your Last Name',
                                ),
                                //  onChanged: onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.maxLength(context, 70),
                                ]),
                              ),
                              FormBuilderTextField(
                                name: 'mobileNO',
                                decoration: InputDecoration(
                                  labelText: 'Mobile Number',
                                  hintText: 'Enter your Mobile Number',
                                ),
                                //  onChanged: onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.maxLength(context, 15),
                                ]),

                                keyboardType: TextInputType.number,
                              ),
                              FormBuilderTextField(
                                name: 'address',
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  hintText: 'Enter your address',
                                ),
                                //  onChanged: onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.maxLength(context, 120),
                                ]),
                              ),
                              FormBuilderTextField(
                                name: 'email',
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  hintText: 'Enter your Email Address',
                                ),
                                //  onChanged: onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.maxLength(context, 120),
                                  FormBuilderValidators.email(context)
                                ]),
                              ),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text(
                            'Car Details',
                            style: TextStyle(fontSize: 18),
                          ),
                          content: Column(
                            children: <Widget>[
                              FormBuilderDropdown(
                                name: 'carBrand',
                                decoration: InputDecoration(
                                  labelText: 'Car Brand',
                                ),
                                allowClear: true,
                                hint: Text('Select your Car Brand'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                items: [
                                  "Skoda",
                                  "Mazda",
                                  "Hyundai",
                                  "Mercedes",
                                  "BMW",
                                  "Honda",
                                  "Other.."
                                ]
                                    .map((carBrand) => DropdownMenuItem(
                                          value: carBrand,
                                          child: Text('$carBrand'),
                                        ))
                                    .toList(),
                              ),
                              FormBuilderDropdown(
                                name: 'carModelYear',
                                decoration: InputDecoration(
                                  labelText: 'Car Model Year',
                                ),
                                // initialValue: 'Male',
                                allowClear: true,
                                hint: Text('Select your Car Model Year'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                items: [
                                  "2008",
                                  "2009",
                                  "2010",
                                  "2011",
                                  "2012",
                                  "2013",
                                  "2014",
                                  "2015",
                                  "2016",
                                  "2017",
                                  "2018",
                                  "2019",
                                  "2020",
                                  "2021",
                                  "Other.."
                                ]
                                    .map((carModelYear) => DropdownMenuItem(
                                          value: carModelYear,
                                          child: Text('$carModelYear'),
                                        ))
                                    .toList(),
                              ),
                              FormBuilderTextField(
                                name: 'model',
                                decoration: InputDecoration(
                                  labelText: 'Car Model',
                                  hintText: 'Enter your Car Model',
                                ),
                                //  onChanged: onChanged,
                                // valueTransformer: (text) => num.tryParse(text),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.maxLength(context, 70),
                                ]),
                              ),
                              FormBuilderDropdown(
                                name: 'carType',
                                decoration: InputDecoration(
                                  labelText: 'Car Type',
                                ),
                                allowClear: true,
                                hint: Text('Select your Car Type'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                items: [
                                  "TAXI",
                                  "SMALL VAN",
                                  "SMALL BUS",
                                  "BIG BUS",
                                  "TRUCK",
                                  "Other.."
                                ]
                                    .map((carType) => DropdownMenuItem(
                                          value: carType,
                                          child: Text('$carType'),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                        Step(
                          title: new Text(
                            'Upload Documents',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          content: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickFile('driverLicense');
                                  },
                                  child: const Text('Driver License'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickFile('carAssurance');
                                  },
                                  child: const Text('Car Assurance'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickFile('carLicense');
                                  },
                                  child: const Text('Car License'),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickFile('profilePicture');
                                  },
                                  child: const Text('profilePicture'),
                                ),
                              ),
                            ],
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 2
                              ? StepState.complete
                              : StepState.disabled,
                        ),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  continued() async {
    // Code to upload image and adding information to firebase
    if (_currentStep == 2) {
      await Firebase.initializeApp();
      _formKey.currentState?.save();

      if (true) {
        pickedFiles.forEach((element) async {
          final file = File(element[1]);
          var documentType = element[0];
          String fileName = pth.basename(file.path);
          final destination = 'files/$documentType/$fileName';

          Reference storageReference =
              FirebaseStorage.instance.ref().child(destination);

          await storageReference.putFile(file).whenComplete(
            () {
              storageReference.getDownloadURL().then((fileUrl) {
                var url = fileUrl.toString();
                Drivers().updateDriver({'$documentType': url}, document.id);
              });
            },
          );
        });

        print('hi');
        DriverInfo driver = DriverInfo(
          _formKey.currentState?.fields['firstName']?.value,
          _formKey.currentState?.fields['lastName']?.value,
          _formKey.currentState?.fields['mobileNO']?.value,
          _formKey.currentState?.fields['address']?.value,
          _formKey.currentState?.fields['email']?.value,
          _formKey.currentState?.fields['carBrand']?.value,
          _formKey.currentState?.fields['carModelYear']?.value,
          _formKey.currentState?.fields['model']?.value,
          _formKey.currentState?.fields['carType']?.value,
        );
        document = await Drivers().addDriver(driver);
        pickedFiles.clear();

        _formKey.currentState?.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Your information added successfuly!'),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Please check your information !'),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } else
      setState(() => _currentStep += 1);
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  pickFile(String documentType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    final path = result.files.single.path;
    pickedFiles.add([documentType, path]);
  }
}
