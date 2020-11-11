import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DisplayCalendar extends StatefulWidget {
  DisplayCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DisplayCalendarState createState() => _DisplayCalendarState();
}

class _DisplayCalendarState extends State<DisplayCalendar> {
  CalendarController _calendarController; //Part of calendar package
  Map<DateTime, List> _events; //Map of dates and events on that date
  List _selectedEvents;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: buildCalendar(context),
    );
  }

  Widget buildCalendar(BuildContext context) {
    return TableCalendar(
      availableCalendarFormats: {
        CalendarFormat.month: 'Week',
        CalendarFormat.twoWeeks: 'Month',
        CalendarFormat.week: '2 Week'
      },
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.sunday,
    );
  }
}
