import 'package:finsec/widgets/member_info.dart';
import 'package:flutter/material.dart';

class FamilyManagerScreen extends StatefulWidget {
  const FamilyManagerScreen({Key? key}) : super(key: key);

  @override
  _FamilyManagerScreenState createState() => _FamilyManagerScreenState();
}

class _FamilyManagerScreenState extends State<FamilyManagerScreen> {
  List<String> members = [
    "Hetalkumar Doshi - Father (Organizer)",
    "Kajal Doshi - Mother",
    "Prinkal Doshi - Adult (You)",
    "Sahil Doshi - Adult"
  ];
  final _formKey = GlobalKey<FormState>();
  String? selectedType;
  List<String> familyIncomeSources = [
    "Hetalkumar Doshi - 700000",
    "Kajal Doshi - 20000"
  ];

  List<String> insurancePolicies = [
    "Life Insurance - Annual Premium - 1270 per month"
  ];

  List<String> otherAssertsAndLiabilities = [
    "Personal Loan - 1crore - 15000 per month"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Family Finance Manager"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                String name = '';
                String role = '';

                String source = '';
                String amount = '';

                String policy = '';
                String premium = '';
                String amountt = '';

                String assets = '';
                String liability = '';
                String amounttt = '';

                return Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add a Family Member'),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        onChanged: (value) {
                                          name = value;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Name',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Name is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          role = value;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Role',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Role is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          Navigator.of(context).pop();
                                          members.add('$name - $role');
                                        });
                                      }
                                    },
                                    child: const Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Family Member',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add a Family Income Source'),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        onChanged: (value) {
                                          source = value;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Name',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Name is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          amount = value;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Amount',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Amount is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          Navigator.of(context).pop();
                                          familyIncomeSources
                                              .add('$source - $amount');
                                        });
                                      }
                                    },
                                    child: const Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Add a Family Income Source',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Add a Insurance Policy'),
                                content: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        onChanged: (value) {
                                          policy = value;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Insurance Name',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Insurance Name is required';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        onChanged: (value) {
                                          premium = value;
                                        },
                                        decoration: const InputDecoration(
                                          labelText: 'Amount',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'This field is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          Navigator.of(context).pop();
                                          insurancePolicies
                                              .add('$policy - $premium');
                                        });
                                      }
                                    },
                                    child: const Text('Add'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Add a Insurance Policy',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text('Assets and Liabilities'),
                                  content: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          onChanged: (value) {
                                            assets = value;
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Assets/Liabilities',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'This Field is required';
                                            }
                                            return null;
                                          },
                                        ),
                                        TextFormField(
                                          onChanged: (value) {
                                            liability = value;
                                          },
                                          decoration: const InputDecoration(
                                            labelText: 'Amount',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Amount field is required';
                                            }
                                            return null;
                                          },
                                        ),
                                        Row(
                                          children: [
                                            Radio<String>(
                                              value: 'liability',
                                              groupValue: selectedType,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedType = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Liability',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                            Radio<String>(
                                              value: 'asset',
                                              groupValue: selectedType,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedType = value;
                                                });
                                              },
                                            ),
                                            Text(
                                              'Asset',
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            Navigator.of(context).pop();
                                            otherAssertsAndLiabilities
                                                .add('$assets - $liability');
                                          });
                                        }
                                      },
                                      child: const Text('Add'),
                                    ),
                                  ],
                                );
                              });
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            'Add Assets and Liabilities',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 6.0, bottom: 5),
                  child: Text(
                    "Family Members",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(47, 216, 214, 214),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: members.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Divider(),
                    ), // Add a Divider between list items
                    itemBuilder: (context, index) {
                      String name = members[index].split(' - ')[0];
                      String role = members[index].split(' - ')[1];

                      return ListTile(
                        title: Text(name),
                        subtitle: Text(role),
                        leading: CircleAvatar(
                          child: Text(name.substring(0, 1)),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios_outlined),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MemberInfo()),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 25, left: 6.0, bottom: 5),
                  child: Text(
                    "Family Income Sources",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(47, 216, 214, 214),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero, // Remove the padding
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: familyIncomeSources.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Divider(),
                    ), // Add a Divider between list items
                    itemBuilder: (context, index) {
                      String name = familyIncomeSources[index].split(' - ')[0];
                      String role = familyIncomeSources[index].split(' - ')[1];

                      return ListTile(
                        title: Text(name),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            role,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        leading: CircleAvatar(
                          child: Text(name.substring(0, 1)),
                        ),
                        // trailing: IconButton(
                        //   icon: const Icon(Icons.arrow_forward_ios_outlined),
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => MemberInfo()),
                        //     );
                        //   },
                        // ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 25, left: 6.0, bottom: 5),
                  child: Text(
                    "Insurance Policies",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(47, 216, 214, 214),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: insurancePolicies.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Divider(),
                    ),
                    itemBuilder: (context, index) {
                      String name = insurancePolicies[index].split(' - ')[0];
                      String amountt = insurancePolicies[index].split(' - ')[1];
                      String role = insurancePolicies[index].split(' - ')[2];

                      return ListTile(
                        title: Text(name),
                        subtitle: Text(role),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            amountt,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        // trailing: Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   decoration: BoxDecoration(
                        //   color: Colors.green,
                        //   borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: Text(
                        //   role,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 16,
                        //   ),
                        //   ),
                        // ),
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 25, left: 6.0, bottom: 5),
                  child: Text(
                    "Other Asserts & Liabilities",
                    style: TextStyle(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(47, 216, 214, 214),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero, // Remove the padding
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: otherAssertsAndLiabilities.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0),
                      child: Divider(),
                    ), // Add a Divider between list items
                    itemBuilder: (context, index) {
                      String name =
                          otherAssertsAndLiabilities[index].split(' - ')[0];
                      String role =
                          otherAssertsAndLiabilities[index].split(' - ')[1];
                      String amounttt =
                          otherAssertsAndLiabilities[index].split(' - ')[2];

                      return ListTile(
                        title: Text(name),
                        subtitle: Text(amounttt),

                        trailing: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            role,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // trailing: IconButton(
                        //   icon: const Icon(Icons.arrow_forward_ios_outlined),
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => MemberInfo()),
                        //     );
                        //   },
                        // ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
