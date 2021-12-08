import 'package:flutter/material.dart';
import 'package:meetz/shared/models/room_model.dart';
import 'package:meetz/shared/widgets/list_view_widget.dart';

class RoomDataWidget extends StatelessWidget {
  final List<RoomModel>? list;

  const RoomDataWidget({
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
          image_url: list![index].image_url,
          name: list![index].name,
          number: list![index].number,
          floor: list![index].floor,
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          const Divider(color: Colors.transparent),
    );
  }
}
