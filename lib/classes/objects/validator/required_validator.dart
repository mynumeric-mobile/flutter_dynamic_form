import 'package:easy_form_builder/classes/helper/localization.dart';

import 'validator.dart';

class RequiredValidator extends Validator {
  final String? message;

  ///
  /// Required validator
  ///
  RequiredValidator({this.message});

  @override
  String get errorMessage => message ?? localizationOptions.emptyField;

  @override
  bool isValid(value, Map<String, dynamic> paramValues) {
    return value != null && (value! is String && value.isNotEmpty);
  }
}
