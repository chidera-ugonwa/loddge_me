import 'package:flutter/material.dart';

class LodgesScreen extends StatefulWidget {
  const LodgesScreen({super.key});

  @override
  State<LodgesScreen> createState() => _LodgesScreenState();
}

class _LodgesScreenState extends State<LodgesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Material(
            elevation: 10,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.transparent, //New
                        blurRadius: 25.0,
                        offset: Offset(0, -25))
                  ],
                ),
                width: double.infinity,
                height: 40,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search by Name',
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    suffixIcon: IconButton(
                        color: Colors.black,
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list_rounded)),
                  ),
                )),
          )),
      body: const Center(child: Text("No lodges available yet")),
    );
  }
}
