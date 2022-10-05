import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressDropDownWidget extends StatelessWidget {
  const AddressDropDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final electionsBloc = context.read<ElectionBloc>();
    final addressesList = electionsBloc.getVotersAddresses;
    return BlocBuilder<ElectionBloc, ElectionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select an Address',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: DropdownButton(
                isExpanded: true,
                hint: const Text('Select an Address'),
                value: (state is SelectedAddressUpdated) ? state.updatedAddress : addressesList[0],
                onChanged: (address) {
                  electionsBloc.add(VoterAddressSelected(address.toString()));
                },
                items: addressesList.map((addressItem) {
                  return DropdownMenuItem(
                    value: addressItem,
                    child: Text(addressItem),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
