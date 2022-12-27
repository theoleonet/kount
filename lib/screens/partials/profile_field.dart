import 'package:flutter/material.dart';
import 'package:kount/screens/styles/constants.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({this.label = '', this.value = '', super.key});

  final String label;
  final String value;

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
          height: kDefaultSpacer,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        )
      ],
    );
  }
}
