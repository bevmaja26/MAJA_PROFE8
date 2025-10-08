import 'package:flutter/material.dart';

class GridLayoutWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // First row of grid items
          Row(
            children: [
              Expanded(
                child: _buildGridItem(
                  context,
                  'Weddings',
                  Icons.favorite,
                  Colors.pink,
                  'Plan your perfect wedding day',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildGridItem(
                  context,
                  'Corporate',
                  Icons.business,
                  Colors.blue,
                  'Professional business events',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Second row of grid items
          Row(
            children: [
              Expanded(
                child: _buildGridItem(
                  context,
                  'Birthdays',
                  Icons.cake,
                  Colors.orange,
                  'Celebrate special milestones',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildGridItem(
                  context,
                  'Parties',
                  Icons.celebration,
                  Colors.green,
                  'Fun gatherings and celebrations',
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Third row with single centered item
          Row(
            children: [
              Expanded(
                child: _buildGridItem(
                  context,
                  'Custom Events',
                  Icons.star,
                  Colors.purple,
                  'Unique events tailored to you',
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _buildGridItem(
                  context,
                  'Consultations',
                  Icons.chat,
                  Colors.teal,
                  'Expert planning advice',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, IconData icon,
      Color color, String description) {
    return Container(
      height: 140,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 11,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
