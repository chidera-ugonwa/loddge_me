import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loddge_me/home/home_page.dart';
import 'package:loddge_me/utils/auth.dart';
import 'package:intl/intl.dart';
import 'package:jumping_dot/jumping_dot.dart';

class AddInfo extends StatefulWidget {
  const AddInfo(this.email, this.phoneNumber, this.usePassword, {super.key});

  final String? email;
  final String? phoneNumber;
  final bool usePassword;

  @override
  State<AddInfo> createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final AuthProvider _auth = AuthProvider();
  bool toHomePage = false;
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController birthdayEditingController = TextEditingController();

  // form key
  final _formKey = GlobalKey<FormState>();

// Initially password is obscure
  bool _obscureText = true;
  bool isLoading = false;
  final agreeAndContinue = const Text('Agree and Continue',
      style: TextStyle(fontWeight: FontWeight.bold));
  final termsOfService = TextButton(
    child: const Text('Terms of Service'),
    onPressed: () {},
  );
  final paymentsTermsOfService = TextButton(
      child: const Text('Payments Terms of Service'), onPressed: () {});
  final nonDiscriminationPolicy = TextButton(
    child: const Text('Non Discrimination Policy'),
    onPressed: () {},
  );
  final privacyPolicy = TextButton(
    child: const Text('Privacy Policy'),
    onPressed: () {},
  );

  @override
  void initState() {
    phoneNumberEditingController.text = "${widget.phoneNumber}";
    emailEditingController.text = "${widget.email}";
    super.initState();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //elevated button child
  Widget elevatedButtonChild() {
    if (!isLoading) {
      return const Text('Agree and continue', style: TextStyle(fontSize: 18));
    } else {
      return JumpingDots(
        color: Colors.white,
        radius: 6,
        numberOfDots: 3,
        innerPadding: 2.0,
        verticalOffset: 10,
        animationDuration: const Duration(milliseconds: 300),
      );
    }
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
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime(2000),
              firstDate: DateTime(1985),
              lastDate: DateTime(2005));
          if (pickedDate != null) {
            setState(() {
              birthdayEditingController.text =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
            });
          }
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            labelText: 'Birthday',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));

    //Email Field
    final emailField = TextFormField(
        controller: emailEditingController,
        readOnly: true,
        decoration: const InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))));

    //phoneNumber field
    final phonNumberField = TextField(
      decoration: const InputDecoration(
          labelText: 'Phone Number',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
      controller: phoneNumberEditingController,
      readOnly: true,
    );

    //PassWord Field
    final passwordField = widget.usePassword
        ? TextFormField(
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
          )
        : const SizedBox(height: 0);

    if (toHomePage) {
      return const HomePage();
    } else {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add your info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24)),
                      const SizedBox(height: 20),
                      firstAndLastName,
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "Make sure it matches the name on your government ID",
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600)),
                      const SizedBox(
                        height: 10,
                      ),
                      birthdayField,
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                          "To sign up, you need to be at least 18. Other people who use LodgeMe won't see your birthday.",
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600)),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.email != null ? emailField : phonNumberField,
                      const SizedBox(
                        height: 10,
                      ),
                      widget.email == null
                          ? const Text('')
                          : Text("We'll send a verification link to your email",
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey.shade600)),
                      const SizedBox(
                        height: 10,
                      ),
                      passwordField,
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: RichText(
                            text: TextSpan(
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                                text: 'By selecting ',
                                children: [
                              TextSpan(
                                  text: 'Agree and continue, ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              const TextSpan(
                                text: "I agree to LodgeMe's ",
                              ),
                              TextSpan(
                                  text: 'Terms of Service,',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              const TextSpan(text: ' '),
                              TextSpan(
                                  text: 'Payments Terms of Service ',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              const TextSpan(text: 'and '),
                              TextSpan(
                                  text: 'Nondiscriminaiton Policy, ',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                              const TextSpan(
                                text: 'and acknowledge the ',
                              ),
                              TextSpan(
                                  text: 'Privacy Policy. ',
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {}),
                            ])),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => isLoading = true);
                                if (context.mounted) {
                                  if (widget.email == null) {
                                    _auth.createUserInFirestore(
                                        "${firstNameEditingController.text} ${lastNameEditingController.text}",
                                        passwordEditingController.text,
                                        birthdayEditingController.text);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return const HomePage();
                                    }));
                                  } else if (widget.usePassword) {
                                    await _auth.registerWithEmailAndPassword(
                                        "${widget.email}",
                                        passwordEditingController.text);
                                    _auth.createUserInFirestore(
                                        "${firstNameEditingController.text} ${lastNameEditingController.text}",
                                        passwordEditingController.text,
                                        birthdayEditingController.text);
                                  } else {
                                    await _auth.createUserInFirestore(
                                        "${firstNameEditingController.text} ${lastNameEditingController.text}",
                                        passwordEditingController.text,
                                        birthdayEditingController.text);
                                    setState(() {
                                      toHomePage = true;
                                    });
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.black),
                            child: elevatedButtonChild()),
                      )
                    ]),
              )),
        ),
      );
    }
  }
}
