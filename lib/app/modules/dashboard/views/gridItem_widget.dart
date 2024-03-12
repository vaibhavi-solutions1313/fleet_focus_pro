import 'package:flutter/material.dart';

import '../controllers/dashboard_controller.dart';

class GridItemWidget extends StatelessWidget {
  final GridItem item;

  const GridItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.imagePath,
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 8.0),
          Text(
            item.text,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Arial'),
          ),
        ],
      ),
    );
  }
}
