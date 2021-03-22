import 'package:Sterilizer/model/data.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ScheduleTile extends StatefulWidget {
  final ScheduleData scheduleData;

  ScheduleTile(this.scheduleData,{Key key}):super(key: key);

  @override
  _ScheduleTileState createState() => _ScheduleTileState(scheduleData);
}

class _ScheduleTileState extends State<ScheduleTile> {
  String startTime = "6:30";
  String endTime = "7:30";
  final ScheduleData scheduleData;

  @override
  void initState() {
    super.initState();
    endTime = scheduleData.endTime.hourOfPeriod == 0
        ? "12:"
        : scheduleData.endTime.hourOfPeriod.toString() + ":";
    endTime += scheduleData.endTime.minute < 10
        ? "0" + scheduleData.endTime.minute.toString()
        : scheduleData.endTime.minute.toString();
    startTime = scheduleData.startTime.hourOfPeriod == 0
        ? "12:"
        : scheduleData.startTime.hourOfPeriod.toString() + ":";
    startTime += scheduleData.startTime.minute < 10
        ? "0" + scheduleData.startTime.minute.toString()
        : scheduleData.startTime.minute.toString();
  }

  _ScheduleTileState(this.scheduleData);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.schedule_rounded,
                        // color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Schedule'),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      scheduleData.state = !scheduleData.state;
                      deviceList[0].updateSchedules();
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: FlareActor("assets/Toggle.flr",
                        alignment: Alignment.center,
                        fit: BoxFit.contain,
                        animation: scheduleData.state == true ? "on" : "off"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('START'),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Future<TimeOfDay> selectedTime = showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            selectedTime.then((value) {
                              if (value != null)
                                setState(() {
                                  scheduleData.startTime = value;
                                  startTime =
                                      scheduleData.startTime.hourOfPeriod == 0
                                          ? "12:"
                                          : scheduleData.startTime.hourOfPeriod
                                                  .toString() +
                                              ":";
                                  startTime +=
                                      scheduleData.startTime.minute < 10
                                          ? "0" +
                                              scheduleData.startTime.minute
                                                  .toString()
                                          : scheduleData.startTime.minute
                                              .toString();
                                  deviceList[0].updateSchedules();
                                });
                            });
                          },
                          child: Text(
                            startTime,
                            style: TextStyle(fontSize: 58),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                              scheduleData.startTime.hour >= 12 ? 'pm' : 'am'),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('END'),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Future<TimeOfDay> selectedTime = showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );
                            selectedTime.then((value) {
                              if (value != null)
                                setState(() {
                                  scheduleData.endTime = value;
                                  endTime =
                                      scheduleData.endTime.hourOfPeriod == 0
                                          ? "12:"
                                          : scheduleData.endTime.hourOfPeriod
                                                  .toString() +
                                              ":";
                                  endTime += scheduleData.endTime.minute < 10
                                      ? "0" +
                                          scheduleData.endTime.minute.toString()
                                      : scheduleData.endTime.minute.toString();
                                  deviceList[0].updateSchedules();
                                });
                            });
                          },
                          child: Text(
                            endTime,
                            style: TextStyle(fontSize: 58),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                              scheduleData.endTime.hour >= 12 ? 'pm' : 'am'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[0] = !scheduleData.days[0];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("S", scheduleData.days[0])),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[1] = !scheduleData.days[1];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("M", scheduleData.days[1])),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[2] = !scheduleData.days[2];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("T", scheduleData.days[2])),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[3] = !scheduleData.days[3];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("W", scheduleData.days[3])),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[4] = !scheduleData.days[4];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("T", scheduleData.days[4])),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[5] = !scheduleData.days[5];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("F", scheduleData.days[5])),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        scheduleData.days[6] = !scheduleData.days[6];
                        deviceList[0].updateSchedules();
                      });
                    },
                    child: WeekSelector("S", scheduleData.days[6])),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WeekSelector extends StatelessWidget {
  final String week;
  final bool isActive;

  const WeekSelector(this.week, this.isActive, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey[400] : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Text(
        week,
        style: TextStyle(
            color: isActive ? Colors.grey[100] : Colors.grey[500],
            fontSize: 16),
        textAlign: TextAlign.center,
      )),
    );
  }
}