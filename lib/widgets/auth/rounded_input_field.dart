import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_management/helpers/sizes_helpers.dart';
import 'package:task_management/widgets/auth/text_field_container.dart';
import '../../constants.dart';

class RoundedInputField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final onTap;
  final Function(String?)? onSave;
  final ValueChanged<String>? onSubmitted;
  final onEditingComplete;
  final bool readOnlyFlag;
  final String? errorText;
  final String? Function(String?)? validator;

  const RoundedInputField({
    Key? key,
    this.labelText,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.onSave,
    this.readOnlyFlag = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.onEditingComplete,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: TextFieldContainer(
        child: Center(
          child: TextFormField(
            keyboardType: keyboardType,
            enableInteractiveSelection: true,
            onTap: onTap,
            validator: validator,
            onSaved: onSave,
            onFieldSubmitted: onSubmitted,
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            cursorColor: kPrimaryColor,
            readOnly: readOnlyFlag,
            scrollPadding: EdgeInsets.all(0),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: Theme.of(context).textTheme.subtitle2,
              errorText: errorText,
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.only(
                bottom: displayHeight(context) * 0.02,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              icon: Icon(
                icon,
                color: kPrimaryColor,
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.subtitle2,
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
