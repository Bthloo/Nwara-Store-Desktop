import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeDialog extends StatelessWidget {
  final DateTime dateTime;

  const TimeDialog({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, d MMMM yyyy', 'ar').format(dateTime);
    final time = DateFormat('hh:mm a', 'ar').format(dateTime);

    return Dialog(
     // backgroundColor: const Color(0xff1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.access_time,
            //  color: Color(0xff9CABBA),
              size: 40,
            ),
            const SizedBox(height: 16),
            Text(
              time,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(
                fontSize: 18,
               // color: Color(0xff9CABBA),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              //  backgroundColor: const Color(0xff9CABBA),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "إغلاق",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
