import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/global/search_text_field/search_text_field.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/image_generation/presentation/cubit/cubit/image_generation_cubit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ImageGenerationPage extends StatefulWidget {
  const ImageGenerationPage({Key? key}) : super(key: key);

  @override
  State<ImageGenerationPage> createState() => _ImageGenerationPageState();
}

class _ImageGenerationPageState extends State<ImageGenerationPage> {
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
        title: const Text("Image Generation"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: BlocBuilder<ImageGenerationCubit, ImageGenerationState>(
              builder: (context, imageGenerationState) {
                if (imageGenerationState is ImageGenerationLoading) {
                  return Center(
                    child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Image.asset("assets/loading.gif")),
                  );
                }

                if (imageGenerationState is ImageGenerationLoaded) {
                  return MasonryGridView.builder(
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 3,
                      itemCount:
                          imageGenerationState.imageGenerationModel.data.length,
                      itemBuilder: (context, index) {
                        final generatedImage = imageGenerationState
                            .imageGenerationModel.data[index];

                        return Card(
                          child: CachedNetworkImage(
                            imageUrl: generatedImage.url,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.withOpacity(.3),
                                      highlightColor: Colors.grey,
                                      child: Container(
                                        height: 220,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                      ),
                                    )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      });
                }

                return const Center(
                    child: Text(
                  "OpenAI Image Generation",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ));
              },
            )),
            SearchTextFieldWidget(
              textEditingController: _searchTextController,
              onTap: () {
                BlocProvider.of<ImageGenerationCubit>(context)
                    .generateImage(
                      _searchTextController.text,
                    )
                    .then((value) => _clearTextField);
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _clearTextField() {
    setState(() {
      _searchTextController.clear();
    });
  }
}
