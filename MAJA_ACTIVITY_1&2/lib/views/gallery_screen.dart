import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _currentImageIndex = 0;

  final List<String> _eventImages = [
    'Wedding Reception at Grand Ballroom',
    'Corporate Conference Setup',
    'Birthday Party Decoration',
    'Anniversary Celebration',
    'Product Launch Event',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.8),
                  Theme.of(context).primaryColor.withOpacity(0.4),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1000&q=80'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Event Gallery',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Showcasing our finest event creations',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).size.height * 0.5,
            child: FloatingActionButton(
              heroTag: "prev",
              mini: true,
              backgroundColor: Colors.white.withOpacity(0.9),
              onPressed: () {
                setState(() {
                  _currentImageIndex =
                      (_currentImageIndex - 1) % _eventImages.length;
                });
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Positioned(
            right: 20,
            top: MediaQuery.of(context).size.height * 0.5,
            child: FloatingActionButton(
              heroTag: "next",
              mini: true,
              backgroundColor: Colors.white.withOpacity(0.9),
              onPressed: () {
                setState(() {
                  _currentImageIndex =
                      (_currentImageIndex + 1) % _eventImages.length;
                });
              },
              child: Icon(Icons.arrow_forward_ios,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _eventImages[_currentImageIndex],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Image ${_currentImageIndex + 1} of ${_eventImages.length}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_eventImages.length, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentImageIndex
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: "share",
                  mini: true,
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Sharing ${_eventImages[_currentImageIndex]}')),
                    );
                  },
                  child: Icon(Icons.share, color: Colors.white),
                ),
                SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: "favorite",
                  mini: true,
                  backgroundColor: Colors.red,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added to favorites!')),
                    );
                  },
                  child: Icon(Icons.favorite, color: Colors.white),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: FloatingActionButton(
              heroTag: "back",
              mini: true,
              backgroundColor: Colors.white.withOpacity(0.9),
              onPressed: () {
                Navigator.pop(context);
              },
              child:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
