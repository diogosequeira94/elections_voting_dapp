# Election simulator

Simulate starting an election, adding candidates, authrozing voters and vote through Ethereum addresses on a mock blockchain server with Ganache.

## Requirements 
- Android Studio / VScode
- Node.js
- Truffle (npm install -g truffle)
- Ganache (local blockchain)

<table>
  <tr>
    <th>Home page</th>
    <th>Election Info</th> 
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/17165238/194297213-889a6770-4fdf-48fa-ac9f-7335c54fe311.png"/></td>
    <td><img src="https://user-images.githubusercontent.com/17165238/194383894-10264547-4d97-4112-b59a-3080a35958fd.png"/></td>
  </tr>
</table>



## Folder structure
```
|-- elections_voting
        ...
        -- contracts
        |   |-- Migrations.sol
        |   |-- Election.sol
        |-- lib
        |   |-- bloc
        |   |   |-- election_bloc.dart
        |   |   |-- election_event.dart
        |   |   |-- election_state.dart
        |   |-- models
        |   |   |-- candidate.dart
        |   |   |-- voter.dart
        |   |   |-- election.dart
        |   |-- repository
        |   |   |-- endpoints.dart
        |   |   |-- election_repository.dart
        |   |   |-- election_web3_api_client.dart
        |   |-- view
        |   |   |   |-- widgets
        |   |   |   |   | -- address_dropdown_widget.dart
        |   |   |-- add_candidate_form.dart
        |   |   |-- election_information.dart
        |   |   |-- home_page.dart
        |   |-- main.dart
        -- migrations
        |   |-- 1_electioncontract_migration.js
        ...
    
```

## Stack

**Server**: Ganash

**Smart Contracts**: Solidity, Truffle

**Client**: Flutter

**State Management**: BLoC
