class AppointmentModel {
  final String year;
  final String month;
  final String day;
  final String note;
  final int appointment_id;
  final int meeting_room_id;
  final String initial_hour;
  final String end_hour;

  AppointmentModel({
    required this.year,
    required this.month,
    required this.day,
    required this.note,
    required this.meeting_room_id,
    required this.appointment_id,
    required this.initial_hour,
    required this.end_hour,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic?> json) {
    return AppointmentModel(
      year: json['year'],
      month: json['month'],
      day: json['day'],
      note: json['note'],
      meeting_room_id: json['meeting_room_id'],
      appointment_id: json['appointment_id'],
      initial_hour: json['initial_hour'],
      end_hour: json['end_hour'],
    );
  }
}
