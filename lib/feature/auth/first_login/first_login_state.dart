part of 'first_login_cubit.dart';

sealed class FirstLoginState {}

final class FirstLoginInitial extends FirstLoginState {}
final class AuthAuthenticated extends FirstLoginState {}
final class AuthUnauthenticated extends FirstLoginState {}
