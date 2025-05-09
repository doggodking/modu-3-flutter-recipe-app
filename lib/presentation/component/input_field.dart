// Flutter imports:
import 'package:flutter/material.dart';
import 'package:recipe_app/core/ui/color_style.dart';
import 'package:recipe_app/core/ui/text_style.dart';
// Project imports:
import 'package:recipe_app/presentation/component/image_component/app_image.dart';

class InputField extends StatefulWidget {
  final String labelTitle;
  final String placeholderText;
  final String value;
  final Widget? iconWidget;
  final double? height;
  final double? inputHorizontalPadding;
  final void Function(String)? onValueChange;
  final VoidCallback? onTap;
  final bool? readOnly;

  const InputField({
    super.key,
    required this.labelTitle,
    required this.placeholderText,
    required this.value,
    this.onValueChange,
    this.iconWidget,
    this.height = 55,
    this.inputHorizontalPadding = 20,
    this.onTap,
    this.readOnly = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();

  static Widget searchIcon() {
    return const AppImage(path: 'assets/images/icons/search_normal.png');
  }
}

class _InputFieldState extends State<InputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant InputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.value.length),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10.0;
    const double borderWidth = 1.5;
    const double labelSpacing = 5.0;

    return Column(
      children: [
        if (widget.labelTitle.isNotEmpty) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 21,
              child: Text(
                widget.labelTitle,
                style: AppTextStyles.smallRegular(
                  color: ColorStyle.labelColour,
                ),
              ),
            ),
          ),
          const SizedBox(height: labelSpacing),
        ],
        SizedBox(
          height: widget.height,
          child: TextField(
            controller: _controller,
            onChanged: widget.onValueChange,
            onTap: widget.onTap,
            style: AppTextStyles.extraSmallRegular(color: ColorStyle.black),
            readOnly: widget.readOnly ?? false,
            decoration: InputDecoration(
              hintText: widget.placeholderText,
              hintStyle: AppTextStyles.smallRegular(color: ColorStyle.gray4),
              filled: true,
              fillColor: ColorStyle.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: widget.inputHorizontalPadding ?? 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: ColorStyle.gray4,
                  width: borderWidth,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: ColorStyle.primary80,
                  width: borderWidth,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(
                  color: ColorStyle.gray4,
                  width: borderWidth,
                ),
              ),
              prefixIcon:
                  widget.iconWidget != null
                      ? Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: widget.iconWidget,
                        ),
                      )
                      : null,
              prefixIconConstraints: const BoxConstraints(
                minHeight: 20,
                minWidth: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
