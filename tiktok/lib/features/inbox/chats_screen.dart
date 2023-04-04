import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Direct messages'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.plus))
        ],
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 20,
                child: Text('울쨩'),
                // foregroundImage: NetworkImage(url),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "용쨩",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "2:16 PM",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size14,
                    ),
                  )
                ],
              ),
              subtitle: const Text('Minds Open, Eyes Open!'),
//          trailing: Text("2:16 PM",
              //            style: TextStyle(
              //              color: Colors.grey.shade500, fontSize: Sizes.size14)),
            )
          ]),
    );
  }
}
