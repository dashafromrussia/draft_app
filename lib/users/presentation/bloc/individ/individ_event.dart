import 'package:untitled/users/domain/models/user_data.dart';


sealed class IndividEvent{
  const IndividEvent();

}

final class GetDataIndividEvent extends IndividEvent{
final int id;
  const GetDataIndividEvent({required this.id});

}
final class UpdateIndividNameEvent extends IndividEvent{
  final String name;
  const UpdateIndividNameEvent({required this.name});

}

final class UpdateIndividSurnameEvent extends IndividEvent{
  final String surname;
  const UpdateIndividSurnameEvent({required this.surname});

}

final class UpdateIndividAddressEvent extends IndividEvent{
  final String address;
  const UpdateIndividAddressEvent({required this.address});

}