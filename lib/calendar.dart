import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calendar",
          style: TextStyle(
              color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFFE0144C),
        centerTitle: true,
      ),
      body: content(),
    );
  }

  Widget content(){
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Text("Selected Day: " + today.toString().split(" ")[0],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE0144C),
            ),
          ),
          Container(
            child: TableCalendar(
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: _onDaySelected,
            ),
          ),
        ],
      ),
    );
  }
}
