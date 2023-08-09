// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ojk/view/article.dart';
import 'package:ojk/view/home.dart';

import '../controllers/home_controller.dart';
import '../models/article.dart';
import '../widget/search_textfield.dart';

final HomeController controller = Get.put(HomeController());

class FilteredArticle extends StatelessWidget {
  var searchText = '';
  RxList articles;

  FilteredArticle(
      {super.key, required this.searchText, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.off(() => HomeView());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: SearchTextField(
          controller: controller.articleSearch,
          onTextChanged: (text) {
            controller.inputText.value =
                text; // Update the searchText when the user types in the TextField
          },
          onSearchPressed: () {
            controller.SearchArticle(controller.articleSearch.text);
            Get.to(FilteredArticle(
              searchText: controller.articleSearch.text,
              articles: controller.filteredArticles,
            ));
          },
        ),
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                Article article = articles[index];
                Widget leadingWidget;

                if (controller.isLoading.value) {
                  leadingWidget = const CircularProgressIndicator();
                } else if (article.urlToImage.isNotEmpty) {
                  leadingWidget = Image.network(
                    article.urlToImage,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.25,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      if (exception is NetworkImageLoadException &&
                          exception.statusCode == 403) {
                        return Container(
                          color: Colors.grey,
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: const Center(
                              child: Text(
                            'Gambar gagal di muat',
                            style: TextStyle(fontSize: 9),
                          )),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  leadingWidget = Container(
                    color: Colors.grey,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.25,
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
                        child: ListTile(
                          leading: leadingWidget,
                          title: Text(
                            article.getSourceName()!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            article.title,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          trailing: Text(
                            article.getFormattedDate(),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.7)),
                          ),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                );
              },
            )),
    );
  }
}
