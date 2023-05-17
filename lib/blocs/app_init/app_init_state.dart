part of 'app_init_bloc.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AppInitState extends Equatable {
  final auth.User? user;
  final AuthStatus status;

  const AppInitState({this.user, this.status = AuthStatus.unknown});

  factory AppInitState.unknown() => const AppInitState();

  factory AppInitState.authenticated({required auth.User user}) {
    return AppInitState(status: AuthStatus.authenticated, user: user);
  }

  factory AppInitState.unauthenticated() =>
      const AppInitState(status: AuthStatus.unauthenticated);

  @override
  bool get stringify => true;
  @override
  List<Object?> get props => [user, status];
}
