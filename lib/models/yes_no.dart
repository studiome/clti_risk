//[0]: Yes - true
//[1]: No - false

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

extension YesNoExt on bool {
  YesNo toYesNo() => this ? YesNo.yes : YesNo.no;
}
