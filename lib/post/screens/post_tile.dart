import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/post.dart';

class PostTile extends StatelessWidget {
  const PostTile({Key? key, required this.post}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black,
        child: Card(
            margin: const EdgeInsets.all(6.0),
            color: Colors.grey[800],
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${post.id}',
                        style: GoogleFonts.getFont('Roboto',
                            textStyle: TextStyle(
                                color: Colors.grey[300], fontSize: 11))),
                    const SizedBox(height: 8),
                    Text(post.text,
                        style: GoogleFonts.getFont('Roboto',
                            textStyle: TextStyle(
                                color: Colors.grey[300], fontSize: 14))),
                  ],
                ))));
  }
}
