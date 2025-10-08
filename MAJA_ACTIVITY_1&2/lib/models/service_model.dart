class EventService {
  final String id;
  final String title;
  final String description;
  final String detailedDescription;
  final String icon;
  final List<String> features;

  EventService({
    required this.id,
    required this.title,
    required this.description,
    required this.detailedDescription,
    required this.icon,
    required this.features,
  });
}
