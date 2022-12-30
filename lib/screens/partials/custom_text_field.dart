import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kount/screens/styles/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.controller,
    this.obscureText = false,
    required this.label,
    this.help,
    this.onChanged,
    this.errorText,
    super.key,
  });

  final String label;
  final String? help;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? errorText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: kCreationFieldLabel,
        ),
        SizedBox(
          height: kDefaultSpacer / 2,
        ),
        help != null
            ? Column(
                children: [
                  Text(
                    help!,
                    style: kCreationFieldSubLabel,
                  ),
                  SizedBox(
                    height: kDefaultSpacer,
                  ),
                ],
              )
            : Container(),
        errorText != null
            ? Column(
                children: [
                  Text(
                    errorText!,
                    style: kCreationFieldError,
                  ),
                  SizedBox(
                    height: kDefaultSpacer,
                  ),
                ],
              )
            : Container(),
        TextField(
          onChanged: onChanged,
          decoration: kInputDecoration,
          controller: controller,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
