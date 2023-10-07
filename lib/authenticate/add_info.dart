import 'package:flutter/material.dart';
import 'package:loddge_me/utils/constants.dart' as constants;

class AddInfo extends StatefulWidget {
  const AddInfo({super.key});

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController birthdayEditingController = TextEditingController();

// Initially password is obscure
  bool _obscureText = true;
  final agreeAndContinue = constants.agreeAndContinue;
  final termsOfService = constants.termsOfService;
  final paymentsTermsOfService = constants.paymentsTermsOfService;
  final nonDiscriminationPolicy = constants.nonDiscriminationPolicy;
  final privacyPolicy = constants.privacyPolicy;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    //firstName field
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        keyboardType: TextInputType.name,
        validator: (val) => val!.isEmpty ? 'Fill out this field' : null,
        onSaved: (val) {
          firstNameEditingController.text = val!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: 'First name',
        ));

    //lastName field
    final lastNameField = TextFormField(
        autofocus: false,
        controller: lastNameEditingController,
        keyboardType: TextInputType.name,
        validator: (val) => val!.isEmpty ? 'Fill out this field' : null,
        onSaved: (val) {
          lastNameEditingController.text = val!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          border: InputBorder.none,
          labelText: 'Last name',
        ));

    //first and last name field
    final firstAndLastName = Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          firstNameField,
          lastNameField,
        ],
      ),
    );

    //Birthday Field
    final birthdayField = TextFormField(
        autofocus: false,
        controller: birthdayEditingController,
        validator: (val) => val!.isEmpty ? 'Fill out this field' : null,
        onSaved: (val) {
          birthdayEditingController.text = val!;
        },
        onTap: () async {
          await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1985),
              lastDate: DateTime(2005));
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            labelText: 'Birthday',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));

    //Email Field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (val) => val!.isEmpty ? 'Fill out this field' : null,
        onSaved: (val) {
          emailEditingController.text = val!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));

    //PassWord Field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: _obscureText,
      validator: (val) => val!.length < 8
          ? 'Password must contain at least 8 characters'
          : null,
      onSaved: (val) {
        passwordEditingController.text = val!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Password',
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        suffix: InkWell(
          onTap: _toggle,
          child: Text(_obscureText ? 'Show' : 'Hide',
              style: const TextStyle(color: Colors.black)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Add your info',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  const SizedBox(height: 20),
                  firstAndLastName,
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Make sure it matches the name on your government ID",
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                  const SizedBox(
                    height: 10,
                  ),
                  birthdayField,
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      "To sign up, you need to be at least 18. Other people who use LodgeMe won't see your birthday.",
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                  const SizedBox(
                    height: 10,
                  ),
                  emailField,
                  const SizedBox(
                    height: 10,
                  ),
                  Text("We'll send a verification link to your email",
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                  const SizedBox(
                    height: 10,
                  ),
                  passwordField,
                  const SizedBox(height: 20),
                  Text(
                      "By selecting $agreeAndContinue, I agree to LodgeMe's $termsOfService, $paymentsTermsOfService and $nonDiscriminationPolicy, and acknowledge the $privacyPolicy ",
                      style: const TextStyle(fontSize: 11)),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.black),
                      child: const Text('Agree and continue',
                          style: TextStyle(fontSize: 18)),
                    ),
                  )
                ])),
      ),
    );
  }
}
