class TaskModel {
  final String id;
  final String name;
  final String estimation;
  final String specialization;
  String? assignedTo;
  final int date;
  final String state;

  TaskModel({
    required this.assignedTo,
    required this.id,
    required this.name,
    required this.estimation,
    required this.specialization,
    required this.date,
    required this.state,
  });
}
