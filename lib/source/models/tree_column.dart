// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Base class to represent a tree column
class TreeColumn {
  /// The index of the tree column
  final int? index;

  /// Widget to be displayed in the column
  final Widget widget;

  /// All rows for this column will be pinned to the left
  final bool pinLeft;

  /// All rows for this column will be pinned to the right
  final bool pinRight;

  /// Creates a new instance of [TreeColumn]
  TreeColumn({
    this.index,
    required this.widget,
    this.pinLeft = false,
    this.pinRight = false,
  });
}
