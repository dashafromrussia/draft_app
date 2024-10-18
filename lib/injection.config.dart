// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:untitled/api_data/api_data.dart' as _i4;
import 'package:untitled/api_data/posts/post_api_data.dart' as _i5;
import 'package:untitled/api_data/users/user_api_data.dart' as _i6;
import 'package:untitled/api_server.dart' as _i7;
import 'package:untitled/events.dart' as _i9;
import 'package:untitled/navigation/bloc/data_testing_events_bloc.dart' as _i8;
import 'package:untitled/navigation/go_route_post.dart' as _i16;
import 'package:untitled/navigation/go_route_user.dart' as _i17;
import 'package:untitled/navigation/route_interface.dart' as _i15;
import 'package:untitled/posts/data/api/post_provider.dart' as _i11;
import 'package:untitled/posts/data/api/post_provider_impl.dart' as _i12;
import 'package:untitled/posts/data/repository/post_repository_impl.dart'
    as _i14;
import 'package:untitled/posts/domain/models/post_data_mapper.dart' as _i10;
import 'package:untitled/posts/domain/repository/post_repository.dart' as _i13;
import 'package:untitled/posts/presentation/bloc/post_bloc.dart' as _i25;
import 'package:untitled/users/data/api/user_provider.dart' as _i19;
import 'package:untitled/users/data/api/user_provider_impl.dart' as _i20;
import 'package:untitled/users/data/repository/user_repository_impl.dart'
    as _i22;
import 'package:untitled/users/domain/models/address_mapper.dart' as _i3;
import 'package:untitled/users/domain/models/user_data_mapper.dart' as _i18;
import 'package:untitled/users/domain/repository/user_repository.dart' as _i21;
import 'package:untitled/users/presentation/bloc/all_users/users_bloc.dart'
    as _i26;
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart'
    as _i24;
import 'package:untitled/yandex_map/data/repository/yandex_coder_repository.dart'
    as _i23;

const String _user = 'user';
const String _post = 'post';

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AddressDataMapper>(
      () => _i3.AddressDataMapper(),
      registerFor: {_user},
    );
    gh.lazySingleton<_i4.ApiData>(
      () => _i5.UserApiData(),
      registerFor: {_post},
    );
    gh.lazySingleton<_i4.ApiData>(
      () => _i6.UserApiData(),
      registerFor: {_user},
    );
    gh.lazySingleton<_i7.ApiServer>(() => const _i7.ApiServer());
    gh.singleton<_i8.DataBloc>(() => _i8.DataBloc());
    gh.lazySingleton<_i9.EventsBus>(() => _i9.EventsBus());
    gh.lazySingleton<_i10.PostDataMapper>(
      () => _i10.PostDataMapper(),
      registerFor: {_post},
    );
    gh.singleton<_i11.PostProvider>(
      () => _i12.PostProviderImpl(
        gh<_i7.ApiServer>(),
        gh<_i4.ApiData>(),
      ),
      registerFor: {_post},
    );
    gh.singleton<_i13.PostRepository>(
      () => _i14.PostRepositoryImpl(gh<_i11.PostProvider>()),
      registerFor: {_post},
    );
    gh.singleton<_i15.RouteInterface>(
      () => _i16.RouteData(),
      registerFor: {_post},
    );
    gh.singleton<_i15.RouteInterface>(
      () => _i17.RouteData(),
      registerFor: {_user},
    );
    gh.lazySingleton<_i18.UserDataMapper>(
      () => _i18.UserDataMapper(),
      registerFor: {_user},
    );
    gh.singleton<_i19.UserProvider>(
      () => _i20.UserProviderImpl(
        gh<_i7.ApiServer>(),
        gh<_i4.ApiData>(),
      ),
      registerFor: {_user},
    );
    gh.singleton<_i21.UserRepository>(
      () => _i22.UserRepositoryImpl(gh<_i19.UserProvider>()),
      registerFor: {_user},
    );
    gh.singleton<_i23.YandexCoderRepository>(
      () => _i23.YandexCoderRepository(),
      registerFor: {_user},
    );
    gh.singleton<_i24.IndividBloc>(
      () => _i24.IndividBloc(
        gh<_i21.UserRepository>(),
        gh<_i9.EventsBus>(),
      ),
      registerFor: {_user},
    );
    gh.singleton<_i25.PostBloc>(
      () => _i25.PostBloc(
        gh<_i13.PostRepository>(),
        gh<_i9.EventsBus>(),
      ),
      registerFor: {_post},
    );
    gh.singleton<_i26.UserBloc>(
      () => _i26.UserBloc(
        gh<_i21.UserRepository>(),
        gh<_i9.EventsBus>(),
      ),
      registerFor: {_user},
    );
    return this;
  }
}
