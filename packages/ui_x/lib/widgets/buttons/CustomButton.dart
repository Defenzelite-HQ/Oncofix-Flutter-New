import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/ColorPalette.dart';
import '../../helpers/TextStyl.dart';
import '../LoadingIcon.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final void Function(CustomButtonController)? onTap;
  final bool outline;
  final Widget? leading;
  final Widget? loadingIcon;
  final bool block;
  final bool flat;
  final EdgeInsets padding;
  final Color color;

  CustomButton({
    required Key key,
    required this.label,
    this.onTap,
    this.leading,
    this.loadingIcon,
    this.flat = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.outline = false,
    this.block = false,
    this.color = kcPrimaryLight,
  }) : super(key: key);

  CustomButton.outline({
    required Key key,
    required this.label,
    this.onTap,
    this.leading,
    this.loadingIcon,
    this.flat = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.block = false,
    this.color = kcPrimaryLight,
  })  : outline = true,
        super(key: key);

  CustomButton.outlineBlock({
    required Key key,
    required this.label,
    this.onTap,
    this.leading,
    this.loadingIcon,
    this.flat = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.color = kcPrimaryLight,
  })  : block = true,
        outline = true,
        super(key: key);

  CustomButton.block({
    required Key key,
    required this.label,
    this.onTap,
    this.leading,
    this.loadingIcon,
    this.flat = false,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    this.outline = false,
    this.color = kcPrimaryLight,
  })  : block = true,
        super(key: key);

  final CustomButtonController btnController = CustomButtonController.instance;

  @override
  Widget build(BuildContext context) {
    Color _btnTxtColor = color.computeLuminance() > 0.6 ? kcDark : kcWhite;

    return Obx(
      () => GestureDetector(
        onTap: () => onTap!(btnController),
        child: block
            ? AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: padding,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: !outline
                    ? BoxDecoration(
                        color: !btnController.isDisabled ? color : color.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(!flat ? 8 : 0),
                      )
                    : BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(!flat ? 8 : 0),
                        border: Border.all(
                          color: !btnController.isDisabled ? color : color.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                child: !btnController.isBusy
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (leading != null) leading!,
                          if (leading != null) SizedBox(width: 6),
                          Text(
                            label,
                            style: TextStyl.button?.copyWith(
                              fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                              color: !outline ? _btnTxtColor : color,
                            ),
                          ),
                        ],
                      )
                    : loadingIcon != null
                        ? SizedBox(height: 20, width: 20, child: loadingIcon)
                        : LoadingIcon(
                            color: !outline ? _btnTxtColor : color,
                            height: 16,
                          ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: padding,
                    alignment: Alignment.center,
                    decoration: !outline
                        ? BoxDecoration(
                            color: !btnController.isDisabled ? color : color.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(!flat ? 8 : 0),
                            border: Border.all(
                              color: color,
                              width: 1,
                            ),
                          )
                        : BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(!flat ? 8 : 0),
                            border: Border.all(
                              color: color,
                              width: 1,
                            ),
                          ),
                    child: !btnController.isBusy
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (leading != null) leading!,
                              if (leading != null) SizedBox(width: 6),
                              Text(
                                label,
                                style: TextStyl.button?.copyWith(
                                  fontWeight: !outline ? FontWeight.bold : FontWeight.w400,
                                  color: !outline ? _btnTxtColor : color,
                                ),
                              ),
                            ],
                          )
                        : loadingIcon != null
                            ? SizedBox(height: 20, width: 20, child: loadingIcon)
                            : LoadingIcon(
                                color: !outline ? _btnTxtColor : color,
                                height: 16,
                              ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CustomButtonController extends GetxController {
  static CustomButtonController get instance {
    if (!Get.isRegistered<CustomButtonController>()) Get.create(() => CustomButtonController());
    return Get.find<CustomButtonController>();
  }

  RxBool _isBusy = RxBool(false);
  RxBool _isDisabled = RxBool(false);

  bool get isBusy => _isBusy.value;
  bool get isDisabled => _isDisabled.value;

  CustomButtonController setBusy(bool val) {
    _isBusy(val);
    return this;
  }

  CustomButtonController setDisabled(bool val) {
    _isDisabled(val);
    return this;
  }
}
