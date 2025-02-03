import '../../untils/export_file.dart';

class RangePickerDialog extends StatefulWidget {
  const RangePickerDialog({super.key});

  @override
  State<RangePickerDialog> createState() => _RangePickerDialogState();
}

class _RangePickerDialogState extends State<RangePickerDialog> {
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${args.value.startDate} -'
            // ignore: lines_longer_than_80_chars
            ' ${args.value.endDate ?? args.value.startDate}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SfDateRangePicker(
      enablePastDates: false,
      startRangeSelectionColor: KOrange,
      selectionColor: KOrange,
      rangeSelectionColor: KOrange.withOpacity(0.3),
      endRangeSelectionColor: KOrange,
      view: DateRangePickerView.month,
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.range,
    )
// SfDateRangePicker(
//  view: DateRangePickerView.month,
// selectionMode: DateRangePickerSelectionMode.single,onSelectionChanged: _onSelectionChanged,
// )
        );
  }
}
