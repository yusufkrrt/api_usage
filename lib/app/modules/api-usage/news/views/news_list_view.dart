import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../routes/app_routes.dart';

class NewsListView extends GetView<NewsController> {
  const NewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'News API Learning',
        onRefresh: controller.refresh,
      ),
      body: Obx(() => _buildBody()),
    );
  }

  Widget _buildBody() {
    // Loading
    if (controller.isLoading && controller.newsList.isEmpty) {
      return const LoadingWidget(message: 'Loading news...');
    }

    // Error
    if (controller.hasError && controller.newsList.isEmpty) {
      return ErrorDisplayWidget(
        message: controller.errorMessage,
        onRetry: controller.refresh,
      );
    }

    // Empty
    if (controller.newsList.isEmpty) {
      return EmptyWidget(
        message: 'No news available',
        icon: Icons.article_outlined,
        onAction: controller.refresh,
        actionLabel: 'Refresh',
      );
    }

    // List
    return RefreshIndicator(
      onRefresh: controller.refresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.newsList.length,
        itemBuilder: (context, index) {
          final news = controller.newsList[index];
          return NewsCard(
            news: news,
            onTap: () {
              Get.toNamed(
                AppRoutes.newsDetail,
                arguments: news,
              );
            },
          );
        },
      ),
    );
  }
}
