import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/order_provider.dart';
import 'providers/reservation_provider.dart';
import 'providers/document_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/products/product_list_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'screens/orders/order_list_screen.dart';
import 'screens/reservations/reservation_screen.dart';
import 'screens/documents/document_tracker_screen.dart';
import 'screens/profile/profile_screen.dart';

void main() {
  runApp(const EduMartApp());
}

class EduMartApp extends StatelessWidget {
  const EduMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ReservationProvider()),
        ChangeNotifierProvider(create: (_) => DocumentProvider()),
      ],
      child: MaterialApp(
        title: 'EduMart Supplies',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2563eb),
            primary: const Color(0xFF2563eb), // Bright blue
            secondary: const Color(0xFF8b5cf6), // Vibrant purple
            tertiary: const Color(0xFFf97316), // Energetic orange
            surface: const Color(0xFFf8fafc),
            background: const Color(0xFFffffff),
            error: const Color(0xFFef4444),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onTertiary: Colors.white,
          ),
          fontFamily: 'SourceSansPro',
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              fontSize: 32,
              color: Color(0xFF1e293b),
            ),
            displayMedium: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Color(0xFF1e293b),
            ),
            headlineMedium: TextStyle(
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Color(0xFF1e293b),
            ),
            bodyLarge: TextStyle(
              fontFamily: 'SourceSansPro',
              fontSize: 16,
              color: Color(0xFF334155),
            ),
            bodyMedium: TextStyle(
              fontFamily: 'SourceSansPro',
              fontSize: 14,
              color: Color(0xFF334155),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF2563eb), width: 2),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563eb),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => const HomeScreen(),
          '/products': (context) => const ProductListScreen(),
          '/cart': (context) => const CartScreen(),
          '/orders': (context) => const OrderListScreen(),
          '/reservations': (context) => const ReservationScreen(),
          '/documents': (context) => const DocumentTrackerScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}
