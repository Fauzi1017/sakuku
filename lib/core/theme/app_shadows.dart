import 'package:flutter/material.dart';

/// Shadow tokens — ported 1:1 from `designtokens.css`.
abstract final class AppShadows {
  static const sm = [
    BoxShadow(
      color: Color.fromRGBO(42, 26, 10, 0.06),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  static const md = [
    BoxShadow(
      color: Color.fromRGBO(42, 26, 10, 0.08),
      offset: Offset(0, 4),
      blurRadius: 8,
    ),
  ];

  static const lg = [
    BoxShadow(
      color: Color.fromRGBO(42, 26, 10, 0.12),
      offset: Offset(0, 10),
      blurRadius: 20,
    ),
  ];
}
