import 'package:carry/PushNotificationService.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class DriverRegistration extends StatefulWidget {
  @override
  _DriverRegistrationState createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

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
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  PushNotificationService psh = PushNotificationService();
                  PushNotificationService.initilize();
                  psh.sendPushMessage(
                      "fyrznsmhRX64kyyeFkjE8F:APA91bGKXM31SpIxFO9cGQWjR7MXFJbJlKSsqIYtR-5N6Xke1vSS6AQYaS0OSWmm2WIA3Mt92WLQQgq_6nnvN6jQhH6JL1PJaJ9n2jzoPjZO8wZDfdQiJFBizpRy7yC7ipH10w6uZ_6k");
                },
                child: const Text('profilePicture'),
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

      if (_currentStep == 2) {
        final formdata = _formKey.currentState?.save();

        if (_formKey.currentState?.validate() != null) {
          print(_formKey.currentState?.value);
        } else {
          print("validation failed");
        }
      }
    });
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
