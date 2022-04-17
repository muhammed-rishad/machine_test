import 'package:flutter/material.dart';
import 'package:machine_test/src/utility/status.dart';
import 'package:machine_test/src/view/page_product_list.dart';
import 'package:machine_test/src/viewModel/calendar_provider.dart';
import 'package:machine_test/src/viewModel/meetingDataSource.dart';
import 'package:machine_test/src/viewModel/product_provider.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class PageCalendar extends StatelessWidget {
  const PageCalendar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      context.read<CalendarProvider>().getUsersCalendar();
    });
     return Scaffold(
        body: SafeArea(
            child:Consumer<CalendarProvider>(
              builder: (context,provider,child){
                if(provider.status==ProviderStatus.LOADED){
                  return SfCalendar(
                    view: CalendarView.month,
                    dataSource: MeetingDataSource(provider.eventList),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                  );
                }else if(provider.status==ProviderStatus.ERROR){
                  return Center(child: Text('Something error !!!'),);
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
        ));
  }
}
