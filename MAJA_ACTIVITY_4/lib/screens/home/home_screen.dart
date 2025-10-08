import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../providers/reservation_provider.dart';
import '../../models/user_model.dart';
import '../../models/order_model.dart';
import '../../models/reservation_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.currentUser?.id;

    if (userId != null) {
      if (!mounted) return;
      await Provider.of<OrderProvider>(context, listen: false)
          .loadOrders(userId);
      if (!mounted) return;
      await Provider.of<ReservationProvider>(context, listen: false)
          .loadReservations(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF2563eb),
                Color(0xFF8b5cf6),
              ],
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('EduMart Supplies',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (user != null)
                  Text(
                    'Welcome, ${user.name}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal),
                  ),
              ],
            ),
            actions: [
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart');
                        },
                      ),
                      if (cart.itemCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFf97316), // Orange badge
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                                minWidth: 16, minHeight: 16),
                            child: Text(
                              '${cart.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _buildDashboard(user),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 1:
        Navigator.of(context).pushNamed('/products');
        break;
      case 2:
        Navigator.of(context).pushNamed('/orders');
        break;
      case 3:
        Navigator.of(context).pushNamed('/profile');
        break;
    }
  }

  Widget _buildDashboard(User? user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuickActions(),
          const SizedBox(height: 24),
          _buildFeaturedSection(),
          const SizedBox(height: 24),
          _buildStatsSection(user),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Quick Actions',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildActionCard(
              icon: Icons.shopping_bag,
              title: 'Browse Products',
              color: const Color(0xFF2563eb), // Blue
              bgColor: const Color(0xFFdbeafe),
              onTap: () => Navigator.of(context).pushNamed('/products'),
            ),
            _buildActionCard(
              icon: Icons.bookmark_border,
              title: 'Reservations',
              color: const Color(0xFF8b5cf6), // Purple
              bgColor: const Color(0xFFede9fe),
              onTap: () => Navigator.of(context).pushNamed('/reservations'),
            ),
            _buildActionCard(
              icon: Icons.receipt_long,
              title: 'My Orders',
              color: const Color(0xFFf97316), // Orange
              bgColor: const Color(0xFFffedd5),
              onTap: () => Navigator.of(context).pushNamed('/orders'),
            ),
            _buildActionCard(
              icon: Icons.description,
              title: 'Documents',
              color: const Color(0xFFec4899), // Pink
              bgColor: const Color(0xFFfce7f3),
              onTap: () => Navigator.of(context).pushNamed('/documents'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Featured Categories',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryChip('Books', Icons.menu_book,
                  const Color(0xFF2563eb), const Color(0xFFdbeafe)),
              _buildCategoryChip('Uniforms', Icons.checkroom,
                  const Color(0xFF8b5cf6), const Color(0xFFede9fe)),
              _buildCategoryChip('Notebooks', Icons.note,
                  const Color(0xFFf97316), const Color(0xFFffedd5)),
              _buildCategoryChip('Stationery', Icons.edit,
                  const Color(0xFFec4899), const Color(0xFFfce7f3)),
              _buildCategoryChip('Bags', Icons.backpack,
                  const Color(0xFF06b6d4), const Color(0xFFcffafe)),
              _buildCategoryChip('Art Supplies', Icons.palette,
                  const Color(0xFFa855f7), const Color(0xFFf3e8ff)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(
      String label, IconData icon, Color color, Color bgColor) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed('/products'),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 40),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(User? user) {
    return Consumer2<OrderProvider, ReservationProvider>(
      builder: (context, orderProvider, reservationProvider, child) {
        final pendingOrders = orderProvider.orders
            .where((o) => o.status == OrderStatus.pending)
            .length;
        final activeReservations = reservationProvider.reservations
            .where((r) => r.status == ReservationStatus.confirmed)
            .length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overview',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Pending Orders',
                    pendingOrders.toString(),
                    Icons.pending_actions,
                    const Color(0xFF2563eb),
                    const Color(0xFFdbeafe),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    'Active Reservations',
                    activeReservations.toString(),
                    Icons.bookmark,
                    const Color(0xFF8b5cf6),
                    const Color(0xFFede9fe),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    Color bgColor,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(label,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: color.withOpacity(0.8))),
          ],
        ),
      ),
    );
  }
}
