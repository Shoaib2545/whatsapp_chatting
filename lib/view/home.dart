import 'package:flutter/material.dart';
import 'package:whatsapp/view/screens/tabs/calls.dart';
import 'package:whatsapp/view/screens/tabs/camera.dart';
import 'package:whatsapp/view/screens/tabs/chats.dart';
import 'package:whatsapp/view/screens/tabs/status.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp'),
          bottom: TabBar(
            controller: _controller,
            unselectedLabelColor: Colors.black45,
            tabs: const [
              SizedBox(
                width: 10,
                child: Icon(Icons.camera_alt_rounded),
              ),
              SizedBox(
                width: 80,
                child: Text('CHATS'),
              ),
              SizedBox(
                width: 80,
                child: Text('STATUS'),
              ),
              SizedBox(
                width: 80,
                child: Text('CALLS'),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                InkWell(
                    onTap: () {
                      print('search');
                    },
                    child: const Icon(Icons.search)),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    print('option');
                  },
                  child: const Icon(Icons.more_vert),
                ),
              ],
            )
          ],
        ),
        body: TabBarView(
          controller: _controller,
          children: const [
            CameraTab(),
            ChatsTab(),
            StatusTab(),
            CallsTab(),
          ],
        ));
  }
}
