import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastic/app_provider.dart';

class AddBookModal extends StatefulWidget {
  const AddBookModal({super.key});

  @override
  State<AddBookModal> createState() => _AddBookModalState();
}

class _AddBookModalState extends State<AddBookModal> {
  TextEditingController nameController = TextEditingController();
  TextEditingController pageCountController = TextEditingController();

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
            'Yangi kitob qo\'shish',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kitob nomi',
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: pageCountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Sahifalar soni',
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            ),
          ),
          const SizedBox(height: 16),
          MaterialButton(
            padding: const EdgeInsets.symmetric(vertical: 12),
            onPressed: () async {
              if (nameController.text.trim().isNotEmpty && pageCountController.text.trim().isNotEmpty) {
                await provider.createBook(nameController.text, pageCountController.text);

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
