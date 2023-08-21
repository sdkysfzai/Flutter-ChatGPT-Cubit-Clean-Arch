import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_bloc_cubit_clean_architecture/features/global/common/common.dart';

class HomeButtonWidget extends StatelessWidget {
  final String textData;
  final VoidCallback? onTap;
  final String image;
  final String desc;
  const HomeButtonWidget(
      {Key? key,
      required this.textData,
      this.onTap,
      required this.image,
      required this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 220,
        width: MediaQuery.sizeOf(context).width * 0.45,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: darkColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: glowBoxShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 50, height: 50, child: Image.asset(image)),
            const SizedBox(
              height: 10,
            ),
            Text(textData,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Text(desc)
          ],
        ),
      ),
    );
  }
}
