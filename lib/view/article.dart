import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojk/view/home.dart';
import 'package:ojk/widget/article_content.dart';

import '../main.dart';
import '../models/article.dart';
import 'filtered_article.dart';

class ArticleView extends StatelessWidget {
  const ArticleView({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(() => HomeView());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: GlobalTextColor,
            )),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'ARTICLE',
          style: GoogleFonts.notoSansDisplay(
            fontSize: 18,
            color: GlobalTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          Widget leadingWidget;

          if (controller.isLoading.value) {
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

          return ArticleContent(article: article, leadingWidget: leadingWidget);
        }
      }),
    );
  }
}
