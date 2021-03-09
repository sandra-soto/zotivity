import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/53479942/checkbox-form-validation
class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      // FormFieldValidator<bool> validator,
      bool initialValue = false,
      // bool autovalidate = false
      })
      : super(
            onSaved: onSaved,
            // validator: validator,
            initialValue: initialValue,
            // autovalidate: autovalidate,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                activeColor: const Color.fromRGBO(255, 210, 0, 1),
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) =>  Text(
                          state.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}