class RoomModel {
  final String name;
  final String description;
  final int max_person;
  final bool has_data_show;
  final bool has_board;
  final bool has_split;
  final String size;
  final String image_url;
  final String floor;
  final String number;

  RoomModel({
    required this.name,
    required this.description,
    required this.max_person,
    required this.has_data_show,
    required this.has_board,
    required this.has_split,
    required this.size,
    required this.image_url,
    required this.floor,
    required this.number,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
        name: json['name'],
        description: json['description'],
        max_person: json['max_person'],
        has_data_show: json['has_data_show'],
        has_board: json['has_board'],
        has_split: json['has_split'],
        size: json['size'],
        image_url: json['image_url'],
        floor: json['floor'],
        number: json['number']);
  }
}
