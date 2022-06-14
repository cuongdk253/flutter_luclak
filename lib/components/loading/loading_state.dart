import 'package:equatable/equatable.dart';

class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends LoadingState {}

class UnLoading extends LoadingState {
  @override
  List<Object> get props => [false];
}

class Loading extends LoadingState {
  @override
  List<Object> get props => [true];
}
