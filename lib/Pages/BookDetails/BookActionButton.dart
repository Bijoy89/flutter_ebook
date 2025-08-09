import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Pages/BookPage/BookPage.dart';

class BookActionButton extends StatelessWidget {
  final String bookUrl;
  final String bookId;
  final VoidCallback onRead;

  const BookActionButton({
    super.key,
    required this.bookUrl,
    required this.bookId,
    required this.onRead,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                onRead(); // Mark as read
                Get.to(() => BookPage(bookUrl: bookUrl));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("Assets/Icons/book.svg", height: 20),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "READ BOOK",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.background,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
