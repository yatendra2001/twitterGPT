part of 'app_init_bloc.dart';

abstract class AppInitEvent extends Equatable {
  const AppInitEvent();
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AppInitEvent {
  final auth.User? user;

  const AuthUserChanged({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthLogoutRequested extends AppInitEvent {}
