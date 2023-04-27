// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_init_to_null, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:sessions/components/appbar.dart';
import 'package:sessions/components/buttons.dart';
import 'package:sessions/components/drop_downs.dart';
import 'package:sessions/components/trays.dart';
import 'package:sessions/components/utils.dart';
import 'package:sessions/constants.dart';
import 'package:sessions/utils/enums.dart';
import 'package:sessions/utils/navigations.dart';

class CreateSession extends StatefulWidget {
  const CreateSession({super.key});

  @override
  State<CreateSession> createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  String path = "", field = "";
  TimeOfDay? startTime, endTime;
  DateTime? startDate, endDate;
  List<String> typeDropDown = [
    "Electronics",
    "Computer Science",
    "Mechanical",
    "UPSC",
    "Civil",
    "Production",
    "Medical",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
  }

  void setDropDownValue({required String? value, required DropTypes dropType}) {
    if (value == null) {
      return;
    }
    setState(() {
      field;
    });
    field = value;
  }

  void addCoverPhoto(String path) {
    setState(() {
      this.path = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CurvedAppBar(
        title: "Create Session",
        actions: [],
        leading: BackButtonNav(),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              LandScapePhotoTray(
                addCoverPhoto: addCoverPhoto,
                coverPhoto: path,
              ),
              EntryField(
                hintText: "Enter your title",
                title: "Title",
                maxLines: 1,
                maxLength: 50,
              ),
              EntryField(
                hintText: "Description of the session",
                title: "Description",
                maxLines: 10,
              ),
              DropDownWithTitle(
                typeDropDown: typeDropDown,
                setDropDownValue: setDropDownValue,
                title: "Select session field",
                dropDowntitle: "Electronics, mechanical...",
              ),
              field == "Other"
                  ? EntryField(
                      hintText: "Enter the field",
                      title: "Field",
                      maxLines: 1,
                      maxLength: null,
                    )
                  : SizedBox(),
              DropDownWithTitle(
                typeDropDown: ["Private", "Public"],
                setDropDownValue: setDropDownValue,
                title: "Select session type",
                dropDowntitle: "Private, public...",
              ),
              EntryField(
                hintText: "Pay amount in rupees...",
                title: "Pay amount",
                inputType: TextInputType.number,
              ),
              EntryField(
                hintText: "Start date",
                title: "Start date",
                suffix: MyDatePicker(),
              ),
              EntryField(
                hintText: "End date",
                title: "End date",
                suffix: MyDatePicker(),
              ),
              Row(
                children: [
                  Expanded(
                    child: EntryField(
                      hintText: "Start time",
                      title: "Start time",
                      suffix: TimePickerWidget(),
                    ),
                  ),
                  Expanded(
                    child: EntryField(
                      hintText: "Start time",
                      title: "End time",
                      suffix: TimePickerWidget(),
                    ),
                  ),
                ],
              ),
              DropDownWithTitle(
                typeDropDown: ["Daily", "Weekly", "Monthly"],
                setDropDownValue: setDropDownValue,
                title: "Repeat",
                dropDowntitle: "Daily, Weekly...",
              ),
              RoundedButton(
                  title: "Create",
                  onPress: () {
                    navigatorPop(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownWithTitle extends StatelessWidget {
  final List<String> typeDropDown;
  final Function setDropDownValue;
  final String title, dropDowntitle;
  const DropDownWithTitle({
    super.key,
    required this.typeDropDown,
    required this.setDropDownValue,
    required this.title,
    required this.dropDowntitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryDarkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          CustomDropdownButton(
            dropType: DropTypes.roomTypeDropDown,
            prefixIcon: Icons.chat,
            options: typeDropDown,
            fieldName: dropDowntitle,
            changeValue: setDropDownValue,
            sharpCorner: true,
          ),
        ],
      ),
    );
  }
}

class MyDatePicker extends StatefulWidget {
  @override
  MyDatePickerState createState() => MyDatePickerState();
}

class MyDatePickerState extends State<MyDatePicker> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.calendar_today,
        color: kPrimaryColor,
      ),
      onPressed: () => _selectDate(context),
    );
  }
}

class TimePickerWidget extends StatefulWidget {
  @override
  TimePickerWidgetState createState() => TimePickerWidgetState();
}

class TimePickerWidgetState extends State<TimePickerWidget> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.access_time,
        color: kPrimaryColor,
      ),
      onPressed: () async {
        final TimeOfDay? newTime = await showTimePicker(
          context: context,
          initialTime: _selectedTime,
        );
        if (newTime != null) {
          setState(() {
            _selectedTime = newTime;
          });
        }
      },
    );
  }
}

class EntryField extends StatelessWidget {
  final String? title, hintText;
  final int? maxLines, maxLength;
  final TextInputType inputType;
  final Widget suffix;
  EntryField({
    super.key,
    this.title,
    this.hintText,
    this.maxLines = 1,
    this.maxLength,
    this.inputType = TextInputType.text,
    this.suffix = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: 16,
              color: kPrimaryDarkColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          BlueOutlinedInputField(
            hintText: hintText,
            maxLength: maxLength,
            maxLines: maxLines,
            inputType: inputType,
            suffix: suffix,
          ),
        ],
      ),
    );
  }
}

class BlueOutlinedInputField extends StatelessWidget {
  final String? hintText;
  final TextInputType inputType;
  final int? maxLines, maxLength;
  final Widget suffix;
  const BlueOutlinedInputField({
    super.key,
    this.hintText,
    this.maxLength,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.suffix = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: inputType,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: 1,
      decoration: InputDecoration(
        suffixIcon: suffix,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: kPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
