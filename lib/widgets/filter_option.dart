import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterOption extends StatefulWidget {
  FilterOption(
      {super.key,
      required this.value,
      required this.title,
      required this.subtitle});

  bool value;
  final String title;
  final String subtitle;

  @override
  State<FilterOption> createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.value,
      onChanged: (isChecked) {
        setState(() {
          widget.value = isChecked;
        });
      },
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        widget.subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 16, right: 16),
    );
  }
}
