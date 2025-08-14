import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class TShawdowStyle{

  static final verticalbordershowdow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0,2)
  );
  static final horizondalbordershowdow = BoxShadow(
    color: TColors.darkGrey.withOpacity(0.1),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0,2)
  );
}