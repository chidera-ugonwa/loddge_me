import 'package:flutter/material.dart';

class ReservedLodgesScreen extends StatefulWidget {
  const ReservedLodgesScreen({super.key});

  @override
  State<ReservedLodgesScreen> createState() => _ReservedLodgesScreenState();
}

class _ReservedLodgesScreenState extends State<ReservedLodgesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reserved',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 20),
                    const Text(
                      'No rooms reserved...yet!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Time to dust off your bags and start preparing to relocate',
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.black,
                          fixedSize: const Size.fromHeight(52),
                          side: const BorderSide(color: Colors.black)),
                      child: const Text('Start searching',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      onPressed: () {},
                    ),
                    const SizedBox(height: 40),
                    const Divider(),
                    const SizedBox(height: 10),
                    RichText(
                      text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'Visit the Help Center',
                                style: TextStyle(
                                    color: Colors.black,
                                    decoration: TextDecoration.underline,
                                    fontFamily: 'Raleway'))
                          ],
                          text: "Can't find your reservation here? ",
                          style: TextStyle(
                              color: Colors.black, fontFamily: 'Raleway')),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
