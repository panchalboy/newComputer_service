import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final TextInputType textInputType;
  final String labelText;
  final bool requiredPadding;
  final Function validator;
  final suffixIcon;
  final initialValue;
  final textfieldController;
  final Function onChange;
  final Function onSaved;
  final bool readonly;

  const CommonTextField({
    Key key,
    this.textInputType = TextInputType.text,
    this.labelText,
    this.requiredPadding = false,
    this.validator,
    this.suffixIcon = null,
    this.initialValue = null,
    this.textfieldController,
    this.onChange,
    this.onSaved,
    this.readonly,
  }) : super(key: key);

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool hiddentText = true;

  void _toggleVisibility() {
    setState(() {
      hiddentText = !hiddentText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.requiredPadding
          ? EdgeInsets.fromLTRB(20, 20, 20, 0)
          : EdgeInsets.all(1),
      child: TextFormField(
        controller: widget.textfieldController,
        keyboardType: widget.textInputType,
        autocorrect: true,
        initialValue: widget.initialValue != null ? widget.initialValue : null,
        obscureText: widget.textInputType == TextInputType.visiblePassword
            ? hiddentText
            : false,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.black45),
          // hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
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
        validator: (value) =>
            widget.validator != null ? widget.validator(value) : null,
        onChanged: (value) =>
            widget.onChange != null ? widget.onChange(value) : null,
        onSaved: (value) =>
            widget.onSaved != null ? widget.onSaved(value) : null,
        readOnly: widget.readonly,
      ),
    );
  }
}
