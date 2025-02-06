// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../models/tree_row_node.dart';

class GridExpansionTile extends StatefulWidget {
  final int level;
  final int maxLevel;
  final int columnIndex;
  final TreeRowNode treeNode;
  final ValueChanged<bool>? onExpansionChanged;

  const GridExpansionTile({
    super.key,
    required this.level,
    required this.maxLevel,
    required this.columnIndex,
    required this.treeNode,
    this.onExpansionChanged,
  });

  @override
  State<GridExpansionTile> createState() => _GridExpansionTileState();
}

class _GridExpansionTileState extends State<GridExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 51,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
            ),
          ),
        ),
        child: widget.columnIndex == 0
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widget.level * 12.0),
                    child: IconButton(
                      icon: Icon(
                        widget.treeNode.isExpanded ? Icons.expand_less : Icons.expand_more,
                      ),
                      disabledColor: Colors.transparent,
                      onPressed: widget.treeNode.rows.isNotEmpty ? () => _handleTap(widget.treeNode) : null,
                    ),
                  ),
                  widget.treeNode.columns[widget.columnIndex].widget,
                ],
              )
            : Center(
                child: widget.treeNode.columns[widget.columnIndex].widget,
              ),
      ),
    );
  }

  void _handleTap(TreeRowNode treeNode) {
    widget.onExpansionChanged?.call(treeNode.isExpanded);
  }
}
