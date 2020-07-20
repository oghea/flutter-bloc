import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/bloc/blocs.dart';
import 'package:playground/bloc/get_search_something/get_search_something_bloc.dart';
import 'package:playground/bloc/view_events.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  TextEditingController _controller;
  ScrollController _scrollController = ScrollController();
  List<dynamic> results = [];
  int page = 1;

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addItem(args) {
    setState(() {
      if (args['status'] == 'search' && args['data'].length > 0) {
        results = args['data'];
      } else if (args['data'].length > 0) {
        results.addAll(args['data']);
      }
    });
  }

  void updatedItem(val, context) {
    BlocProvider.of<GetSearchSomethingBloc>(context).add(
      UpdateEvent(value: val),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetSearchSomethingBloc()..add(InitializeEvent()),
      child: BlocConsumer<GetSearchSomethingBloc, ViewState>(
        listener: (context, state) {
          if (state is InitializedState) {
            addItem(state.results);
            BlocProvider.of<GetSearchSomethingBloc>(context).add(
              UpdateEvent(value: null),
            );
          }
          if (state is LoadedState) {
            addItem(state.results);
          }
        },
        builder: (context, state) {
          if (state is! InfiniteLoadState) {
            _scrollController
              ..addListener(() {
                if (_scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent) {
                  BlocProvider.of<GetSearchSomethingBloc>(context).add(
                    RefreshEvent(value: page + 1),
                  );
                  setState(() {
                    page += 1;
                  });
                }
              });
          }
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                height: 80,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                  onChanged: (val) => {
                    BlocProvider.of<GetSearchSomethingBloc>(context).add(
                      UpdateEvent(value: val),
                    )
                  },
                ),
              ),
              if (state is LoadingState) ...[
                Center(child: CircularProgressIndicator())
              ],
              if (state is LoadedState || state is InfiniteLoadState) ...[
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Center(
                          child: Text('${results[index]['first_name']}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (state is InfiniteLoadState) ...[
                Center(child: CircularProgressIndicator())
              ]
            ],
          );
        },
      ),
    );
  }
}
