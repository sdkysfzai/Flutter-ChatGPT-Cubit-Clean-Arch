import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/core/http_certificate_manager.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/app/home/home_page.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/app/routes/on_generate_route.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/presentation/cubit/cubit/image_generation_cubit.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/presentation/cubit/cubit/text_completion_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TextCompletionCubit>(
            create: (context) => di.sl<TextCompletionCubit>()),
        BlocProvider<ImageGenerationCubit>(
          create: (context) => di.sl<ImageGenerationCubit>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter ChatGPT - Clean Architecture',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        onGenerateRoute: OnGenerateRoute.route,
        theme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) {
            return const HomePage();
          }
        },
      ),
    );
  }
}
