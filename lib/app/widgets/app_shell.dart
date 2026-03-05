import 'package:flutter/material.dart';

import '../core/theme/theme_data.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
    required this.body,
    this.title = 'Güral Porselen',
    this.onMenuTap,
    this.onSearchTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTabChanged;
  final Widget body;
  final String title;
  final VoidCallback? onMenuTap;
  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: onMenuTap,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearchTap,
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabChanged,
        selectedItemColor: AppThemeData.primary,
        unselectedItemColor: AppThemeData.textSecondary,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'ANASAYFA'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_outlined), label: 'KATALOG'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'SEPET'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'FAVORİLER'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFİL'),
        ],
      ),
    );
  }
}
