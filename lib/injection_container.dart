import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_clean/core/network/network_check.dart';
import 'package:posts_clean/modules/posts/data/datasources/local_data_source.dart';
import 'package:posts_clean/modules/posts/data/datasources/remote_data_source.dart';
import 'package:posts_clean/modules/posts/data/repositories/repositoriy_imp.dart';
import 'package:posts_clean/modules/posts/domain/repositories/posts_repositories.dart';
import 'package:posts_clean/modules/posts/domain/usecases/add_post.dart';
import 'package:posts_clean/modules/posts/domain/usecases/delete_post.dart';
import 'package:posts_clean/modules/posts/domain/usecases/get_all_posts.dart';
import 'package:posts_clean/modules/posts/domain/usecases/update_post.dart';
import 'package:posts_clean/modules/posts/presentation/bloc/crud/crud_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ////features - posts

  //bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
      () => CrudBloc(addPost: sl(), deletePost: sl(), updatePost: sl()));

  //usecases
  sl.registerLazySingleton(() => GetAllPosts(sl()));
  sl.registerLazySingleton(() => AddPost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));
  sl.registerLazySingleton(() => UpdatePost(sl()));

  //repos
  sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImp(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  //datasources
  sl.registerLazySingleton<PostsRemoteDataSource>(
      () => PostsRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<PostsLocalDataSource>(
      () => PostsLocalDataSourceImpl(sl()));

  ////core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  ////ext
  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefs);

  sl.registerLazySingleton(() => http.Client());

  sl.registerLazySingleton(() => InternetConnectionChecker());
}
