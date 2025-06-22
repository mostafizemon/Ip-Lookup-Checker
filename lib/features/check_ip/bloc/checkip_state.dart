part of 'checkip_bloc.dart';

@immutable
sealed class CheckipState {}

final class CheckipInitial extends CheckipState {}

final class CheckipLoading extends CheckipState {}

final class CheckipLoaded extends CheckipState {
  final String ipAddress;
  final IpLookupModel responseData;
  CheckipLoaded({required this.ipAddress, required this.responseData});
}

final class CheckipError extends CheckipState {
  final String ipAddress;
  final String message;

  CheckipError({required this.ipAddress, required this.message});
}
