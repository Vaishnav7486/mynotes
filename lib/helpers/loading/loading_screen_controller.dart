import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show immutable;

typedef ClosedLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenColtroller {
  final ClosedLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenColtroller({
    required this.close,
    required this.update,
  });
}
