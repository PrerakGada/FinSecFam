import 'package:finsec/features/profile/transfer/family_sheets/mom_sheet_1.dart';
import 'package:finsec/features/profile/transfer/family_sheets/papa_sheet_2.dart';
import 'package:finsec/utils/utils.dart';
import 'package:finsec/widgets/custom_chip_row.dart';
import 'package:finsec/widgets/primary_textfield.dart';
import 'package:finsec/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:table_calendar/table_calendar.dart';

class MoneyManagerScreen extends StatefulWidget {
  const MoneyManagerScreen({Key? key}) : super(key: key);

  @override
  State<MoneyManagerScreen> createState() => _MoneyManagerScreenState();
}

class _MoneyManagerScreenState extends State<MoneyManagerScreen> {
  DateTime selectedDate = DateTime.now();
  final Map<DateTime, List<String>> events = {
    DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day): ['Prerak paid \$450', 'Prinkal earned \$50'],
    DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1): ['Arnav invested \$500'],
    // add more events as needed
  };
  var _calendarFormat = CalendarFormat.month;
  var _selectedDay = DateTime.now();
  var _focusedDay = DateTime.now();
  int selectedIndex = 0;
  final amountController = TextEditingController();
  final descriptionController = TextEditingController();
  final accountController = TextEditingController();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Money Manager"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Back Button
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month - 1,
                    );
                  });
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),

              // Month and Year
              Text(
                "${DateFormat('MMM yyyy').format(selectedDate)}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Forward Button
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month + 1,
                    );
                  });
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomChipRow(
            selectedIndex: selectedIndex,
            testList: const [
              "Daily",
              "Calendar",
              "Monthly",
              "Summary",
            ],
            onSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            isiOS: false,
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.now(),
            calendarFormat: _calendarFormat,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay; // update `_focusedDay` here as well
                showDialog(
                    context: context,
                    builder: (context) {
                      final events = this.events[DateTime.utc(selectedDay.year, selectedDay.month, selectedDay.day)] ?? [];
                      return SimpleDialog(
                        title: Text('Transactions on ${DateFormat.yMd().format(selectedDay)}'),
                        children: events.map((event) => ListTile(title: Text(event))).toList(),
                      );
                    });
              });
            },
            eventLoader: (day) {
              print(events);
              return events[day] ?? [];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: Text("btn1"),
        onPressed: () {
          // Add new transaction
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Add a Transaction", style: Typo.titleLarge),
                      const SizedBox(height: 10),
                      // Date Picker
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((selectedDate) {
                            if (selectedDate != null) {
                              setState(() {
                                selectedDate = selectedDate;
                              });
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 10),
                              Text(
                                DateFormat('dd/MM/yyyy').format(selectedDate),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 52,
                        child: TextField(
                          controller: amountController,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: "Amount",
                            labelText: "Amount",
                            alignLabelWithHint: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      PrimaryTextField(
                        controller: descriptionController,
                        hintText: "Description",
                        labelText: "Description",
                      ),
                      const SizedBox(height: 10),
                      PrimaryTextField(
                        controller: accountController,
                        hintText: "Account",
                        labelText: "Account",
                      ),
                      const SizedBox(height: 10),
                      PrimaryTextField(
                        controller: categoryController,
                        hintText: "Category",
                        labelText: "Category",
                      ),
                      const SizedBox(height: 20),
                      PrimaryButton(
                        text: "Add Transaction",
                        onTap: () {
                          // Add transaction
                          Navigator.pop(context);
                          // Show a Lottie in a dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // pop in 3 seconds
                              Future.delayed(const Duration(seconds: 5), () {
                                Navigator.pop(context);
                              });
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset('assets/logos/celebration.json'),
                                    const SizedBox(height: 10),
                                    Text("Transaction Added Successfully"),
                                    // "Utilize Wisely" Button
                                    PrimaryButton(
                                      text: "Utilize Wisely",
                                      onTap: () {
                                        Navigator.pop(context);

                                        // show a bottom sheet with a list of options
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return PapaSheet2(
                                              pageController: PageController(),
                                              money: amountController.text,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
