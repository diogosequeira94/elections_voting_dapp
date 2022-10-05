import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:elections_dapp/view/election_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elections Dapp Demo'),
      ),
      body: BlocConsumer<ElectionBloc, ElectionState>(
        listener: (context, state) {
          if (state is ElectionStartFailure) {
            const snackBar = SnackBar(
              content: Text('Oops, something went wrong!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is ElectionStartSuccess) {
            const snackBar = SnackBar(
              content: Text('Election started with success!'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ElectionPageWidget(electionName: state.electionName),
              ),
            );
            // Navigate to election information page
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/governance-image.png',
                    width: 200,
                    height: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Text(
                      'Welcome to the elections',
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        filled: true, hintText: 'Enter election name'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (controller.text.isNotEmpty) {
                            context.read<ElectionBloc>().add(
                                  StartElectionPressed(
                                      electionName: controller.text),
                                );
                          }
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: state is ElectionStartInProgress
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('Create new Election'),
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 20.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          print('Choose election pressed');
                        },
                        child: state is ElectionStartInProgress
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Text('Choose existing one'),
                      ),
                    ),
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
