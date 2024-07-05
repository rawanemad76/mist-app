import 'package:flutter/material.dart';
import 'package:mist_app/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final Function(String)? onChange;
  final VoidCallback? onSaved;
  final double radius;
  final double width;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final String? Function(String? data)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.onChange,
    this.radius = 100,
    this.width = double.infinity,
    this.obscureText = false,
    this.readOnly = false,
    this.maxLines = 1,
    String? Function(String? data)? validator,
    this.onSaved,
  }) : validator = validator ?? _defaultValidator;

  static String? _defaultValidator(String? data) {
    if (data!.isEmpty) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  static String? emailValidator(String? data) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(data!);

    if (emailValid) {
      return null;
    } else {
      return 'please enter a valid email';
    }
  }

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isTextObscured;
  @override
  void initState() {
    super.initState();
    isTextObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: ColorManager.textFieldBackground),
      borderRadius: BorderRadius.circular(widget.radius),
    );
    return SizedBox(
      width: widget.width,
      child: TextFormField(
        readOnly: widget.readOnly,
        validator: widget.validator,
        maxLines: widget.maxLines,
        obscureText: isTextObscured,
        // enableInteractiveSelection: false,
        onChanged: widget.onChange,
        keyboardType: widget.keyboardType,
        cursorColor: ColorManager.primaryColor,
        decoration: InputDecoration(
          border: border,
          enabledBorder: border,
          disabledBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          filled: true,
          fillColor: ColorManager.textFieldBackground,
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          isTextObscured = !isTextObscured;
                        });
                      },
                      icon: isTextObscured
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility)),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: ColorManager.textFieldBackground),
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
          ),
        ),
      ),
    );
  }
}
