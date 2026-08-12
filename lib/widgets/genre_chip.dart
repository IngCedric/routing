import 'package:flutter/material.dart';

class GenreChip extends StatelessWidget {
  final String genre;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  const GenreChip({
    super.key,
    required this.genre,
    this.onSelected,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(genre),
      selected: selected,
      onSelected: onSelected != null ? (value) => onSelected!(value) : null,
    );
  }
}
