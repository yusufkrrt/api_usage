import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MusicDetailView extends StatelessWidget {
  final Map<String, dynamic> song;

  const MusicDetailView({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Song Detail',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Albüm Kapağı
            _buildArtwork(),
            const SizedBox(height: 32),

            // Şarkı Bilgileri
            _buildSongInfo(),
            const SizedBox(height: 24),

            // Detay Kartları
            _buildDetailCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildArtwork() {
    final artworkUrl = (song['artworkUrl100'] as String?)
        ?.replaceAll('100x100', '600x600');

    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: artworkUrl != null
            ? Image.network(
                artworkUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholderImage(),
              )
            : _placeholderImage(),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      color: Colors.grey[800],
      child: const Icon(Icons.music_note, color: Colors.white54, size: 80),
    );
  }

  Widget _buildSongInfo() {
    return Column(
      children: [
        Text(
          song['trackName'] ?? 'Unknown Track',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          song['artistName'] ?? 'Unknown Artist',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.purple,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          song['collectionName'] ?? 'Unknown Album',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailCard() {
    final durationMs = song['trackTimeMillis'] as int?;
    final duration = durationMs != null
        ? '${(durationMs / 60000).floor()}:${((durationMs % 60000) / 1000).floor().toString().padLeft(2, '0')}'
        : '-';

    final price = song['trackPrice'] != null
        ? '\$${song['trackPrice']}'
        : 'Free';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[800]!),
      ),
      child: Column(
        children: [
          _buildDetailRow(Icons.album, 'Genre', song['primaryGenreName'] ?? '-'),
          _buildDivider(),
          _buildDetailRow(Icons.timer, 'Duration', duration),
          _buildDivider(),
          _buildDetailRow(Icons.attach_money, 'Price', price),
          _buildDivider(),
          _buildDetailRow(
            Icons.calendar_today,
            'Release Date',
            _formatDate(song['releaseDate']),
          ),
          _buildDivider(),
          _buildDetailRow(
            Icons.explicit,
            'Content',
            song['trackExplicitness'] == 'explicit' ? 'Explicit' : 'Clean',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: Colors.grey[800], height: 1);
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}.${date.month}.${date.year}';
    } catch (_) {
      return '-';
    }
  }
}