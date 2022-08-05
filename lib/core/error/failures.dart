import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  ///message string to display to the user
  final String message;
  const Failure({required this.message});
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.message});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});

  @override
  List<Object?> get props => [];
}

///Failure type for when there's no cached data and no internet connection
///[message] is the message to display to the user
class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({required super.message});

  @override
  List<Object?> get props => [];
}
