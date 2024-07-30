import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
import '../utils/text_utils/normal_text.dart';

class IconButtonAnchor extends StatelessWidget {
  const IconButtonAnchor({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(
            Icons.more_vert,
            color: kWhiteColor,
          ),
        );
      },
      menuChildren: [
        MenuItemButton(
          child: const NormalText(
            text: 'Sign Out',
            textSize: 16,
          ),
          onPressed: () {
            FirebaseAuth.instance.signOut();
          },
        ),
      ],
    );
  }
}
