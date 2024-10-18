import 'package:untitled/users/domain/models/user_data.dart';

sealed class UserState{
  const UserState();

}

final class StartUserDataState extends UserState{
  const StartUserDataState();

}

final class LoadingUserDataState extends UserState{

  const LoadingUserDataState();

}
final class LoadedUserDataState extends UserState{
final List<UserData> users;
  const LoadedUserDataState({required this.users});

}

final class UserErrorDataState extends UserState{
  const UserErrorDataState();
}

