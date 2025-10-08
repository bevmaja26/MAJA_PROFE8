import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/forms/registration_form_screen.dart';
import 'screens/forms/product_form_screen.dart';
import 'screens/media/image_demo_screen.dart';
import 'screens/media/video_demo_screen.dart';
import 'screens/media/audio_demo_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';

void main() {
  runApp(const EduMartApp());
}

class EduMartApp extends StatelessWidget {
  const EduMartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Edu Mart - School Supplies',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2196F3),
            primary: const Color(0xFF2196F3),
            secondary: const Color(0xFFFF9800),
          ),
          useMaterial3: true,
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 2,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/registration': (context) => const RegistrationFormScreen(),
          '/product-form': (context) => const ProductFormScreen(),
          '/image-demo': (context) => const ImageDemoScreen(),
          '/video-demo': (context) => const VideoDemoScreen(),
          '/audio-demo': (context) => const AudioDemoScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product-detail') {
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(product: args['product']),
            );
          }
          return null;
        },
      ),
    );
  }
}
