import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectionInformation extends StatefulWidget {
  final String electionName;
  const ElectionInformation({Key? key, required this.electionName}) : super(key: key);

  @override
  State<ElectionInformation> createState() => _ElectionInformationState();
}

class _ElectionInformationState extends State<ElectionInformation> {
  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(fontSize: 20.0);
    const valueTextStyle = TextStyle(fontSize: 40.0);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName),
      ),
      body: BlocBuilder<ElectionBloc, ElectionState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  key: const Key('electionInfo_candidateVotes'),
                  children: [
                    Column(
                      children: [
                        const Text('Total Candidates', style: labelTextStyle),
                        Text(context.read<ElectionBloc>().totalCandidates.toString(), style: valueTextStyle),
                      ],
                    ),
                    Column(
                      children: const [
                        Text('Total Votes', style: labelTextStyle),
                        Text('0', style: valueTextStyle),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () async {
                    context.read<ElectionBloc>().add(const GetCandidateInfoPressed(index: 0));
                  },
                  child: state is AuthorizeVoterInProgress
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Get Candidate Info'),
                ),
                const ElectionInputsWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ElectionInputsWidget extends StatefulWidget {
  const ElectionInputsWidget({Key? key}) : super(key: key);

  @override
  State<ElectionInputsWidget> createState() => _ElectionInputsWidgetState();
}

class _ElectionInputsWidgetState extends State<ElectionInputsWidget> {
  late TextEditingController addCandidateController;
  late TextEditingController addVoteController;

  @override
  void initState() {
    addCandidateController = TextEditingController();
    addVoteController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addCandidateController.dispose();
    addVoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ElectionBloc, ElectionState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    controller: addCandidateController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(filled: true, hintText: 'Enter candidate name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (addCandidateController.text.isNotEmpty) {
                            context.read<ElectionBloc>().add(
                                  AddCandidatePressed(candidateName: addCandidateController.text),
                                );
                          }
                        },
                        child: state is AddCandidateInProgress
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Add Candidate'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: addVoteController,
                    decoration: const InputDecoration(filled: true, hintText: 'Enter voter address'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                        onPressed: () async {
                          if (addVoteController.text.isNotEmpty) {
                            context.read<ElectionBloc>().add(
                                  AuthorizedVoterPressed(voterAddress: addVoteController.text),
                                );
                          }
                        },
                        child: state is AuthorizeVoterInProgress
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Authorize Voter'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
