import 'package:doctor_app/enum/hexcolor.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  String? title;
  String? description;
  String? color;
  String? date;

  TaskCard({Key? key, this.color, this.date, this.description, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.height * 0.4,
      height: 200,
      color: HexColor(color!),
      child: Column(
        children: [
          Text(title.toString(),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(
            height: 10,
          ),
          Text(description!),
          const SizedBox(
            height: 10,
          ),
          Text(date!)
        ],
      ),
    );
  }
}
