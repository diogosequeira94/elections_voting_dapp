import 'package:flutter/material.dart';

class ElectionInformation extends StatefulWidget {
  final String electionName;
  const ElectionInformation({Key? key, required this.electionName})
      : super(key: key);

  @override
  State<ElectionInformation> createState() => _ElectionInformationState();
}

class _ElectionInformationState extends State<ElectionInformation> {
  late TextEditingController addCandidateController;

  @override
  void initState() {
    addCandidateController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addCandidateController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                key: const Key('electionInfo_candidateVotes'),
                children: [
                  Column(
                    children: const [
                      Text('Total Candidates'),
                      Text('0'),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('Total Votes'),
                      Text('0'),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
