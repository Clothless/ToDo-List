import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu_rounded,
              color: Colors.grey,
            ),
            Icon(Icons.person)
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: bgColor),
        child: const Column(
          children: [
            SearchBox()
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: grey,),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25
          ),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: grey)
        ),
      ),
    );
  }
}
