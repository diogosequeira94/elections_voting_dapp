import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDropDownWidget extends StatelessWidget {
  const AddressDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final electionsBloc = context.read<ElectionBloc>();
    final addressesList = electionsBloc.getVotersAddresses;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButton(
          isExpanded: true,
          hint: const Text('Select an Address'),
          onChanged: (address) {
            // electionsBloc.add(FetchAllCandidates());
            // select new item
          },
          items: addressesList.map((address) {
            return DropdownMenuItem(
              value: address,
              child: Text(address),
            );
          }).toList(),
        ),
      ],
    );
  }
}
