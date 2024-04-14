import 'package:finsec/features/profile/transfer/family_sheets/mom_sheet_1.dart';
import 'package:finsec/utils/utils.dart';
import 'package:finsec/widgets/custom_chip_row.dart';
import 'package:finsec/widgets/primary_textfield.dart';
import 'package:finsec/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class MoneyManagerScreen extends StatefulWidget {
  const MoneyManagerScreen({Key? key}) : super(key: key);

  @override
  State<MoneyManagerScreen> createState() => _MoneyManagerScreenState();
}

class _MoneyManagerScreenState extends State<MoneyManagerScreen> {
  DateTime selectedDate = DateTime.now();
  int selectedIndex = 0;

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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new transaction
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              final amountController = TextEditingController();
              final descriptionController = TextEditingController();
              final accountController = TextEditingController();
              final categoryController = TextEditingController();

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
                      PrimaryTextField(
                        controller: amountController,
                        hintText: "Amount",
                        labelText: "Amount",
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
                                            return MomSheet1(pageController: PageController());
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
