import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastic/app_provider.dart';
import 'package:tastic/models/note_model.dart';

class LogsTab extends StatefulWidget {
  const LogsTab({super.key});

  @override
  State<LogsTab> createState() => _LogsTabState();
}

class _LogsTabState extends State<LogsTab> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    return RefreshIndicator(
      onRefresh: () => provider.loadNotes(),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Note note = provider.notes[index];

          return ListTile(
            title: Text(note.book(provider.books).name),
            trailing: Text("${note.start} - ${note.end}"),
          );
        },
        itemCount: provider.notes.length,
      ),
    );
  }
}
