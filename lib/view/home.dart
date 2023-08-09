import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ojk/view/filtered_article.dart';
import 'package:ojk/widget/home_content.dart';

import '../controllers/home_controller.dart';
import '../main.dart';
import '../models/article.dart';
import '../widget/search_textfield.dart';

class HomeView extends StatelessWidget {
  final List<String> tabTitles = [
    'APPLE',
    'TESLA',
    'BUSINESS',
    'TECH CRUNCH',
    'WALL STREET',
  ];

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'KRAY NEWS',
          style: GoogleFonts.notoSansDisplay(
            fontSize: 24,
            color: GlobalTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: TabBar(
          controller: controller.tabController,
          isScrollable: true,
          tabs: [
            for (final title in tabTitles)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Tab(
                  child: Text(
                    title,
                    style: GoogleFonts.notoSansDisplay(
                      fontSize: 17,
                      color: GlobalTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
          labelColor: GlobalTextColor,
          unselectedLabelColor: Colors.grey,
          indicator: const BoxDecoration(
            // Indikator tab yang aktif
            border: Border(
              bottom: BorderSide(
                color: GlobalTextColor, // Warna indikator tab yang aktif
                width: 2, // Lebar indikator
              ),
            ),
          ),
          onTap: (index) {
            final title = tabTitles[index];
            controller.setActiveTab(title);
          },
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          NewsTabView(tabTitle: 'Apple', articles: controller.appleArticles),
          NewsTabView(tabTitle: 'Tesla', articles: controller.teslaArticles),
          NewsTabView(
              tabTitle: 'Business', articles: controller.businessArticles),
          NewsTabView(
              tabTitle: 'Tech Crunch', articles: controller.techCrunchArticles),
          NewsTabView(
              tabTitle: 'Wall Street', articles: controller.wallStreetArticles),
        ],
      ),
    );
  }
}

class NewsTabView extends StatelessWidget {
  final HomeController controller = Get.find();
  final String tabTitle;
  final RxList<Article> articles;

  NewsTabView({super.key, required this.tabTitle, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (articles.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SearchTextField(
              controller: controller.articleSearch,
              onTextChanged: (text) {
                controller.inputText.value = text;
              },
              onSearchPressed: () {
                controller.SearchArticle(controller.articleSearch.text);
                Get.to(FilteredArticle(
                  searchText: controller.articleSearch.text,
                  articles: controller.filteredArticles,
                ));
              },
            ),
            HomeContent(
                articles: articles, isLoading: controller.isLoading.value)
          ],
        );
      }
    });
  }
}
