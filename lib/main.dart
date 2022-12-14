import 'package:flutter/material.dart';
import 'package:posts_clean/core/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/bloc/crud/crud_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_clean/modules/posts/presentation/pages/posts_page.dart';

import 'injection_container.dart' as dependencyInjection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                dependencyInjection.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => dependencyInjection.sl<CrudBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: const PostsPage(),
      ),
    );
  }
}
