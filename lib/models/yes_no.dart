//[0]: Yes - true
//[1]: No - false

enum YesNo {
  yes(true),
  no(false);

  final bool isTrue;
  const YesNo(this.isTrue);

  bool toBool() => isTrue;
}

extension YesNoExt on bool {
  YesNo toYesNo() => this ? YesNo.yes : YesNo.no;
}
