import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class PasswordTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? visibilityOnIcon;
  final IconData? visibilityOffIcon;
  final TextInputType inputType;
  final bool initiallyObscured;
  final ValueChanged<bool>? onVisibilityChanged;

  const PasswordTextField({
    super.key,
    required this.title,
    this.controller,
    this.hintText = '',
    this.prefixIcon,
    this.visibilityOnIcon = Icons.visibility,
    this.visibilityOffIcon = Icons.visibility_off,
    this.initiallyObscured = true,
    this.onVisibilityChanged,
    this.inputType = TextInputType.text,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.initiallyObscured;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
    if (widget.onVisibilityChanged != null) {
      widget.onVisibilityChanged!(_obscureText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialRounded(
      child: TextField(
        obscureText: _obscureText,
        controller: widget.controller,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon:
              widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: ColorStyle.dark)
                  : null,
          suffixIcon: InkWell(
            onTap: _toggleVisibility,
            child: Icon(
              _obscureText ? widget.visibilityOffIcon : widget.visibilityOnIcon,
              color: ColorStyle.dark,
            ),
          ),
          label: Text(
            widget.title,
            style: TextStyle(color: ColorStyle.dark, fontSize: 14.sp),
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.sp),
            borderSide: BorderSide.none,
          ),
          filled: true,
          contentPadding: EdgeInsets.all(16),
          fillColor: ColorStyle.white,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: ColorStyle.dark.withOpacity(0.5),
          ),
        ),
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorStyle.dark.withOpacity(0.5),
        ),
      ),
    );
  }
}
