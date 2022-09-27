import 'dart:convert';
import 'dart:developer';

import 'package:doctor_app/enum/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:line_icons/line_icons.dart';
import 'package:dio/dio.dart';

class Description extends StatefulWidget {
  String? title;
  String? type;
  String? date;

  Description({Key? key, this.date, this.title, this.type}) : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController description = TextEditingController();

  String selectedColor = "#FFFEFF";
  bool favorite = false;
  final url = "http://10.0.2.2:8000/task/post-task";

  List<String> colorWheel = [
    "#FFFEFF",
    "#FFA348",
    "#FFA6C4",
    "#7ECCFF",
    "#1ECDC4",
    "#FFA4A3",
  ];

  int tapIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                LineIcons.bell,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                LineIcons.heart,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                LineIcons.home,
                color: Colors.black,
              )),
        ],
        backgroundColor: HexColor(selectedColor),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: description,
              decoration: InputDecoration(
                  hintText: "Enter Description",
                  fillColor: HexColor(selectedColor),
                  filled: true),
              maxLines: 40,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 9.0,
        onPressed: submitData,
        child: Icon(
          Icons.check,
          color: HexColor('#E98E2D'),
          size: 34,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 150,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < colorWheel.length; i++)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            tapIndex = i;
                            selectedColor = colorWheel[i];
                          });
                        },
                        child: Card(
                          color: HexColor(colorWheel[i]),
                          elevation: 9.0,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor(colorWheel[i]),
                            ),
                            child: (tapIndex == i)
                                ? const Icon(Icons.check)
                                : const SizedBox(
                                    width: 0,
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
    );
  }

  void submitData() async {
    var data = {
      "title": "${widget.title}",
      "taskType": widget.type,
      "description": description.text,
      "duration": widget.date,
      "color": selectedColor,
      "is_pinned": 'false',
    };
    log(data.toString());

    String body = json.encode(data);
    var header = {"content-Type": "application/json"};
     log(body.toString());
    try {
      final response = await post(Uri.parse(url), headers: header, body: body);
      if (response.statusCode == 201) {
        log('Data successfully added');
      } else {
        log('Something bad happened along the way ');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
