// Copyright (c) 2025 Tim Lindner
// SPDX-License-Identifier: MIT

import 'package:flutter/material.dart';

import '../models/export/header_row.dart';

class GridHeader extends StatefulWidget {
  final int maxLevel;
  final int columnIndex;
  final HeaderRow headerRow;

  const GridHeader({
    super.key,
    required this.maxLevel,
    required this.columnIndex,
    required this.headerRow,
  });

  @override
  State<GridHeader> createState() => _GridHeaderState();
}

class _GridHeaderState extends State<GridHeader> {
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
            top: BorderSide(
              width: 1.0,
            ),
            bottom: BorderSide(
              width: 1.0,
            ),
          ),
        ),
        child: widget.columnIndex == 0
            ? Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.expand_more,
                    ),
                    disabledColor: Colors.transparent,
                    onPressed: null,
                  ),
                  widget.headerRow.columns[widget.columnIndex].widget,
                  Padding(
                    padding: EdgeInsets.only(left: widget.maxLevel * 12.0),
                  ),
                ],
              )
            : Center(
                child: widget.headerRow.columns[widget.columnIndex].widget,
              ),
      ),
    );
  }
}
