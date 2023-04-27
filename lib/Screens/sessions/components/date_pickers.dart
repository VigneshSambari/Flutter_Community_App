// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/util_methods.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key, required this.size});
  final Size size;

  @override
  CustomCalendarWidgetState createState() => CustomCalendarWidgetState();
}

class CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Future<void> _showMonthYearPicker(BuildContext context) async {
    final DateTime? picked = await showMonthYearPicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime.utc(2020, 01, 01),
      lastDate: DateTime.utc(2100, 12, 31),
    );
    if (picked != null && picked != _focusedDay) {
      setState(() {
        _focusedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.65),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
        ),
      ),
      firstDay: DateTime.utc(2020, 01, 01),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });

        // Get the selected date and day
        String selectedDate = formatDate(date: selectedDay);
        String selectedDayOfWeek = formatDay(day: selectedDay);
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      onHeaderTapped: (date) async {
        await _showMonthYearPicker(context);
      },
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: kPrimaryDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        formatButtonVisible: false,
      ),
    );
  }
}

class MonthYearPicker extends StatefulWidget {
  @override
  MonthYearPickerState createState() => MonthYearPickerState();
}

class MonthYearPickerState extends State<MonthYearPicker> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    selectedMonth = now.month;
    selectedYear = now.year;
  }

  void _showMonthPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime(selectedYear, selectedMonth),
          onDateTimeChanged: (dateTime) {
            setState(() {
              selectedMonth = dateTime.month;
              selectedYear = dateTime.year;
            });
          },
        ),
      ),
    );
  }

  void _showYearPicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: DateTime(selectedYear),
          onDateTimeChanged: (dateTime) {
            setState(() {
              selectedYear = dateTime.year;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _showMonthPicker,
          child: Text(
            '${DateTime(2000, selectedMonth).month}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        GestureDetector(
          onTap: _showYearPicker,
          child: Text(
            '$selectedYear',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
