import 'package:flutter/material.dart';

class StepContentWithEnum<T extends Enum> extends StatefulWidget {
  final List<T> items;
  final T item;
  final double itemWidth;
  final void Function(T?)? onChanged;
  const StepContentWithEnum(
      {super.key,
      required this.items,
      required this.item,
      required this.itemWidth,
      required this.onChanged});

  @override
  State<StepContentWithEnum<T>> createState() => _StepContentWithEnumState<T>();
}

class _StepContentWithEnumState<T extends Enum>
    extends State<StepContentWithEnum<T>> {
  List<Widget> choices = [];

  @override
  Widget build(BuildContext context) {
    int itemsLength = widget.items.length;
    for (int i = 0; i < itemsLength; i++) {
      choices.add(SizedBox(
        width: widget.itemWidth,
        child: RadioListTile<T>(
            value: widget.items[i],
            groupValue: widget.item,
            onChanged: widget.onChanged),
      ));
    }
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 600) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: choices,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: choices,
          ),
        );
      }
    });
  }
}
