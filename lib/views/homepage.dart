import 'dart:convert';

import 'package:api/services/remote_service.dart';
import 'package:api/views/view_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // this is getting the list of posts form the post.dart file in the models directory
  List<Article>? articles;
  var isLoaded = false;

  Future<void> getArticle() async {
    var res = await RemoteService.getPosts();
    final res2 = jsonEncode(res);
    print(res2);
    if (res2.isNotEmpty) {
      final result = newsFromJson(res2);
      articles = result.articles;
      setState(() {
        isLoaded = true;
      });
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Articles'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: articles?.length,
          itemBuilder: (context, index) {
            final article = articles![index];
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ViewContent(
                      content: article.content,
                      urlImage: article.urlToImage,
                      author: article.author));
                },
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(article.urlToImage),
                            fit: BoxFit.fill),
                        color: Colors.grey[300],
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(article.author,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.pacifico(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Text(
                            article.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
