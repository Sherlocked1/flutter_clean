import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String message;
  Failure({required this.message});
}

class OfflineFailure extends Failure {
  OfflineFailure({required super.message});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  EmptyCacheFailure({required super.message});

  @override
  List<Object?> get props => [];
}
