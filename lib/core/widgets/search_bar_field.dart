import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class SearchBarField extends StatefulWidget {
  const SearchBarField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.iconColor,
    this.suffixIcon,
    this.leading,
    this.trailing,
    this.showBackButton = false,
    this.onBackPressed,
    this.height = 48,
    this.hintStyle,
    this.borderRadius = 16,
    this.borderWidth = 1.4,
    this.borderColor,
    this.fillColor = Colors.white,
    this.shadow,
    this.onTap,
    this.onClear,
    this.onSubmitted,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final void Function(String)? onSubmitted;
  final Color? iconColor;
  final Widget? suffixIcon;
  final Widget? leading;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final void Function()? onTap;
  final VoidCallback? onClear;

  // ── Style ──
  final double height;
  final TextStyle? hintStyle;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final Color fillColor;
  final BoxShadow? shadow;

  @override
  State<SearchBarField> createState() => _SearchBarFieldState();
}

class _SearchBarFieldState extends State<SearchBarField> {
  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final field = Container(
      height: widget.height,
      // constraints: BoxConstraints(minHeight: widget.height),
      decoration: ShapeDecoration(
        color: widget.fillColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: widget.borderWidth,
            color:
                widget.borderColor ?? AppColors.primaryColor.withOpacity(0.15),
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        shadows: [
          widget.shadow ??
              const BoxShadow(
                color: AppColors.shadowBlack,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
        ],
      ),
      child: TextField(
        readOnly: widget.onTap != null,
        onTap: widget.onTap,
        controller: widget.controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        decoration: InputDecoration(
          suffixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          prefixIcon: SizedBox(
            width: 20,
            child: Center(
              child: SvgPicture.asset(
                Assets.imagesIconSearch,
                color: widget.iconColor,
              ),
            ),
          ),
          suffixIcon: (widget.controller?.text.isNotEmpty ?? false)
              ? GestureDetector(
                  onTap: widget.onClear,
                  child: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: AppColors.subtitleColor,
                  ),
                )
              : widget.suffixIcon,
          hintText: widget.hintText,
          hintStyle:
              widget.hintStyle ??
              TextStyles.regular14.copyWith(
                color: AppColors.subtitleColor.withOpacity(0.55),
              ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          filled: true,
          fillColor: widget.fillColor,
        ),
        style: TextStyles.regular14.copyWith(height: 1.1),
      ),
    );

    if (widget.leading == null &&
        !widget.showBackButton &&
        widget.trailing == null) {
      return field;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.leading != null)
          widget.leading!
        else if (widget.showBackButton)
          IconButton(
            onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          ),
        Expanded(child: field),
        if (widget.trailing != null) widget.trailing!,
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      borderSide: const BorderSide(color: Colors.white),
    );
  }
}
