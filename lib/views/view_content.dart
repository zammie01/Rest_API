import 'package:flutter/material.dart';

class ViewContent extends StatelessWidget {
  String content;
  String urlImage;
  String author;
  ViewContent(
      {Key? key,
      required this.content,
      required this.urlImage,
      required this.author})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Articles Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 300,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(urlImage), fit: BoxFit.fill),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Content',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 10),
            Text('Author: $author'),
            const SizedBox(height: 10),
            Text(content),
          ],
        ),
      ),
    );
  }
}
