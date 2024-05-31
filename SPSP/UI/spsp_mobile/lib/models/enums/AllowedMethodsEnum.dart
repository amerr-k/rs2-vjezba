enum AllowedMethodsEnum {
  update,
  cancel,
  confirm,
}

extension AllowedMethodsEnumExtension on AllowedMethodsEnum {
  String get value {
    switch (this) {
      case AllowedMethodsEnum.update:
        return 'Ažuriraj';
      case AllowedMethodsEnum.cancel:
        return 'Otkaži';
      case AllowedMethodsEnum.confirm:
        return 'Potvrdi';
    }
  }
}

final Map<String, AllowedMethodsEnum> _stringToEnum = {
  'update': AllowedMethodsEnum.update,
  'cancel': AllowedMethodsEnum.cancel,
  'confirm': AllowedMethodsEnum.confirm,
};

AllowedMethodsEnum enumFromString(String value) {
  if (!_stringToEnum.containsKey(value)) {
    throw ArgumentError('Invalid value: $value');
  }
  return _stringToEnum[value]!;
}
