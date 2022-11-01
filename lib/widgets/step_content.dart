import 'package:flutter/material.dart';

class StepContentWithEnum<T extends Enum> extends StatelessWidget {
  final List<T> values;
  final T item;
  final double itemWidth;
  final double itemHeight;
  final void Function(T?)? onChanged;
  final List<Widget> choices = [];
  StepContentWithEnum(
      {super.key,
      required this.values,
      required this.item,
      required this.itemWidth,
      required this.itemHeight,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    int itemsLength = values.length;
    for (int i = 0; i < itemsLength; i++) {
      choices.add(SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: RadioListTile<T>(
            title: Text(values[i].toString()),
            value: values[i],
            groupValue: item,
            onChanged: onChanged),
      ));
    }
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 600) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices,
          ),
        );
      }
    });
  }
}

class StepContentWithBoolean extends StatelessWidget {
  final bool item;
  final double itemWidth;
  final double itemHeight;
  final void Function(bool?)? onChanged;
  final List<Widget> choices = [];
  StepContentWithBoolean(
      {super.key,
      required this.item,
      required this.itemWidth,
      required this.itemHeight,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    choices.add(SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: RadioListTile<bool>(
          title: const Text('Yes'),
          value: true,
          groupValue: item,
          onChanged: onChanged),
    ));
    choices.add(SizedBox(
      width: itemWidth,
      height: itemHeight,
      child: RadioListTile<bool>(
          title: const Text('No'),
          value: false,
          groupValue: item,
          onChanged: onChanged),
    ));

    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 600) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: choices,
          ),
        );
      }
    });
  }
}
