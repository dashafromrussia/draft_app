import 'package:untitled/users/domain/models/user_data.dart';

sealed class IndividState{
  const IndividState();

}

final class StartIndividDataState extends IndividState{
  const StartIndividDataState();

}

final class LoadingIndividDataState extends IndividState{

  const LoadingIndividDataState();

}
final class LoadedIndividDataState extends IndividState{
  final UserData user;
  const LoadedIndividDataState({required this.user});

}

final class IndividErrorDataState extends IndividState{
  const IndividErrorDataState();
}

