import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ViewState extends Equatable {
  const ViewState();

  @override
  List<Object> get props => [];
}

class StartedState extends ViewState {
  const StartedState();

  @override
  List<Object> get props => [];
}

class InitializedState extends ViewState {
  final results;
  InitializedState({this.results});

  @override
  List<Object> get props => [results];
}

class UninitializedState extends ViewState {
  const UninitializedState();

  @override
  List<Object> get props => [];
}

class LoadingState extends ViewState {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class LoadedState extends ViewState {
  final results;
  final bool hasReachedMax;
  final draftResults;
  final lastUpdated;
  final percent;

  LoadedState(
      {this.results,
      this.hasReachedMax,
      this.draftResults,
      this.lastUpdated,
      this.percent});

  LoadedState copyWith({results, bool hasReachedMax, draftResults, percent}) {
    return LoadedState(
        results: results ?? this.results,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        draftResults: draftResults ?? this.draftResults,
        percent: percent ?? this.percent);
  }

  @override
  List<Object> get props => [
        results,
        hasReachedMax,
        draftResults,
        lastUpdated,
        percent
      ];
}

class EmptyState extends ViewState {
  const EmptyState();

  @override
  List<Object> get props => [];
}

class ErrorState extends ViewState {
  final String error;

  ErrorState({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ErrorState { error: $error }';
  }
}

class CustomState extends ViewState {
  final Map data;

  CustomState({this.data});

  @override
  List<Object> get props => [data];
}



