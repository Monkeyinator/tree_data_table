import 'package:flutter/material.dart';
import 'package:tree_data_table/tree_data_table.dart';

void main() {
  runApp(const TreeDataTableExample());
}

class TreeDataTableExample extends StatelessWidget {
  const TreeDataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tree Data Table',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TreeDataTablePage(),
    );
  }
}

class TreeDataTablePage extends StatefulWidget {
  const TreeDataTablePage({super.key});

  @override
  State<TreeDataTablePage> createState() => _TreeDataTablePageState();
}

class _TreeDataTablePageState extends State<TreeDataTablePage> {
  late List<HeaderRow> _headerRows;
  late List<TreeRowNode> _treeRowNodes;

  @override
  void initState() {
    super.initState();

    int length = 20;

    _headerRows = List.generate(
      1,
      (index) => HeaderRow(
        columns: List.generate(
          10,
          (index) => HeaderColumn(
            widget: Text(
              'Header Column $index',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            pinLeft: index == 0,
          ),
        ),
      ),
    );

    _treeRowNodes = List.generate(
      length,
      (index) => TreeRowNode(
        rows: List.generate(
          2,
          (childIndex) => TreeRowNode(
            rows: List.generate(
              (length / 8).toInt(),
              (grandChildIndex) => TreeRowNode(
                rows: List.generate(
                  (length / 16).toInt(),
                  (grandGrandChildIndex) => TreeRowNode(
                    columns: List.generate(
                      10,
                      (index) => TreeColumn(
                        widget: Text('Level 4 Column $index'),
                      ),
                    ),
                  ),
                ),
                columns: List.generate(
                  10,
                  (index) => TreeColumn(
                    widget: Text('Level 3 Column $index'),
                  ),
                ),
              ),
            ),
            columns: List.generate(
              10,
              (index) => TreeColumn(
                widget: Text('Level 2 Column $index'),
              ),
            ),
          ),
        ),
        columns: List.generate(
          10,
          (index) => TreeColumn(
            widget: Text('Level 1 Column $index'),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree Data Table'),
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          width: 900,
          child: Column(
            children: <Widget>[
              Expanded(
                child: TreeDataTable(
                  headerRows: _headerRows,
                  treeRowNodes: _treeRowNodes,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
