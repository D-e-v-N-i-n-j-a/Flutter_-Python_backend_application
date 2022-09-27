import 'dart:convert';
import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:doctor_app/enum/controller.dart';
import 'package:doctor_app/enum/hexcolor.dart';
import 'package:doctor_app/widgets/task.card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  DateTime _selectedValue = DateTime.now();
  DateTime today = DateTime.now();
  String? readable_date;

  final url = "http://10.0.2.2:8000/task/allTask";

  Future<List<Task>> fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      dynamic allTask;
      Map<String, dynamic> parsed = json.decode(response.body);
      log(parsed.toString());
      parsed.forEach((key, value) {
        allTask = value;
      });
      return allTask.map<Task>((json) => Task.fromMap(json)).toList();
    } else {
      throw Exception('Failed to load task');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 15),
              _buildHeader(size),
              const SizedBox(height: 15),
              _buildPickDate(size),
              const SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: _buildTaskList(size),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // BUILD DATE PICKER WIDGET
  Widget _buildPickDate(Size size) {
    return Container(
        width: size.width,
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

  Widget _buildHeader(Size size) {
    return SizedBox(
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Today",
                  style: TextStyle(color: Colors.grey, fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              Text(
                DateFormat.yMMMMd().format(today),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              )
            ]),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.purple,
                child: Icon(LineIcons.user)),
          )
        ],
      ),
    );
  }

  Widget _buildTaskList(Size size) {
    return StreamBuilder<List<Task>>(
      stream: fetchData().asStream(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: HexColor(snapshot.data![index].color),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data![index].title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("Loading..."),
        );
      },
    );
  }
}
