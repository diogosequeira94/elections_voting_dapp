import 'package:flutter/material.dart';

class ElectionInformation extends StatelessWidget {
  final String electionName;
  const ElectionInformation({Key? key, required this.electionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(electionName),
      ),
      body: Container(),
    );
  }
}
