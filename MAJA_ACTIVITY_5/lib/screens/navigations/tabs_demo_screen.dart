import 'package:flutter/material.dart';

// Activity 13-14: Bottom Navigation and TabBar
class TabsDemoScreen extends StatefulWidget {
  const TabsDemoScreen({super.key});

  @override
  State<TabsDemoScreen> createState() => _TabsDemoScreenState();
}

class _TabsDemoScreenState extends State<TabsDemoScreen>
    with SingleTickerProviderStateMixin {
  int _currentBottomIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.book), text: 'Books'),
            Tab(icon: Icon(Icons.edit), text: 'Stationery'),
            Tab(icon: Icon(Icons.palette), text: 'Art'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('Books', Icons.book, Colors.blue),
          _buildTabContent('Stationery', Icons.edit, Colors.green),
          _buildTabContent('Art Supplies', Icons.palette, Colors.orange),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentBottomIndex,
        onTap: (index) {
          setState(() {
            _currentBottomIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(String title, IconData icon, Color color) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: color),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Bottom Tab: ${_currentBottomIndex == 0 ? "Home" : _currentBottomIndex == 1 ? "Search" : "Profile"}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
