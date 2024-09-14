import 'package:flutter/material.dart';

Widget _buildInfoRow(String title, String value, {bool isLink = false}) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: isLink
              ? TextButton(
                  onPressed: () {
                    // เพิ่มโค้ดสำหรับเปิดเว็บไซต์
                    // เช่น Navigator.push(context, MaterialPageRoute(
                    //       builder: (context) => WebView(
                    //         initialUrl: value,
                    //       ),
                    //     ));
                  },
                  child: Text(value),
                )
              : Text(value),
        ),
      ],
    );
  }