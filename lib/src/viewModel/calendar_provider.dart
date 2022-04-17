
import 'dart:collection';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/src/model/meeting.dart';
import 'package:machine_test/src/utility/status.dart';

class CalendarProvider extends ChangeNotifier{
  ProviderStatus status=ProviderStatus.IDLE;
  List<Meeting>eventList=[];
  List<Calendar>? calendars;
  List<UnmodifiableListView<Event>> calEventsList = [];

  DeviceCalendarPlugin _deviceCalendarPlugin = new DeviceCalendarPlugin();

  getUsersCalendar() async {
    print('getUsersCalendar running');
    status=ProviderStatus.LOADING;
    notifyListeners();
    try {
      var permissionGranted = await _deviceCalendarPlugin.hasPermissions();
      if (permissionGranted.isSuccess && !permissionGranted.data!) {
        permissionGranted = await _deviceCalendarPlugin.requestPermissions();

        if (!permissionGranted.isSuccess || !permissionGranted.data!) {
          return;
        }
      }
      final startDate = DateTime.now().add(Duration(days: -30));
      final endDate = DateTime.now().add(Duration(days: 30));
      final calResult = await _deviceCalendarPlugin.retrieveCalendars();
      calendars = calResult.data;
      for (int i = 0; i < calendars!.length; i++) {
        final calEvents = await _deviceCalendarPlugin.retrieveEvents(
            calendars![i].id,
            RetrieveEventsParams(startDate: startDate, endDate: endDate));
        calEventsList.add(calEvents.data!);

        eventList.clear();
        notifyListeners();
        calEventsList[0].forEach((element) {
          eventList.add(
              Meeting(
                element.title!,
                  DateTime.parse(element.start.toString()),
                DateTime.parse(element.end.toString()),
                  const Color(0xFF0F8644), false
              )
          );
        });
        status=ProviderStatus.LOADED;
        notifyListeners();
      }
    } catch (e) {
      status=ProviderStatus.ERROR;
      notifyListeners();
    }
  }

}
