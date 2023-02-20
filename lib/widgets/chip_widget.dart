import 'package:flutter/material.dart';
import 'package:medtrack/constants/app_constants.dart';

class ChipWidget extends StatelessWidget {
  final List<TagWidget> tags;
  final Function(bool)? selected;

  const ChipWidget({Key? key, required this.tags, this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          children: tagPosition.toList(),
        ),
      ],
    );
  }

  Iterable<Widget> get tagPosition sync* {
    List<String>? _filters;
    _filters = <String>[];

    for (TagWidget tag in tags) {
      yield Padding(
        padding: const EdgeInsets.all(2.0),
        child: FilterChip(
            elevation: 5.0,
            backgroundColor: tag.backgroundColor,
            /*avatar: CircleAvatar(
            backgroundColor: tag.backgroundColor,
            child: Text(
              tag.name[0].toUpperCase(),
              style: TextStyle(color: AppConstants.accentColor),
            ),
          ),*/
            label: Text(
              tag.name,
              style: TextStyle(
                  color: AppConstants.accentColor, fontWeight: FontWeight.w500),
            ),
            selected: _filters.contains(tag.name),
            selectedColor: tag.backgroundColor,
            onSelected: selected),
      );
    }
  }
}

class TagWidget {
  const TagWidget(this.name, this.backgroundColor);

  final String name;
  final Color backgroundColor;
}
