import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardButton extends StatefulWidget {
  const CardButton({super.key});

  @override
  State<CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<CardButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(right: 14),
            height: 150,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                    spreadRadius: 0.0,
                    offset: Offset(3, 3),
                  ),
                ]),
            // ignore: deprecated_member_use
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue
                  ),
                    onPressed: () {},
                    child: Text(
                      "Upload Image",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500
                      ),
                    )),
                Image.network(
                    "https://assets.stickpng.com/thumbs/580b57fbd9996e24bc43be0e.png")
              ],
            )));
  }
}
