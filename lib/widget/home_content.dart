import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/article.dart';
import '../view/article.dart';

class HomeContent extends StatelessWidget {
  final List<Article> articles;
  final bool isLoading;

  const HomeContent({
    super.key,
    required this.articles,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          Article article = articles[index];
          Widget leadingWidget;

          if (isLoading) {
            leadingWidget = const CircularProgressIndicator();
          } else if (article.urlToImage.isNotEmpty) {
            leadingWidget = Image.network(
              article.urlToImage,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                if (exception is NetworkImageLoadException &&
                    exception.statusCode == 403) {
                  return Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: const Center(
                      child: Text('Gambar gagal di muat'),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            leadingWidget = Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.2,
            );
          }

          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => ArticleView(article: article));
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      leadingWidget,
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        article.title,
                        style: GoogleFonts.notoSansDisplay(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${article.getSourceName()!} - ${article.getFormattedDate()}',
                          style: GoogleFonts.notoSansDisplay(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          );
        },
      ),
    );
  }
}
