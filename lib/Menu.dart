import 'package:flutter/material.dart';

void openMenu(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext buildContext) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          color: Colors.blue,
        ),
        padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Home
                IconButton(
                  icon: Icon(Icons.home, size: 50.0, color: Colors.black),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                  // onPressed: () => Navigator.pop(context),
                ),
                // Import
                Icon(Icons.vertical_align_bottom,
                    size: 50.0, color: Colors.black),
                // Import
                Icon(Icons.vertical_align_top, size: 50.0, color: Colors.black),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Other
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Icon(Icons.more_horiz, size: 50.0, color: Colors.black),
                ),
                // Other
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Icon(Icons.more_horiz, size: 50.0, color: Colors.black),
                ),
                // Other
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:
                      Icon(Icons.more_horiz, size: 50.0, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
