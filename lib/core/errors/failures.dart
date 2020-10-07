import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  Failure({this.message});

  @override
  List<Object> get props => [message];
}

class NeworkFailure extends Failure {
  NeworkFailure({message}) : super(message: message);
}
