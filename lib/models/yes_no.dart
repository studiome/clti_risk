enum YesNo {
  yes('Yes', true),
  no('No', false);

  final String name;
  final bool isTrue;
  const YesNo(this.name, this.isTrue);

  @override
  String toString() => name;

  bool toBool() => isTrue;
}

extension EnumExt on bool {
  YesNo toBoolean() => this ? YesNo.yes : YesNo.no;
}
