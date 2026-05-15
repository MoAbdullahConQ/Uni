import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  // Register your services here
  // Example:
  // getIt.registerLazySingleton<YourService>(() => YourServiceImplementation());

  // getIt.registerSingleton<DatabaseService>(FirestoreService());
  // getIt.registerSingleton<AuthRepo>(
  //   AuthRepoImpl(
  //     firebaseAuthService: getIt<FirebaseAuthService>(),
  //     databaseService: getIt<DatabaseService>(),
  //   ),
  // );
}
