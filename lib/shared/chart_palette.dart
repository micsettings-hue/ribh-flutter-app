import 'package:flutter/material.dart';

/// Categorical chart palette for identity encoding (e.g. sectors in the Grow
/// diversification donut). Assigned in fixed order, never cycled; a slot maps
/// to an entity, not to its rank. Both ramps are validated with the dataviz
/// skill's checker (lightness band, chroma floor, CVD separation, normal-
/// vision floor, contrast) against the app's light and dark chart surfaces.
/// Light: brand teal and gold lead, then distinct validated hues.
const _lightCategorical = <Color>[
  Color(0xFF0FA67A), // teal (brand)
  Color(0xFFC99A2E), // gold (brand)
  Color(0xFF2A78D6), // blue
  Color(0xFFE87BA4), // magenta
  Color(0xFF4A3AA7), // violet
  Color(0xFFEB6834), // orange
];

const _darkCategorical = <Color>[
  Color(0xFF199E70), // teal
  Color(0xFFC98500), // gold
  Color(0xFF3987E5), // blue
  Color(0xFFD55181), // magenta
  Color(0xFF9085E9), // violet
  Color(0xFFD95926), // orange
];

/// The categorical palette for the current theme brightness. Callers index by
/// a stable entity order and fold a 7th+ entity into an "Other" slice rather
/// than generating a new hue.
List<Color> categoricalPalette(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? _darkCategorical
    : _lightCategorical;
