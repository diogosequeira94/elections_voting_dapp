import 'package:elections_dapp/bloc/election_bloc.dart';
import 'package:elections_dapp/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ElectionBloc(),
      child: MaterialApp(
        title: 'Election App Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.deepOrange,
        ),
        home: const HomePage(),
      ),
    );
  }
}
