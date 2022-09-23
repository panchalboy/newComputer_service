import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatefulWidget {
  final TextInputType textInputType;
  final String labelText;
  final String hintText;
  final bool requiredPadding;
  final Function validator;
  final Function onSaved;
  final Function onChange;
  final Function onSubmitted;
  bool autofocus;
  final prefixIcon;
  final suffixIcon;
  final initialValue;
  final bool enabled;
  Widget suffixActions;
  Widget prefixActions;
  final maxLength;
  final maxLine;
  final counter;
  TextInputAction textInputAction;
  TextFieldWidget(
      {Key key,
      this.textInputType = TextInputType.text,
      this.enabled = true,
      @required this.labelText,
      this.hintText,
      this.requiredPadding = false,
      this.validator,
      this.suffixIcon = null,
      this.prefixIcon = null,
      this.onSaved,
      this.maxLine = 1,
      this.initialValue = null,
      this.onChange,
      this.suffixActions = const SizedBox(),
      this.prefixActions = const SizedBox(),
      this.autofocus = false,
      this.textInputAction = TextInputAction.next,
      this.onSubmitted = null,
      this.counter,
      this.maxLength})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool hiddentText = true;

  void _toggleVisibility() {
    setState(() {
      hiddentText = !hiddentText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller:loginController.email,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
      maxLines: widget.maxLine,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: (v) =>
          widget.onSubmitted != null ? widget.onSubmitted(v) : null,
      onChanged: (value) =>
          widget.onChange != null ? widget.onChange(value) : null,
      onSaved: (value) => widget.onSaved != null ? widget.onSaved(value) : null,
      validator: (value) =>
          widget.validator != null ? widget.validator(value) : null,
      obscureText: widget.textInputType == TextInputType.visiblePassword
          ? hiddentText
          : false,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      // initialValue: 'alucard@gmail.com',
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(fontSize: 16.0, color: Colors.grey)),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        errorStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),

        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
        // border: InputBorder.none,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.textInputType == TextInputType.visiblePassword
            ? Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  icon: hiddentText
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                  onPressed: _toggleVisibility,
                ),
              )
            : widget.suffixIcon != null
                ? widget.suffixIcon
                : null,
      ),
    );
  }
}
