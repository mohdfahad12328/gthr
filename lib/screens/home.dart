import 'package:flutter/material.dart';
import 'package:gthr/utils/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //? bring this from backend
  final chatlist = ["fahad", "aymen", "lalith", "abc", "abc", "abc"];

  void addNewChat() {
    logger.d('clicked on addNewChat');
  }

  void onChatCLicked(int index) {
    logger.d('clicked on ${chatlist[index]}');
  }

  Widget chatListItem(int index) {
    return ListTile(
      title: TextButton(
        style: const ButtonStyle(),
        child: Text(
          chatlist[index],
          style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        onPressed: () {
          onChatCLicked(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GTHR - home'),
      ),
      body: ListView.builder(
          itemCount: chatlist.length,
          itemBuilder: (context, index) {
            return chatListItem(index);
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () => addNewChat(), child: const Icon(Icons.add)),
    );
  }
}
