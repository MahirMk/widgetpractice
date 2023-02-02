import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/StyleResources.dart';

class MyTextFormField extends StatelessWidget {

 final TextEditingController? myController;
 final TextInputType? myTextInputType;
 final ValueChanged<String>? onChanged;
 final String? myHintText;
 final String? myLabel;
 final Widget? myIcon;
 final bool? obSecureText;
 final bool? enabled;
 final int? maxLength;
 final GlobalKey<FormFieldState>? textFieldKey;
 //final String?  Function(String?)? validator;
 final FormFieldValidator<String>? validator;
  const MyTextFormField({super.key, required this.myController,this.onChanged,this.myHintText,this.validator,this.myTextInputType,this.myLabel,this.myIcon, this.obSecureText, this.enabled, this.textFieldKey, this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal : 1.5.w,vertical: 1.5.h),
      child: TextFormField(
        //readOnly: true,
        key: textFieldKey,
        enabled: enabled??true,
        controller: myController,
        keyboardType: myTextInputType,
        onChanged: onChanged,
        validator: validator,
        obscureText: obSecureText??false,
        cursorColor: Theme.of(context).primaryColor,
        maxLength: maxLength,
        decoration: StyleResources.textFieldInputDecoration(context, myLabel, myIcon, myHintText)
      ),
    );
  }
}
