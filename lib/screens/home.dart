import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/bloc/get_search_something/get_search_something_bloc.dart';
import 'package:playground/bloc/view_events.dart';
import 'package:playground/widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Playground'),
      ),
      body: BlocProvider(
        create: (context) => GetSearchSomethingBloc()..add(InitializeEvent()),
        child: SearchWidget(),
      ),
    );
  }
}