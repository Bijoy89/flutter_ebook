import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../Pages/BookPage/BookPage.dart';

class BookActionButton extends StatelessWidget {
  final String bookUrl;
  const BookActionButton({super.key, required this.bookUrl});

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
          // READ BOOK
          Expanded(
            child: InkWell(
              onTap: () => Get.to(BookPage(bookUrl: bookUrl)),
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

          // Vertical Divider
          Container(
            width: 2,
            height: 30,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: Theme.of(context).colorScheme.background,
          ),

          // PLAY BOOK
          Expanded(
            child: InkWell(
              onTap: () {
                // Future: handle audio play here
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("Assets/Icons/play.svg", height: 20),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "PLAY BOOK",
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
