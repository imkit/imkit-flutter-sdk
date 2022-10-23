import 'package:flutter/material.dart';
import 'package:imkit/sdk/imkit.dart';
import 'package:imkit/widgets/components/im_icon_button_widget.dart';
import 'package:imkit/widgets/messages/input_view/im_utility_type.dart';

class IMUtilityItem extends StatelessWidget {
  const IMUtilityItem({
    Key? key,
    required this.type,
  }) : super(key: key);

  final IMUtilityType type;
  final double size = 36;

  @override
  Widget build(BuildContext context) {
    Color iconColor;

    switch (type) {
      case IMUtilityType.translate:
        if (IMKit.instance.internal.state.cloudTranslateActive) {
          iconColor = IMKit.style.inputView.utility.iconActiveColor;
        } else {
          iconColor = IMKit.style.inputView.utility.iconInactiveColor;
        }
        break;

      default:
        iconColor = IMKit.style.inputView.utility.iconColor;
    }

    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IMIconButtonWidget(
            icon:
                Icon(getUtilityIcon(type: type), size: size, color: iconColor),
            size: size,
          ),
          const SizedBox(height: 4),
          Text(getUtilityText(type: type),
              style: IMKit.style.inputView.utility.textTextStyle),
        ],
      ),
    );
  }
}
