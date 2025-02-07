import 'dart:math';

import 'package:flutter/material.dart';

import 'models/export/header_row.dart';
import 'models/export/tree_row_node.dart';
import 'models/tree_column.dart';
import 'widget/grid_expansion_tile.dart';
import 'widget/grid_header.dart';

class TreeDataTable extends StatefulWidget {
  final List<HeaderRow> headerRows;
  final List<TreeRowNode> treeRowNodes;
  final int? maxLevel;
  final List<int>? rowsPerPage;

  const TreeDataTable({
    super.key,
    required this.headerRows,
    required this.treeRowNodes,
    this.maxLevel,
    this.rowsPerPage,
  }) : assert(headerRows.length == 1, 'Header rows must be 1');

  @override
  State<TreeDataTable> createState() => _TreeDataTableState();
}

class _TreeDataTableState extends State<TreeDataTable> {
  late PageController _pageController;

  int _maxLevel = 0;
  List<int>? _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    if (widget.maxLevel == null) {
      _calculateMaxLevel(widget.treeRowNodes);
    } else {
      _maxLevel = widget.maxLevel!;
    }
    _rowsPerPage = widget.rowsPerPage;
  }

  int _calculateMaxLevel(List<TreeRowNode> treeRowNodes, {int level = 0}) {
    for (var treeRowNode in treeRowNodes) {
      _maxLevel = max(_maxLevel, level);
      _calculateMaxLevel(treeRowNode.rows, level: level + 1);
    }
    return _maxLevel;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: _buildPagination(widget.headerRows, widget.treeRowNodes),
    );
  }

  void _buildRowsPerPage(List<TreeRowNode> treeRowNodes) {
    if (_rowsPerPage == null) {
      if (treeRowNodes.length <= 100) {
        _rowsPerPage = [5, 10, 25, -1];
      } else if (treeRowNodes.length <= 1000) {
        _rowsPerPage = [25, 50, 100, -1];
      } else {
        _rowsPerPage = [250, 500, 750, -1];
      }
    }
  }

  List<ListView> _buildPagination(List<HeaderRow> headerRows, List<TreeRowNode> dataRows) {
    _buildRowsPerPage(dataRows);

    List<List<TreeColumn>> rows = [];

    for (int columnIndex = 0; columnIndex < headerRows.last.columns.length; columnIndex++) {
      rows.add(_buildDataColumns(headerRows, dataRows, columnIndex));
    }

    return [
      ListView(
        children: [
          Row(
            children: [
              Row(
                children: rows.map((row) {
                  return IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: row.where((column) => column.pinLeft).map((column) {
                        return column.widget;
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: rows.map((row) {
                      return IntrinsicWidth(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: row.where((column) => !column.pinLeft && !column.pinRight).map((column) {
                            return column.widget;
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Row(
                children: rows.map((row) {
                  return IntrinsicWidth(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: row.where((column) => column.pinRight).map((column) {
                        return column.widget;
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    ];

    /*
    List<NodeIdentifier> nodeIdentifierList =
        treeNodes.identifier.where((identifier) => identifier.level == 0).toList();

    List<ListView> pages = [];
    int startIndex = 0;
    for (var counterRowsPerPage = 0; counterRowsPerPage < nodeIdentifierList.length;) {
      int endIndex;
      int position = counterRowsPerPage + _rowsPerPage![1];
      if (nodeIdentifierList.length > position) {
        endIndex = nodeIdentifierList[position].index;
      } else {
        endIndex = treeNodes.identifier.length;
      }
      pages.add(ListView(children: treeNodes.widget.sublist(startIndex, endIndex)));

      startIndex = endIndex;
      counterRowsPerPage += _rowsPerPage![1];
    }
    return pages;
    */
  }

  List<TreeColumn> _buildDataColumns(
    List<HeaderRow> headerRows,
    List<TreeRowNode> treeNodes,
    int columnIndex, {
    int level = 0,
    bool buildHeader = true,
    bool pinLeft = false,
    bool pinRight = false,
  }) {
    List<TreeColumn> columns = [];

    if (buildHeader) {
      for (int rowIndex = 0; rowIndex < headerRows.length; rowIndex++) {
        pinLeft = headerRows[rowIndex].columns[columnIndex].pinLeft;
        pinRight = headerRows[rowIndex].columns[columnIndex].pinRight;

        columns.add(
          TreeColumn(
            widget: _buildHeaderColumn(headerRows[rowIndex], columnIndex),
            pinLeft: pinLeft,
            pinRight: pinRight,
          ),
        );
      }

      buildHeader = false;
    }

    for (var treeNode in treeNodes) {
      columns.add(
        TreeColumn(
          widget: _buildDataColumn(treeNode, columnIndex, level),
          pinLeft: pinLeft,
          pinRight: pinRight,
        ),
      );

      if (treeNode.isExpanded) {
        List<TreeColumn> expandedTreeRowNode = _buildDataColumns(headerRows, treeNode.rows, columnIndex,
            level: level + 1, buildHeader: buildHeader, pinLeft: pinLeft, pinRight: pinRight);
        columns.addAll(expandedTreeRowNode);
      }
    }

    return columns;
  }

  Widget _buildHeaderColumn(HeaderRow headerRow, int columnIndex) {
    return GridHeader(
      maxLevel: _maxLevel,
      columnIndex: columnIndex,
      headerRow: headerRow,
    );
  }

  Widget _buildDataColumn(TreeRowNode treeNode, int columnIndex, int level) {
    return GridExpansionTile(
      level: level,
      maxLevel: _maxLevel,
      columnIndex: columnIndex,
      treeNode: treeNode,
      onExpansionChanged: (isExpanded) {
        setState(() {
          treeNode.isExpanded = !isExpanded;
        });
      },
    );
  }
}
