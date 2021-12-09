import 'package:flutter/material.dart';
import 'package:meetz/shared/models/room_model.dart';
import 'package:meetz/shared/widgets/list_view_widget.dart';

class RoomDataManegmentWidget extends StatelessWidget {
  final List<RoomModel>? list;

  const RoomDataManegmentWidget({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: list!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListViewWidget(
          isManegment: true,
          image_url: list![index].image_url,
          name: list![index].name,
          number: list![index].number,
          floor: list![index].floor,
          id_room: list![index].id_room,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(color: Colors.transparent),
    );
  }
}
