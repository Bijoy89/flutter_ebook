import 'package:flutter/material.dart';
import 'package:flutter_ebook/Components/MultilineTextFormField.dart';
import 'package:flutter_ebook/Components/MyTextFormField.dart';
import 'package:flutter_ebook/Config/Colors.dart';

import '../../Components/BackButton.dart';

class AddNewBookPage extends StatelessWidget {
  const AddNewBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 500,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyBackButton(),
                            Text(
                              "Add New Book",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.background,
                                  ),
                            ),
                            SizedBox(width: 70),
                          ],
                        ),
                        SizedBox(height: 60),
                        Container(
                          height: 190,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Icon(Icons.add),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Book PDF",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.background,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.audio_file,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Book Audio",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.background,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Book title",
                    icon: Icons.book,
                    controller: controller,
                  ),
                  SizedBox(height: 10),
                  MultiLineTextFormField(
                    hintText: "Book Description",
                    controller: controller,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "Author Name",
                    icon: Icons.person,
                    controller: controller,
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    hintText: "About Author ",
                    icon: Icons.person,
                    controller: controller,
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Price",
                          icon: Icons.currency_rupee,
                          controller: controller,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Pages",
                          icon: Icons.book,
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Language",
                          icon: Icons.language,
                          controller: controller,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: MyTextFormField(
                          hintText: "Audio Len",
                          icon: Icons.audiotrack,
                          controller: controller,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cancel,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Cancel",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_sharp,
                                color: Theme.of(context).colorScheme.background,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Post",
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.background,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
