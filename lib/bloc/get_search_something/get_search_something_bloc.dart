import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:playground/bloc/view_events.dart';
import 'package:playground/bloc/view_states.dart';
import 'package:playground/core/api.dart';


part 'get_search_something_event.dart';
part 'get_search_something_state.dart';

class GetSearchSomethingBloc extends Bloc<ViewEvent, ViewState> {
  GetSearchSomethingBloc() : super(StartedState());

  @override
  Stream<ViewState> mapEventToState(
    ViewEvent event,
  ) async* {
    if (event is InitializeEvent) {
      yield* _mapInitSomething();
    } else if (event is UpdateEvent) {
      yield LoadingState();
      yield* _mapSearchSomething(event.value);
    } else if (event is RefreshEvent) {
      yield InfiniteLoadState();
      yield* _mapUpdateSomething(event.value);
    }
  }

  Stream<ViewState> _mapInitSomething() async* {
    try {
      final results = await MovieApiProvider().fetchUser(1);
      yield InitializedState(results: {'status': 'infinite', 'data': results});
    } catch (_) {
      yield ErrorState(error: 'Something went wrong!');
    }
  }

  Stream<ViewState> _mapSearchSomething(String value) async* {
    try {
      final results = await MovieApiProvider().searchUser(value);
      yield LoadedState(results: {'status': 'search', 'data': results});
    } catch (_) {
      yield ErrorState(error: 'Something went wrong!');
    }
  }

  Stream<ViewState> _mapUpdateSomething(int page) async* {
    try {
      final results = await MovieApiProvider().fetchUser(page);
      yield LoadedState(results: {'status': 'infinite', 'data': results});
    } catch (_) {
      yield ErrorState(error: 'Something went wrong!');
    }
  }
}
