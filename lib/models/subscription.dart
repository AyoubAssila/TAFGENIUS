class SubscriptionModel {
  String id;
  String userName;
  String planName;
  double price;
  DateTime startDate;
  DateTime endDate;
  int coursesRemaining;
  String status;

  SubscriptionModel({
    required this.id,
    required this.userName,
    required this.planName,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.coursesRemaining,
    this.status = 'active',
  });
}
