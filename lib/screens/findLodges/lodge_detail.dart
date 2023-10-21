import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:loddge_me/models/services.dart';
import 'package:flutter/material.dart';

class LodgeDetail extends StatefulWidget {
  const LodgeDetail(this.urls, this.title, {super.key});

  final List urls;
  final String title;

  @override
  State<LodgeDetail> createState() => _LodgeDetailState();
}

class _LodgeDetailState extends State<LodgeDetail> {
  final Services _services = Services();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          height: 90,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: ListTile(
                title: const Text('N250k',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: SizedBox(
                  height: 50,
                  width: 100,
                  child: ElevatedButton(
                    child: const Text('Rent'),
                    onPressed: () {},
                  ),
                ),
              ))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
                itemCount: 5,
                itemBuilder: (context, itemIndex, realIndex) {
                  return ClipRect(
                      child: Stack(children: [
                    Image.network(
                      widget.urls[itemIndex],
                      fit: BoxFit.fill,
                      width: 1000,
                    ),
                    Positioned(
                        left: 20,
                        top: 40,
                        child: CircleAvatar(
                            radius: 16,
                            foregroundColor: const Color.fromRGBO(0, 0, 0, 1),
                            backgroundColor: Colors.white,
                            child: IconButton(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                icon: const Icon(Icons.arrow_back_outlined),
                                onPressed: () {
                                  Navigator.pop(context);
                                }))),
                    Positioned(
                        right: 20,
                        top: 40,
                        child: CircleAvatar(
                            radius: 16,
                            foregroundColor: Colors.grey,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(Icons.favorite_border_outlined),
                              onPressed: () {
                                _services.saveListingsToFireStore(
                                    widget.title,
                                    '250k',
                                    widget.urls,
                                    '',
                                    '',
                                    '',
                                    '',
                                    [],
                                    '',
                                    '',
                                    '');
                              },
                            )))
                  ]));
                },
                options: CarouselOptions(
                  height: 230,
                  viewportFraction: 1,
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text('Located at Ifite, Awka'),
                    const SizedBox(height: 20),
                    const Divider(),
                    SizedBox(
                      height: 150,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'The rooms are fully equipped to live in it. It is in an old neighbourhood that is being rehabilitated. It is for 5 people. The place is fascinating, a canon overlooking the river Baul. Beautiful shared pool.',
                              style: TextStyle(
                                  fontFamily: 'Poppins', wordSpacing: 3),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: 'Show more >',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}))
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    SizedBox(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'What this place offers',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.soup_kitchen_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Kitchen')
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.wifi_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Wifi')
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.water_drop_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Well')
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.power_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Electricity')
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              children: [
                                Icon(Icons.water_outlined),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Borehole')
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      foregroundColor: Colors.black,
                                      fixedSize: const Size.fromHeight(52),
                                      side: const BorderSide(
                                          color: Colors.black)),
                                  child: const Text('Show all amenities',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  onPressed: () {},
                                ),
                              ),
                            )
                          ],
                        )),
                    const Divider(),
                    SizedBox(
                        height: 500,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Directions",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Card(
                                child: Container(
                                  height: 300,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                  'If you are coming From Port Harcourt, Enter a vehicle that will take you to Unizik Junction and then enter a shuttle that will stop you at Ifite, main gate '),
                              const SizedBox(
                                height: 20,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Show more >',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {}))
                            ])),
                    const Divider(),
                    SizedBox(
                        height: 500,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Reviews",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                ),
                                child: CarouselSlider.builder(
                                  itemCount: 10,
                                  options: CarouselOptions(
                                      aspectRatio: 1.1, viewportFraction: 0.8),
                                  itemBuilder: (context, itemIndex, realIndex) {
                                    return const Card();
                                  },
                                ),
                              ),
                              const SizedBox(height: 50),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      foregroundColor: Colors.black,
                                      fixedSize: const Size.fromHeight(52),
                                      side: const BorderSide(
                                          color: Colors.black)),
                                  child: const Text('Show all amenities',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  onPressed: () {},
                                ),
                              ),
                            ])),
                    const Divider(),
                    SizedBox(
                        height: 650,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                "Owned by Ugochukwu",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Joined in September 2018',
                                style: TextStyle(color: Colors.grey),
                              ),
                              const SizedBox(height: 20),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.star),
                                  SizedBox(width: 20),
                                  Text('50 Reviews')
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.verified_outlined),
                                  SizedBox(width: 20),
                                  Text('Identity verified')
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                  "Established in 2003, this lodge was built with very little funds in my account. I always say that if not for God there's no way that we would have been able to complete this building. Initially when we started, my mother mysteriously died and soon after needed to be buried, my older brothers business also suddensly started falling apart and was in need of serious support, This lodge reminds me of God's faithfulness... "),
                              RichText(
                                  text: TextSpan(
                                      text: 'Show more >',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {})),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text('Registration Number: 99283892892'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Application Id: 99283892892'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Response Rate: 98%'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text('Response Time: Within an hour'),
                              const SizedBox(
                                height: 40,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      foregroundColor: Colors.black,
                                      fixedSize: const Size.fromHeight(52),
                                      side: const BorderSide(
                                          color: Colors.black)),
                                  child: const Text('Contact Host',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                  onPressed: () {},
                                ),
                              ),
                            ])),
                    const Divider(),
                    const SizedBox(
                        height: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              ListTile(
                                trailing: Icon(Icons.arrow_forward),
                                subtitle: Text('Dec 2023 - Dec 2024'),
                                title: Text(
                                  "Availability",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ])),
                    const Divider(),
                    const SizedBox(
                        height: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              ListTile(
                                trailing: Icon(Icons.arrow_forward),
                                subtitle: Text(
                                    "All payments are refundable within the first 7days, t's & c's apply"),
                                title: Text(
                                  "Cancellation policy",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ])),
                    const Divider(),
                    const SizedBox(
                        height: 100,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              ListTile(
                                trailing: Icon(Icons.arrow_forward),
                                subtitle: Text('Undertaken required'),
                                title: Text(
                                  "Safety & property",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ])),
                    const Divider(),
                    SizedBox(
                        height: 150,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.flag_outlined),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Report this listing',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {}))
                                  ])
                            ]))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
