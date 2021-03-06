import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class EditableDivider extends StatelessWidget {
  final double? endIndent;
  const EditableDivider({Key? key, this.endIndent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30.0,
      endIndent: endIndent,
      color: AppColors.myYellow,
      thickness: 2.0,
    );
  }
}
