import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/models/news_model.dart';

class NewsDetailView extends StatelessWidget {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Result news = Get.arguments as Result;

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () => _launchUrl(news.url),
            tooltip: 'Open in browser',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (news.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  news.image!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // Title
            Text(
              news.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Source and Date
            Row(
              children: [
                const Icon(Icons.newspaper, size: 16),
                const SizedBox(width: 4),
                Text(news.source.title),
                const Spacer(),
                Text(
                  _formatDate(news.dateTimePub),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 32),

            // Body
            Text(
              news.body,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Read Full Article Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl(news.url),
                icon: const Icon(Icons.open_in_new),
                label: const Text('Read Full Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _launchUrl(String urlString) async {
    try {
      final url = Uri.parse(urlString);
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        Get.snackbar('Error', 'Could not open URL');
      }
    } catch (e) {
      Get.snackbar('Error', 'Invalid URL');
    }
  }
}