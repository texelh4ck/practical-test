import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:practical_test/features/auth/data/repository/auth_repository_impl.dart';
import 'package:practical_test/features/auth/domain/repository/auth_repository.dart';
import 'package:practical_test/features/auth/domain/usecases/logout.dart';
import 'package:practical_test/features/auth/domain/usecases/sign_in.dart';
import 'package:practical_test/features/products/data/repository/product_repository_impl.dart';
import 'package:practical_test/features/products/domain/repository/product_repository.dart';
import 'package:practical_test/features/products/presentation/bloc/products/products_bloc.dart';
import 'package:practical_test/features/products/presentation/bloc/products/products_event.dart';
import 'package:practical_test/features/shared/bloc/geolocation_cubit.dart';

final sl = GetIt.instance;

get blocs => [
  BlocProvider<ProductsBloc>(create: (context) => sl()),
  BlocProvider<GeolocationCubit>(create: (context) => sl()),
];

Future initializeDependencies() async {
  final firabase = await Firebase.initializeApp();
  sl.registerSingleton<FirebaseApp>(firabase);
  sl.registerSingleton<FirebaseAuth>(FirebaseAuth.instanceFor(app: firabase));

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());

  // Use Cases
  sl.registerSingleton<SignInUseCase>(SignInUseCase(sl()));
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase(sl()));

  // Bloc
  sl.registerFactory<ProductsBloc>(
    () => ProductsBloc(sl())..add(GetProducts(page: 0)),
  );
  sl.registerFactory<GeolocationCubit>(() => GeolocationCubit()..getLocation());
}
