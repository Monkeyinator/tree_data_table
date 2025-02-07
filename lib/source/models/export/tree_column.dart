// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

/// Base class to represent a tree column
class TreeColumn {
  /// The index of the tree column
  final int? index;

  /// Widget to be displayed in the column
  final Widget widget;

  /// Creates a new instance of [TreeColumn]
  TreeColumn({
    this.index,
    required this.widget,
  });
}
