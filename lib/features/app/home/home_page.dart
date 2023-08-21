import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/app/app_const/page_constant.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/global/styling/text_styles.dart';

import 'widgets/home_button_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset("assets/app_logo.png"),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Explore',
                style: AppTextStyles().mRegular.copyWith(fontSize: 36),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeButtonWidget(
                  textData: "Image\nGeneration",
                  desc:
                      "create realistic images and art from a description in natural language.",
                  image: "assets/magic-wand.png",
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.imageGenerationPage);
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                HomeButtonWidget(
                  textData: "Text\nCompletion",
                  desc:
                      'input a list of messages as input and return a model-generated message as output.',
                  image: 'assets/database.png',
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.textCompletionPage);
                  },
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HomeButtonWidget(
                  textData: "Fine\nTuning",
                  desc: "Train a model for your usecase",
                  image: "assets/ai_2.png",
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.imageGenerationPage);
                  },
                ),
                const SizedBox(
                  width: 8,
                ),
                HomeButtonWidget(
                  textData: "Embeddings",
                  desc: 'Search, classify and compare text',
                  image: 'assets/ai.png',
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.textCompletionPage);
                  },
                ),
              ],
            ),
            const Spacer(),
            const Text(
              "ChatGPT: Optimizing Language Models for Dialogue",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
