import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../models/article.dart';
import '../view/webview.dart';

class ArticleContent extends StatelessWidget {
  final Article article;
  final Widget leadingWidget;

  const ArticleContent(
      {super.key, required this.article, required this.leadingWidget});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            leadingWidget,
            const SizedBox(
              height: 10,
            ),
            Text(
              article.title,
              style: GoogleFonts.notoSansDisplay(
                fontSize: 26,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black.withOpacity(0.7),
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.7),
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.facebook,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.wechat_sharp,
                        color: Colors.green,
                      ),
                      SizedBox(width: 20),
                      Icon(
                        Icons.telegram,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.share,
                        color: GlobalTextColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Share',
                        style: GoogleFonts.notoSansDisplay(
                            fontSize: 14,
                            color: GlobalTextColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => WebArticle(url: article.url));
              },
              child: Text(
                article.url,
                style: const TextStyle(color: Colors.blueAccent),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              article.description,
              style: GoogleFonts.notoSansDisplay(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              article.content,
              style: GoogleFonts.notoSansDisplay(
                fontSize: 18,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
