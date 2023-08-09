// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ojk/models/article.dart';
import 'package:ojk/services/data_service.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late RxString activeTab;

  void setActiveTab(String tabTitle) {
    activeTab.value = tabTitle;
  }

  var inputText = ''.obs;
  TextEditingController articleSearch = TextEditingController();
  var filteredArticles = <Article>[].obs;

  var isLoading = false.obs;
  var hasError = false.obs;

  final DataService _dataService = DataService();
  TabController? tabController;
  RxList<Article> appleArticles = <Article>[].obs;
  RxList<Article> teslaArticles = <Article>[].obs;
  RxList<Article> businessArticles = <Article>[].obs;
  RxList<Article> techCrunchArticles = <Article>[].obs;
  RxList<Article> wallStreetArticles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();

    activeTab = ''.obs;
    tabController = TabController(length: 5, vsync: this);
    SearchArticle(articleSearch.text);
    fetchAppleArticles();
    fetchTeslaArticles();
    fetchBusinessArticles();
    fetchTechCrunchArticles();
    fetchWallStreetArticles();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  void SearchArticle(String searchText) {
    isLoading.value = true;

    final activeTabValue = activeTab.value; // Ambil kategori tab aktif

    Future.delayed(const Duration(milliseconds: 500), () {
      List<Article> filteredList;

      if (activeTabValue == 'APPLE') {
        filteredList = appleArticles;
      } else if (activeTabValue == 'TESLA') {
        filteredList = teslaArticles;
      } else if (activeTabValue == 'BUSINESS') {
        filteredList = businessArticles;
      } else if (activeTabValue == 'TECH CRUNCH') {
        filteredList = techCrunchArticles;
      } else if (activeTabValue == 'WALL STREET') {
        filteredList = wallStreetArticles;
      } else {
        filteredList = <Article>[];
      }

      filteredArticles.assignAll(filteredList.where((article) => article
          .getSourceName()!
          .toLowerCase()
          .contains(searchText.toLowerCase())));

      isLoading.value = false;
      articleSearch.clear();
    });
  }

  Future<void> fetchTeslaArticles() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      List<Article> fetchedArticles = await _dataService.getTeslaArticles();
      teslaArticles.assignAll(fetchedArticles);
    } catch (e) {
      hasError.value = true;
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAppleArticles() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      List<Article> fetchedArticles = await _dataService.getAppleArticles();
      appleArticles.assignAll(fetchedArticles);
    } catch (e) {
      hasError.value = true;
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBusinessArticles() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      List<Article> fetchedArticles = await _dataService.getBusinessArticles();
      businessArticles.assignAll(fetchedArticles);
    } catch (e) {
      hasError.value = true;
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTechCrunchArticles() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      List<Article> fetchedArticles =
          await _dataService.getTechCrunchArticles();
      techCrunchArticles.assignAll(fetchedArticles);
    } catch (e) {
      hasError.value = true;
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWallStreetArticles() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      List<Article> fetchedArticles =
          await _dataService.getWallStreetArticles();
      wallStreetArticles.assignAll(fetchedArticles);
    } catch (e) {
      hasError.value = true;
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
