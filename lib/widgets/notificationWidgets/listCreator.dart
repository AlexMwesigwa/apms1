
class ListItem {
  final String title;
  final String message;
  final DateTime date;

  ListItem({required this.title, required this.date, required this.message});
}

List<ListItem> filteredItems = [];
final List<ListItem> availableNotification = [
  ListItem(
      title: 'Temperature sensor',
      date: DateTime.now(),
      message: "Reading: 30*C"),
  ListItem(
      title: 'Alarm sensor',
      date: DateTime.now().subtract(const Duration(days: 1)),
      message: "Reading: 30*C"),
  ListItem(
      title: 'Camera reading', date: DateTime.now(), message: "Reading: 30*C"),
  ListItem(
      title: 'Audio sensor', date: DateTime.now(), message: "Reading: 30*C"),
  ListItem(
      title: 'led control', date: DateTime.now(), message: "Reading: 30*C"),
  ListItem(
      title: 'Weight senosr',
      date: DateTime.now().subtract(const Duration(days: 1)),
      message: "Reading: 30*C"),
  // Add more items as needed
];
