import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  @override
  List<Object> get props => [];

  String get message => "There is a problem with the server.";
}

class ConnectionFailure extends Failure {
  @override
  List<Object> get props => [];

  String get message => "There is a problem with your connection.";
}
