import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const DigitalCLockWidget(),
              Text('Current: ${DateFormat('yMMMEd').format(DateTime.now())}'),
            ],
          ),
        ),
      ),
    );
  }
}

class DigitalCLockWidget extends StatefulWidget {
  const DigitalCLockWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => DigitalCLockWidgetstate();
}

class DigitalCLockWidgetstate extends State<DigitalCLockWidget> {
  DateTime datesTime = DateTime.now();
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        datesTime = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormat('jms').format(datesTime),
      style: const TextStyle(
          fontSize: 40, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }
}

class Alarm extends StatefulWidget {
  const Alarm({super.key});

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  var listDate = [{}];
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: listDate.map((e) {
          return Card(
            shadowColor: Colors.grey,
            elevation: 7,
            child: ListTile(
                title: Text(
                  e['title'] == null ? 'Alarm Time' : "${e['title']}",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  e['title'] == null ? 'Ringtone Name' : "Ringtone1",
                  style: const TextStyle(fontSize: 12),
                ),
                trailing: e['title'] == null
                    ? const Text('on/off')
                    : Switch(
                        activeColor: Colors.blue,
                        value: flag,
                        onChanged: (value) {
                          flag = value;
                          setState(() {});
                        })),
          );
        }).toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Card(
        elevation: 5,
        child: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () async {
            TimeOfDay? datee = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              initialEntryMode: TimePickerEntryMode.input,
            ).then((value) {
              listDate.add({'title': value!.format(context)});
              setState(() {});
            });
          },
        ),
      ),
    );
  }
}
