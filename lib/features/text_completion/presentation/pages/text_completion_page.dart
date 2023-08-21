import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/global/search_text_field/search_text_field.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/text_completion/presentation/cubit/cubit/text_completion_cubit.dart';
import 'package:share_plus/share_plus.dart';

class TextCompletionPage extends StatefulWidget {
  const TextCompletionPage({Key? key}) : super(key: key);

  @override
  State<TextCompletionPage> createState() => _TextCompletionPageState();
}

class _TextCompletionPageState extends State<TextCompletionPage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    _searchTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Completion Page"),
      ),
      body: Center(
        child: Column(children: [
          Expanded(
            child: BlocBuilder<TextCompletionCubit, TextCompletionState>(
              builder: (context, textCompletionState) {
                if (textCompletionState is TextCompletionLoading) {
                  return Center(
                    child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset("assets/loading.gif")),
                  );
                }
                if (textCompletionState is TextCompletionLoaded) {
                  final choicesData =
                      textCompletionState.textCompletionModelData.choices;

                  return ListView.builder(
                    itemCount: choicesData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final textData = choicesData[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                textData.text,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Share.share(textData.text);
                                      },
                                      child: const Icon(Icons.share, size: 35)),
                                  InkWell(
                                      onTap: () {
                                        Clipboard.setData(
                                            ClipboardData(text: textData.text));
                                      },
                                      child: const Icon(
                                        Icons.copy,
                                        size: 35,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                    child: Text(
                  "OpenAI Text Completion",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ));
              },
            ),
          ),
          SearchTextFieldWidget(
              textEditingController: _searchTextController,
              onTap: () {
                BlocProvider.of<TextCompletionCubit>(context)
                    .textCompletion(query: _searchTextController.text)
                    .then((value) => _clearTextField());
              }),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }

  void _clearTextField() {
    setState(() {
      _searchTextController.clear();
    });
  }
}
