import 'package:flutter/material.dart';
import 'package:ks_mail/src/presentation/widgets/button_widgets/back_icon_button_widget.dart';
import 'package:ks_mail/src/utils/constants/icons.dart';

import '../../../utils/constants/variables.dart';

class LongpressAppBarWidget extends StatelessWidget {
  const LongpressAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: const BackIconButtonWidget(),
        actions: [
          IconButton(
              onPressed: () {
                longpressAppBar = false;
              },
              icon: clearIcon)
        ],
      ),
    );
  }
}
