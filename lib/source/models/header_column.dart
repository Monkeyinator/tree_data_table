// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// A class representing a header column
class HeaderColumn {
  /// The unique identifier for the header column
  final int? id;

  /// The widget to be displayed in the header column
  final Widget widget;

  /// A flag indicating whether the header column should be hidden
  final bool hide;

  /// The width of the header column. Defaults to
  /// [IntrinsicWidth] that is relatively expensive
  final int? width;

  /// The height of the header column. Defaults to 55
  final int height;

  /// Creates a new instance of [HeaderColumn]
  HeaderColumn({
    this.id,
    required this.widget,
    this.hide = false,
    this.width,
    this.height = 55,
  });
}
