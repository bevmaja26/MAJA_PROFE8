import '../models/service_model.dart';

class EventServiceData {
  static List<EventService> getServices() {
    return [
      EventService(
        id: '1',
        title: 'Event Consultation',
        description:
            'Discuss your event type, theme, and budget with Beverly\'s team.',
        detailedDescription:
            'Our expert consultants will work with you to understand your vision, preferences, and budget constraints. We\'ll help you plan every detail from concept to execution.',
        icon: '💬',
        features: [
          'One-on-one consultation',
          'Budget planning assistance',
          'Theme development',
          'Timeline creation',
          'Vendor recommendations'
        ],
      ),
      EventService(
        id: '2',
        title: 'Venue Reservation',
        description:
            'Browse and book venues for weddings, birthdays, or corporate events.',
        detailedDescription:
            'Access our extensive network of premium venues suitable for any occasion. From intimate gatherings to grand celebrations, we have the perfect space for you.',
        icon: '🏛️',
        features: [
          'Venue selection assistance',
          'Site visits coordination',
          'Contract negotiation',
          'Availability checking',
          'Backup venue options'
        ],
      ),
      EventService(
        id: '3',
        title: 'Catering Services',
        description:
            'Choose menus, food packages, and book catering for your event.',
        detailedDescription:
            'Delight your guests with our curated selection of catering options. From elegant plated dinners to casual buffets, we cater to all tastes and dietary requirements.',
        icon: '🍽️',
        features: [
          'Custom menu creation',
          'Dietary accommodations',
          'Tasting sessions',
          'Service staff provision',
          'Equipment rental'
        ],
      ),
      EventService(
        id: '4',
        title: 'Entertainment Booking',
        description:
            'Hire DJs, performers, or interactive activities to make your event lively.',
        detailedDescription:
            'Keep your guests entertained with our roster of professional entertainers. From live bands to interactive experiences, we ensure your event is memorable.',
        icon: '🎵',
        features: [
          'DJ and live music booking',
          'Performance acts',
          'Interactive entertainment',
          'Sound system setup',
          'Entertainment coordination'
        ],
      ),
      EventService(
        id: '5',
        title: 'Decoration & Setup',
        description: 'Select decorations, lighting, and event setup services.',
        detailedDescription:
            'Transform your venue with our creative decoration and lighting solutions. Our design team will bring your vision to life with stunning visual elements.',
        icon: '🎨',
        features: [
          'Custom decoration design',
          'Lighting arrangements',
          'Floral arrangements',
          'Setup and breakdown',
          'Theme coordination'
        ],
      ),
      EventService(
        id: '6',
        title: 'Event Coordination',
        description:
            'Book coordinators to manage vendors, schedules, and ensure a smooth event.',
        detailedDescription:
            'Let our experienced coordinators handle all the logistics while you enjoy your special day. We manage every detail to ensure flawless execution.',
        icon: '📋',
        features: [
          'Day-of coordination',
          'Vendor management',
          'Timeline execution',
          'Problem resolution',
          'Guest assistance'
        ],
      ),
    ];
  }
}
