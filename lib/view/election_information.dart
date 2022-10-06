import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:elections_dapp/view/add_candidate_form.dart';
import 'package:elections_dapp/view/widgets/address_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ElectionPageWidget extends StatefulWidget {
  final String electionName;
  const ElectionPageWidget({Key? key, required this.electionName})
      : super(key: key);

  @override
  State<ElectionPageWidget> createState() => _ElectionPageWidgetState();
}

class _ElectionPageWidgetState extends State<ElectionPageWidget> {
  @override
  Widget build(BuildContext context) {
    const labelTextStyle = TextStyle(fontSize: 20.0);
    const valueTextStyle = TextStyle(fontSize: 40.0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.electionName),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 1.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: const AddCandidateFormWidget(),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: BlocConsumer<ElectionBloc, ElectionState>(
        listener: (context, state) {
          if (state is AddCandidateSuccess) {
            context.read<ElectionBloc>().add(FetchAllCandidates());
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 25.0),
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
                          const SizedBox(height: 5.0),
                          Text(
                              context
                                  .read<ElectionBloc>()
                                  .totalCandidates
                                  .toString(),
                              style: valueTextStyle),
                        ],
                      ),
                      Column(
                        children: const [
                          Text('Total Votes', style: labelTextStyle),
                          SizedBox(height: 5.0),
                          Text('0', style: valueTextStyle),
                        ],
                      ),
                    ],
                  ),
                  const _CandidatesListWidget(),
                  const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: _AuthorizationButtonWidget(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CandidatesListWidget extends StatelessWidget {
  const _CandidatesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: BlocBuilder<ElectionBloc, ElectionState>(
        buildWhen: (oldState, newState) => newState is! SelectedAddressUpdated,
        builder: (context, state) {
          if (state is FetchCandidatesSuccess) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: state.candidates.length,
                itemBuilder: (BuildContext context, int index) {
                  final candidate = state.candidates[index];
                  return Row(
                    children: [
                      Flexible(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            candidate.name,
                          ),
                          subtitle: Text(
                            candidate.party,
                          ),
                          trailing: Text(
                            candidate.votesNumber.toString(),
                            style: const TextStyle(
                                color: Colors.green, fontSize: 15),
                          ),
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        value: candidate.isSelected,
                        onChanged: (bool? value) {
                          context
                              .read<ElectionBloc>()
                              .add(CandidateCheckboxSelected(index, value!));
                        },
                      ),
                    ],
                  );
                });
          } else if (state is FetchCandidatesInProgress || state is AddCandidateInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchCandidatesFailure) {
            return const Center(
              child: Text('Error loading candidates list'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.error, size: 100),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'There are no candidates yet, click + to add some',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AuthorizationButtonWidget extends StatefulWidget {
  const _AuthorizationButtonWidget({Key? key}) : super(key: key);

  @override
  State<_AuthorizationButtonWidget> createState() =>
      _AuthorizationButtonWidgetState();
}

class _AuthorizationButtonWidgetState
    extends State<_AuthorizationButtonWidget> {
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
          padding: const EdgeInsets.only(top: 18.0, bottom: 24.0),
          child: Column(
            children: [
              Column(
                children: [
                  const AddressDropDownWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (addVoteController.text.isNotEmpty) {
                            context.read<ElectionBloc>().add(
                                  AuthorizedVoterPressed(
                                      voterAddress: addVoteController.text),
                                );
                          }
                        },
                        child: state is AuthorizeVoterInProgress
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('Authorize Voter'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepOrange),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed:
                            context.read<ElectionBloc>().selectedCandidate ==
                                    null
                                ? null
                                : () => print('Vote pressed'),
                        child: state is AuthorizeVoterInProgress
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('Vote'),
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
