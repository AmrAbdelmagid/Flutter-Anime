import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/presentation/widgets/adaptive_indicator.dart';

class AnimatedQuote extends StatelessWidget {
  const AnimatedQuote({required this.cubit, Key? key}) : super(key: key);
  final cubit;

  @override
  Widget build(BuildContext context) {
    if (cubit.quote != null) {
      return Center(
        child: Column(
          children: [
            SizedBox(
              width: 250.0,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 7.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    FlickerAnimatedText(cubit.quote!.content),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: AdaptiveCircularProgressIndicator(),
      );
    }
  }
}
