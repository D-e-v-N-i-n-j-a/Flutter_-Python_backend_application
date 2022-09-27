import 'dart:developer';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app/enum/hexcolor.dart';
import 'package:doctor_app/screens/Dashbaord.dart';
import 'package:doctor_app/screens/description.dart';
import 'package:doctor_app/screens/profile.dart';
import 'package:doctor_app/screens/settings.dart';
import 'package:doctor_app/screens/todos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedValue = DateTime.now();
  DateTime today = DateTime.now();
  TextEditingController title = TextEditingController();
  String? readable_date;
  int currentTap = 0;
  String selectedTaskType = '';

  int is_selected_index = 0;

  final List<Widget> screens = [
    const DashBoard(),
    const Settings(),
    const Profile(),
    const AllTask()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const DashBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialogue();
        },
        child: const Icon(LineIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const DashBoard();
                        currentTap = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTap == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(
                            color: currentTap == 0 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const AllTask();
                        currentTap = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTap == 1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Task",
                          style: TextStyle(
                            color: currentTap == 1 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Settings();
                        currentTap = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTap == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
                            color: currentTap == 2 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const Profile();
                        currentTap = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LineIcons.user,
                          color: currentTap == 3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                            color: currentTap == 3 ? Colors.blue : Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogue() {
    Get.bottomSheet(
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create new task',
                      style: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Text('Title', style: GoogleFonts.cairo(textStyle: TextStyle())),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Theme(
                    data: ThemeData(
                      primaryColor: HexColor('#F6F8FE'),
                      primaryColorDark: HexColor('#F6F8FE'),
                    ),
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Enter title",
                        fillColor: HexColor('#F6F8FE'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Task type',
                    style: GoogleFonts.cairo(textStyle: const TextStyle())),
                const SizedBox(
                  height: 20,
                ),
                _buildTaskType(),
                const SizedBox(
                  height: 20,
                ),
                Text('Pick Date',
                    style: GoogleFonts.cairo(textStyle: const TextStyle())),
                const SizedBox(
                  height: 10,
                ),
                _buildPickDate(),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      () => Description(
                        title: title.text,
                        date: readable_date,
                        type: selectedTaskType,
                      ),
                      transition: Transition.leftToRight,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                        color: HexColor('#F14A5B'),
                        borderRadius: BorderRadius.circular(24)),
                    child: Center(
                      child: Text(
                        'Add Description',
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTaskType() {
    dynamic taskType = [
      {
        "task": "Family",
        "background": "#F8EFFF",
        "textColor": "#CEB1E7",
      },
      {
        "task": "Education",
        "background": "#FFE6C2",
        "textColor": "#F4B798",
      },
      {
        "task": "Meetings",
        "background": "#ffe8e5",
        "textColor": "#eec5ce",
      },
      {
        "task": "Work",
        "background": "#ffe8e5",
        "textColor": "#eec5ce",
      },
      {
        "task": "Freelance",
        "background": "#ffe8e5",
        "textColor": "#eec5ce",
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < taskType.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  is_selected_index = i;
                  selectedTaskType = taskType[i]['task'];
                });
              },
              child: Card(
                color: (is_selected_index == i)
                    ? Colors.blue
                    : HexColor(taskType[i]['background']),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    taskType[i]['task'],
                    style: GoogleFonts.cairo(
                        textStyle: TextStyle(
                            color: (is_selected_index == i)
                                ? Colors.white
                                : HexColor(taskType[i]['textColor']),
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildPickDate() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.orange,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                  readable_date = DateFormat.yMMMMd().format(_selectedValue);
                  log(readable_date!);
                });
              },
            ),
          ],
        ));
  }
}
