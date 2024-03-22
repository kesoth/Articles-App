import 'package:flutter/material.dart';

class MyTable extends StatefulWidget {
  final List<String> textFieldValues;
  final List<DateTime?> selectedDates;
  final Function(List<String>, List<DateTime?>) onUpdate;

  const MyTable({
    Key? key,
    required this.textFieldValues,
    required this.selectedDates,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _MyTableState createState() => _MyTableState();
}

class _MyTableState extends State<MyTable> {
  late final List<DataRow> _rows;
  late final List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _textControllers = List.generate(20,
        (index) => TextEditingController(text: widget.textFieldValues[index]));
    _rows = List<DataRow>.generate(
      10,
      (index) => DataRow(
        cells: [
          DataCell(TextField(
            controller: _textControllers[index * 2],
            onChanged: (_) => _updateTableData(),
          )),
          DataCell(TextField(
            controller: _textControllers[index * 2 + 1],
            onChanged: (_) => _updateTableData(),
          )),
          DataCell(_DateCell(
            initialDate: widget.selectedDates[index],
            onDateSelected: (DateTime? date) {
              setState(() {
                widget.selectedDates[index] = date;
              });
              _updateTableData();
            },
          )),
          DataCell(_DateCell(
            initialDate: widget.selectedDates[index],
            onDateSelected: (DateTime? date) {
              setState(() {
                widget.selectedDates[index] = date;
              });
              _updateTableData();
            },
          )),
        ],
      ),
    );
  }

  void _updateTableData() {
    List<String> textFieldValues =
        _textControllers.map((controller) => controller.text).toList();
    widget.onUpdate(textFieldValues, widget.selectedDates);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('How Much')),
                DataColumn(label: Text('Beginning')),
                DataColumn(label: Text('End')),
              ],
              rows: _rows,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (final controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}

class _DateCell extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime?>? onDateSelected;

  const _DateCell({Key? key, this.initialDate, this.onDateSelected})
      : super(key: key);

  @override
  _DateCellState createState() => _DateCellState();
}

class _DateCellState extends State<_DateCell> {
  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (picked != null && widget.onDateSelected != null) {
          setState(() {
            _selectedDate = picked;
          });
          widget.onDateSelected!(picked);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 8.0),
            Text(_selectedDate != null
                ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                : ''),
          ],
        ),
      ),
    );
  }
}
