import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({Key? key}) : super(key: key);

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  TextEditingController dateController = TextEditingController();
  var age;
  var todaysDate;
  var selectedDateOfBirth;
  var year;
  var days;
  var months;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Age-Calculator"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.cyanAccent,
                child: TextFormField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Select Date Of Birth',
                  ),
                  onTap: () async {
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now(),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        setState(() {
                          selectedDateOfBirth = selectedDate;
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                        });
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter date.';
                    }
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  calculations();
                },
                child: Text("Calculate Age")),
            SizedBox(
              height: 30,
            ),
            completeDiff != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.cyanAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text("$completeDiff"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Seconds-${differenceinSec}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Minutes-${differenceinMin}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Hours-${differenceinHour}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Days-${differenceinDays}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Months-${differenceInMonths}"),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Years-${year.toStringAsFixed(0)}"),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ]),
    );
  }

  var differenceinSec;
  var differenceinMin;
  var differenceinHour;
  var differenceinDays;
  var differenceInMonths;
  var differenceInYears;
  var completeDiff;

  calculations() async {
    setState(() {
      debugPrint("Selected Date Of Birth Is-$selectedDateOfBirth");
      todaysDate = DateTime.now();

      differenceinSec =
          todaysDate.difference(selectedDateOfBirth).inSeconds.abs();
      debugPrint("differenceinSec-----------${differenceinSec}");

      differenceinMin =
          todaysDate.difference(selectedDateOfBirth).inMinutes.abs();
      debugPrint("differenceinMin-----------${differenceinMin}");

      differenceinHour = todaysDate.difference(selectedDateOfBirth).inHours.abs();
      debugPrint("differenceinHour-----------${differenceinHour}");

       differenceinDays = todaysDate.difference(selectedDateOfBirth).inDays;
      debugPrint("differenceinDays-----------${differenceinDays}");

      differenceInMonths = (todaysDate.difference(selectedDateOfBirth).inDays / 30).floor();
      debugPrint("differenceinDays-----------${differenceInMonths}");

      Duration dur = DateTime.now().difference(selectedDateOfBirth);
      differenceInYears = (dur.inDays / 365).floor().toString();
      debugPrint("differenceInYears-----------${differenceInYears}");
      year = dur.inDays / 365;
       months = dur.inDays % 365 / 30;
       days = dur.inDays % 365 % 30;
      completeDiff =
      "${year.floor()} years ${months.toStringAsFixed(2)} months${days} days";
      debugPrint(
          "differenceInYears-Months-Days-----------${year}years  ${months}months   ${days}days");
    });
  }
}
