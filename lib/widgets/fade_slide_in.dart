import 'package:flutter/material.dart';

/// Fait apparaitre son enfant en fondu avec une legere montee.
///
/// L'`index` decale l'arrivee de chaque element : plus il est grand, plus
/// l'animation est longue, ce qui produit un effet de cascade dans une liste
/// sans avoir a gerer de controleur d'animation.
class FadeSlideIn extends StatelessWidget {
  final Widget child;
  final int index;

  /// Distance de depart, en pixels, sous la position finale.
  final double decalage;

  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.decalage = 18,
  });

  @override
  Widget build(BuildContext context) {
    // Plafonne le decalage pour que le bas d'une longue liste reste reactif.
    final duree = Duration(milliseconds: 320 + (index.clamp(0, 8) * 55));

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duree,
      curve: Curves.easeOutCubic,
      builder: (context, valeur, enfant) {
        return Opacity(
          opacity: valeur,
          child: Transform.translate(
            offset: Offset(0, (1 - valeur) * decalage),
            child: enfant,
          ),
        );
      },
      child: child,
    );
  }
}
