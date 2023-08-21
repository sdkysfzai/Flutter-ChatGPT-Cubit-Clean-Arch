import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/app/app_const/page_constant.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/presentation/pages/image_generation_page.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/presentation/pages/text_completion_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case "/":
        {
          return materialBuilder(
            widget: const ErrorPage(),
          );
        }
      case PageConst.imageGenerationPage:
        {
          return materialBuilder(
            widget: const ImageGenerationPage(),
          );
        }
      case PageConst.textCompletionPage:
        {
          return materialBuilder(
            widget: const TextCompletionPage(),
          );
        }
      default:
        return materialBuilder(
          widget: const ErrorPage(),
        );
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('error'),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
