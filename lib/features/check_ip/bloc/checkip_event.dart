part of 'checkip_bloc.dart';

@immutable
sealed class CheckipEvent {}
class FetchIpLookupEvent extends CheckipEvent{
  final String ipAddress;
  FetchIpLookupEvent(this.ipAddress);
}