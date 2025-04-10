import 'package:flutter/material.dart';
import 'package:recipe_app/ui/color_style.dart';
import 'package:recipe_app/ui/text_style.dart';

class InputField extends StatefulWidget {
  final String labelTitle;
  final String placeholderText;
  final String value;
  final void Function(String)? onValueChange;

  const InputField({
    super.key,
    required this.labelTitle,
    required this.placeholderText,
    required this.value,
    this.onValueChange,
  });

  @override
  State<InputField> createState() => _InputFieldState();
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
    const double fieldHeight = 55.0;
    const double verticalPadding = 20.0;
    const double horizontalPadding = 20.0;
    const double labelSpacing = 8.0;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.labelTitle,
            style: AppTextStyles.smallRegular(color: ColorStyle.labelColour),
          ),
        ),
        const SizedBox(height: labelSpacing),
        SizedBox(
          height: fieldHeight,
          child: TextField(
            controller: _controller,
            onChanged: widget.onValueChange,
            style: AppTextStyles.extraSmallRegular(color: ColorStyle.black),
            decoration: InputDecoration(
              hintText: widget.placeholderText,
              hintStyle: AppTextStyles.smallRegular(color: ColorStyle.gray4),
              filled: true,
              fillColor: ColorStyle.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding,
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
            ),
          ),
        ),
      ],
    );
  }
}
