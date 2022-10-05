import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCandidateFormWidget extends StatefulWidget {
  const AddCandidateFormWidget({Key? key}) : super(key: key);

  @override
  State<AddCandidateFormWidget> createState() => _AddNoteFormWidgetState();
}

class _AddNoteFormWidgetState extends State<AddCandidateFormWidget> {
  late TextEditingController nameTextEditingController;
  late TextEditingController partyTextEditingController;

  @override
  void initState() {
    nameTextEditingController = TextEditingController();
    partyTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    partyTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Add a Candidate',
            style: TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name'),
              TextFormField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Party'),
              TextFormField(
                controller: partyTextEditingController,
                keyboardType: TextInputType.text,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: BlocBuilder<ElectionBloc, ElectionState>(
                builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  context.read<ElectionBloc>().add(
                        AddCandidatePressed(
                          candidateName: nameTextEditingController.text,
                          party: partyTextEditingController.text,
                        ),
                      );
                },
                child: state is AddCandidateInProgress
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text('Add Candidate'),
              );
            }),
          ),
        ],
      ),
    );
  }
}
