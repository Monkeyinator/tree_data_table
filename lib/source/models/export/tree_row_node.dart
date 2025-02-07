// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'tree_column.dart';

/// A class representing a node in a tree row
class TreeRowNode {
  /// The level of the node in the tree
  int? level;

  /// The list of child nodes
  final List<TreeRowNode> rows;

  /// Whether the node is expanded or not
  bool isExpanded;

  /// The list of columns in the node
  final List<TreeColumn> columns;

  /// Creates a new instance of [TreeRowNode]
  TreeRowNode({
    this.level,
    this.rows = const [],
    this.isExpanded = false,
    this.columns = const [],
  }) : assert(columns.isNotEmpty, 'Columns must not be empty');
}
