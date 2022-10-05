# Election simulator

Simulate adding candidates, authrozing voters and vote through Ethereum addresses on a mock blockchain server with Ganache.

## Requirements 
- Android Studio / VScode
- Node.js
- Truffle (npm install -g truffle)
- Ganache (local blockchain)

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
