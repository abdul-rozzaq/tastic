import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastic/app_provider.dart';
import 'package:tastic/modals/add_book_modal.dart';
import 'package:tastic/modals/add_note_modal.dart';
import 'package:tastic/tab/books_tab.dart';
import 'package:tastic/tab/logs_tab.dart';
import 'package:tastic/tab/statistics_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();

    Provider.of<AppProvider>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: [0, 2].contains(tabIndex)
          ? FloatingActionButton(
              onPressed: floatingActionButtonPress,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Kitoblar'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Statistika'),
          BottomNavigationBarItem(icon: Icon(Icons.edit_note_sharp), label: 'Qaydlar'),
        ],
        onTap: (value) => setState(() {
          tabIndex = value;
        }),
      ),
      appBar: AppBar(
        title: const Text('T A S T I C'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: tabIndex,
        children: const [
          BooksTab(),
          StatisticsTab(),
          LogsTab(),
        ],
      ),
    );
  }

  void floatingActionButtonPress() {
    Provider.of<AppProvider>(context, listen: false).setDate();

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const Border(),
      context: context,
      builder: (context) => [const AddBookModal(), Container(), const AddNoteModal()][tabIndex],
    );
  }
}
