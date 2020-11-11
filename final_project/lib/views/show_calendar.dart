import 'package:final_project/model/DBUtils.dart';
import 'package:final_project/model/events/event.dart';
import 'package:final_project/model/events/eventModel.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:final_project/model/utils.dart';

class DisplayCalendar extends StatefulWidget {
  DisplayCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DisplayCalendarState createState() => _DisplayCalendarState();
}

// Will show the days you went to workout within the past 30 days. (Can expand 30 days but files would get too large)

class _DisplayCalendarState extends State<DisplayCalendar> {
  CalendarController _calendarController; //Part of calendar package
  Map<DateTime, List> _events; //Map of dates and events on that date
  List _selectedEvents;
  EventModel _model = EventModel();
  List<Event> eventList;
  var _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    reload();
    print(toDateString(_today));
  }

  void reload() {
    DBUtils.init().then((_) {
      _model.getAllEvents().then((events) {
        setState(() {
          eventList = events;
        });
      });
    });
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
