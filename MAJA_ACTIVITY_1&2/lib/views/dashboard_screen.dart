import 'package:flutter/material.dart';
import '../widgets/profile_card_widget.dart';
import '../widgets/grid_layout_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Dashboard'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Team profile section
            Text(
              'Meet Our Team',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 16),

            ProfileCardWidget(
              name: 'Beverly Johnson',
              role: 'Lead Event Coordinator',
              avatar: 'B',
              email: 'beverly@beverlysevents.com',
              phone: '+1 (555) 123-4567',
              skills: [
                'Wedding Planning',
                'Corporate Events',
                'Venue Selection',
                'Catering Coordination'
              ],
            ),

            SizedBox(height: 24),

            // Services grid section
            Text(
              'Service Categories',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 16),

            GridLayoutWidget(),

            SizedBox(height: 24),

            // Statistics section
            Text(
              'Our Achievements',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 16),

            // Row and Column combination for stats
            Column(
              children: [
                // First row of stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Events Completed',
                        '500+',
                        Icons.event_available,
                        Colors.blue,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Happy Clients',
                        '1000+',
                        Icons.people,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                // Second row of stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Years Experience',
                        '15+',
                        Icons.timeline,
                        Colors.orange,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        'Team Members',
                        '25+',
                        Icons.group,
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value,
      IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
