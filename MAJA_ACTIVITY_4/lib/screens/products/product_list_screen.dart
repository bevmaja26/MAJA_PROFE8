import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/product_model.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchController = TextEditingController();
  ProductCategory? _selectedCategory;
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadProducts() {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    setState(() {
      _filteredProducts = productProvider.products;
    });
  }

  void _filterProducts(String query) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    setState(() {
      if (query.isEmpty && _selectedCategory == null) {
        _filteredProducts = productProvider.products;
      } else if (query.isEmpty) {
        _filteredProducts =
            productProvider.getProductsByCategory(_selectedCategory!);
      } else {
        _filteredProducts = productProvider.searchProducts(query);
        if (_selectedCategory != null) {
          _filteredProducts = _filteredProducts
              .where((p) => p.category == _selectedCategory)
              .toList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
            title: const Text('Products',
                style: TextStyle(fontWeight: FontWeight.bold)),
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
                              color: Color(0xFFf97316),
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterProducts('');
                            },
                          )
                        : null,
                  ),
                  onChanged: _filterProducts,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryFilter(null, 'All'),
                      ...ProductCategory.values.map(
                        (category) => _buildCategoryFilter(
                          category,
                          _getCategoryLabel(category),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inventory_2_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(_filteredProducts[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(ProductCategory? category, String label) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = selected ? category : null;
            _filterProducts(_searchController.text);
          });
        },
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final categoryColors = _getCategoryColors(product.category);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(product: product),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: categoryColors['bg'],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(product.category),
                    size: 64,
                    color: categoryColors['icon'],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: categoryColors['icon'],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.inventory_2,
                          size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        'Stock: ${product.stockQuantity}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, Color> _getCategoryColors(ProductCategory category) {
    switch (category) {
      case ProductCategory.books:
        return {'icon': const Color(0xFF2563eb), 'bg': const Color(0xFFdbeafe)};
      case ProductCategory.uniforms:
        return {'icon': const Color(0xFF8b5cf6), 'bg': const Color(0xFFede9fe)};
      case ProductCategory.notebooks:
        return {'icon': const Color(0xFFf97316), 'bg': const Color(0xFFffedd5)};
      case ProductCategory.stationery:
        return {'icon': const Color(0xFFec4899), 'bg': const Color(0xFFfce7f3)};
      case ProductCategory.bags:
        return {'icon': const Color(0xFF06b6d4), 'bg': const Color(0xFFcffafe)};
      case ProductCategory.artSupplies:
        return {'icon': const Color(0xFFa855f7), 'bg': const Color(0xFFf3e8ff)};
      case ProductCategory.electronics:
        return {'icon': const Color(0xFF10b981), 'bg': const Color(0xFFd1fae5)};
      case ProductCategory.other:
        return {'icon': const Color(0xFF64748b), 'bg': const Color(0xFFf1f5f9)};
    }
  }

  String _getCategoryLabel(ProductCategory category) {
    switch (category) {
      case ProductCategory.books:
        return 'Books';
      case ProductCategory.uniforms:
        return 'Uniforms';
      case ProductCategory.notebooks:
        return 'Notebooks';
      case ProductCategory.stationery:
        return 'Stationery';
      case ProductCategory.bags:
        return 'Bags';
      case ProductCategory.artSupplies:
        return 'Art Supplies';
      case ProductCategory.electronics:
        return 'Electronics';
      case ProductCategory.other:
        return 'Other';
    }
  }

  IconData _getCategoryIcon(ProductCategory category) {
    switch (category) {
      case ProductCategory.books:
        return Icons.menu_book;
      case ProductCategory.uniforms:
        return Icons.checkroom;
      case ProductCategory.notebooks:
        return Icons.note;
      case ProductCategory.stationery:
        return Icons.edit;
      case ProductCategory.bags:
        return Icons.backpack;
      case ProductCategory.artSupplies:
        return Icons.palette;
      case ProductCategory.electronics:
        return Icons.devices;
      case ProductCategory.other:
        return Icons.category;
    }
  }
}
