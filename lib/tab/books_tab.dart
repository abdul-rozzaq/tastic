import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastic/app_provider.dart';
import 'package:tastic/models/book_model.dart';

class BooksTab extends StatefulWidget {
  const BooksTab({super.key});

  @override
  State<BooksTab> createState() => _BooksTabState();
}

class _BooksTabState extends State<BooksTab> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    return provider.isBooksLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => provider.loadBooks(),
            child: ListView.builder(
              itemCount: provider.books.length,
              itemBuilder: (BuildContext context, int index) {
                Book book = provider.books[index];
                // ListTile(pa);
                return CustListTile(
                  book: book,
                  onLongPress: () => showDeleteBottomSheet(book),
                  onTap: () => showUpdateBottomSheet(book),
                );
              },
            ),
          );
  }

  showUpdateBottomSheet(Book book) {
    TextEditingController nameController = TextEditingController(text: book.name);
    TextEditingController pageCountController = TextEditingController(text: book.pagesCount.toString());

    showModalBottomSheet(
      isScrollControlled: true,
      shape: const Border(),
      context: context,
      builder: (context) => Padding(
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
              'Kitobni yangilash',
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
                  await Provider.of<AppProvider>(context, listen: false).updateBook(book, nameController.text, pageCountController.text);

                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              color: Theme.of(context).primaryColor,
              minWidth: double.maxFinite,
              textColor: Colors.white,
              child: const Text('Update'),
            )
          ],
        ),
      ),
    );
  }

  showDeleteBottomSheet(Book book) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const Border(),
      context: context,
      builder: (context) => Padding(
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
            Text(
              'Haqiqatdan ham ${book.name} ni o\'chirmoqchimisiz?',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 12),
              onPressed: () async {
                await Provider.of<AppProvider>(context, listen: false).deleteBook(book);

                if (mounted) {
                  Navigator.pop(context);
                }
              },
              color: Colors.red,
              minWidth: double.maxFinite,
              textColor: Colors.white,
              child: const Text('O\'chirish'),
            ),
            const SizedBox(height: 8),
            MaterialButton(
              padding: const EdgeInsets.symmetric(vertical: 12),
              onPressed: () => Navigator.pop(context),
              minWidth: double.maxFinite,
              child: const Text('Bekor qilish'),
            )
          ],
        ),
      ),
    );
  }
}

class CustListTile extends StatefulWidget {
  const CustListTile({
    super.key,
    required this.book,
    required this.onLongPress,
    required this.onTap,
  });

  final Book book;
  final Function() onTap;
  final Function() onLongPress;

  @override
  State<CustListTile> createState() => _CustListTileState();
}

class _CustListTileState extends State<CustListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      child: InkWell(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.book.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.book.pagesCount.toString(),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(5)),                height: 3,
                width: (MediaQuery.of(context).size.width - (2 * 2 + 16 * 2)) * Random().nextDouble(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
