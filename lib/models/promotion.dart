class PromotionModel {
  String id;
  String title;
  DateTime start;
  DateTime end;
  String recurrence;
  String condition;
  double percentOff;

  PromotionModel({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    this.recurrence = 'none',
    this.condition = '',
    this.percentOff = 10.0,
  });
}
