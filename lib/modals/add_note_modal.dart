import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastic/app_provider.dart';
import 'package:tastic/models/book_model.dart';

class AddNoteModal extends StatefulWidget {
  const AddNoteModal({super.key});

  @override
  State<AddNoteModal> createState() => _AddNoteModalState();
}

class _AddNoteModalState extends State<AddNoteModal> {
  TextEditingController startPageController = TextEditingController();
  TextEditingController endPageController = TextEditingController();

  Book? selectedBook;

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 15,
        bottom: MediaQuery.of(context).viewInsets.bottom + 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Yangi qayd qo\'shish',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: const Border.fromBorderSide(BorderSide(color: Colors.black54)),
              borderRadius: BorderRadius.circular(4.0), // Set the desired border radius
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Book>(
                isExpanded: true,
                value: selectedBook,
                items: provider.books
                    .map((e) => DropdownMenuItem<Book>(
                          value: e,
                          child: Text(e.name),
                        ))
                    .toList(),
                onChanged: (value) => setState(() {
                  selectedBook = value;
                }),
                hint: const Text('Kitob'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: startPageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Boshlash',
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: endPageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Tugallash',
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => showModalBottomSheet(
              shape: const Border(),
              context: context,
              builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 300,
                    child: CupertinoDatePicker(
                      initialDateTime: DateTime.now(),
                      mode: CupertinoDatePickerMode.dateAndTime,
                      minimumDate: DateTime(2023),
                      maximumDate: DateTime.now(),
                      use24hFormat: true,
                      onDateTimeChanged: provider.updateDateTime,
                    ),
                  ),
                ],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: const Border.fromBorderSide(BorderSide(color: Colors.black54)),
                borderRadius: BorderRadius.circular(4.0), // Set the desired border radius
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sana'),
                  Text(
                    provider.getLabel,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 12),
            onPressed: () async {
              if (startPageController.text.trim().isNotEmpty && endPageController.text.trim().isNotEmpty && selectedBook != null) {
                await Provider.of<AppProvider>(context, listen: false).createNote(selectedBook!.id, startPageController.text, endPageController.text);

                if (mounted) {
                  Navigator.pop(context);
                }
              }
            },
            color: Theme.of(context).primaryColor,
            minWidth: double.maxFinite,
            textColor: Colors.white,
            child: const Text('Qo\'shish'),
          )
        ],
      ),
    );
  }
}
