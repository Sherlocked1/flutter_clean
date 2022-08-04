part of 'crud_bloc.dart';

abstract class CrudState extends Equatable {
  const CrudState();

  @override
  List<Object> get props => [];
}

class CrudInitial extends CrudState {}

class CrudLoadingState extends CrudState {}

class CrudLoadedState extends CrudState {
  final String message;

  const CrudLoadedState({required this.message});

  @override
  List<Object> get props => [message];
}

class CrudErrorState extends CrudState {
  final String message;

  const CrudErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
