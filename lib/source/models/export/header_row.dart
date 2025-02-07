// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'header_column.dart';

/// A class representing a header row
class HeaderRow {
  /// The unique identifier for the header row
  final int? id;

  /// List of  columns in the header row.
  List<HeaderColumn> columns;

  /// Creates a new instance of [HeaderRow]
  HeaderRow({
    this.id,
    required this.columns,
  });
}
