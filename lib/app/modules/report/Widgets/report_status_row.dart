import 'package:flutter/material.dart';
import 'package:todolist/app/core/utils/extension.dart';

class ReportStatusRow extends StatelessWidget {
  const ReportStatusRow(
      {Key? key,
      required this.number,
      required this.color,
      required this.title})
      : super(key: key);
  final int number;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.0.wp,
          vertical: 4.0.wp,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4.0.wp,
              width: 4.0.wp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.0.wp,
                  color: color,
                ),
              ),
            ),
            SizedBox(width: 1.0.wp),
            Text(
              "$number",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9.0.sp,
              ),
            ),
            SizedBox(width: 2.0.wp),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9.0.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
