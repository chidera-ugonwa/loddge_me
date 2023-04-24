import 'package:flutter/material.dart';

class ReservedLodgesScreen extends StatefulWidget {
  const ReservedLodgesScreen({super.key});

  @override
  State<ReservedLodgesScreen> createState() => _ReservedLodgesScreenState();
}

class _ReservedLodgesScreenState extends State<ReservedLodgesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('No reserved lodges yet')));
  }
}
