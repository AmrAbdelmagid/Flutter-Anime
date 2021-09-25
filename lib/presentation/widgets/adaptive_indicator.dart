import 'package:flutter/material.dart';
import 'package:flutter_bloc_dio_practice/constants/colors.dart';

class AdaptiveCircularProgressIndicator extends StatelessWidget {
  const AdaptiveCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
      backgroundColor: AppColors.myWhite,
      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.myYellow),
    );
  }
}
