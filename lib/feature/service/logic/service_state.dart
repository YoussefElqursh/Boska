part of 'service_cubit.dart';

@immutable
sealed class ServiceState {}

final class ServiceInitial extends ServiceState {}
final class ServiceLoading extends ServiceState {}
final class ServiceSuccess extends ServiceState {}
final class ServiceFailure extends ServiceState {
  final String error;

  ServiceFailure(this.error);
}
