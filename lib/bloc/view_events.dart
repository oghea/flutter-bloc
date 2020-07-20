import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ViewEvent extends Equatable {
  const ViewEvent();

  @override
  List<Object> get props => [];
}

class InitializeEvent extends ViewEvent {}

class UpdateEvent extends ViewEvent {
  final value;

  UpdateEvent({@required this.value});

  @override
  List<Object> get props => [value];

  @override
  String toString() {
    return 'UpdateEvent { value: $value }';
  }
}

class RefreshEvent extends ViewEvent {
  final value;
  final refreshData;

  RefreshEvent({@required this.value, @required this.refreshData});

  @override
  List<Object> get props => [value, refreshData];

  @override
  String toString() {
    return 'RefreshEvent { value: $value, refreshData: $refreshData }';
  }
}
