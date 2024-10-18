import 'package:untitled/users/domain/models/user_data.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_state.dart';

sealed class UserEvent{
  const UserEvent();

}

final class UpdateUserListEvent extends UserEvent{
  final Map<String,dynamic> data;
  const UpdateUserListEvent({required this.data});
}

final class GetDataUserEvent extends UserEvent{

  const GetDataUserEvent();

}
final class GetDataIndividEvent extends UserEvent{
final int id;
  const GetDataIndividEvent({required this.id});

}

final class RemoveIndividEvent extends UserEvent{
final int id;
  const  RemoveIndividEvent({required this.id});

}