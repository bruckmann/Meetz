class InfoRoomModel {
  final String image_url;
  final String name;
  final String number;
  final String floor;
  final String description;
  final int max_person;
  final bool? has_data_show;
  final bool? has_board;
  final bool? has_split;
  final String size;

  InfoRoomModel({
    required this.image_url,
    required this.name,
    required this.number,
    required this.floor,
    required this.description,
    required this.max_person,
    required this.has_data_show,
    required this.has_board,
    required this.has_split,
    required this.size,
  });

  factory InfoRoomModel.fromJson(Map<String, dynamic?> json) {
    return InfoRoomModel(
      image_url: json['image_url'],
      name: json['name'],
      number: json['number'],
      floor: json['floor'],
      description: json['description'],
      max_person: json['max_person'],
      has_data_show: json['has_data_show'],
      has_board: json['has_board'],
      has_split: json['has_split'],
      size: json['size'],
    );
  }
}
