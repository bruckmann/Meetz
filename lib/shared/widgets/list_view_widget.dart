import 'package:flutter/material.dart';
import 'package:meetz/core/core.dart';

class ListViewWidget extends StatelessWidget {
  final String image_url;
  final String name;
  final String number;
  final String floor;

  const ListViewWidget({
    Key? key,
    required this.image_url,
    required this.name,
    required this.number,
    required this.floor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(image_url),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${name}', style: roomTextDecorationStyle),
                    Text("Sala: ${number} - ${floor}º andar",
                        style: roomTextDecorationStyle),
                    IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        size: 30,
                        color: AppColors.green800,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
