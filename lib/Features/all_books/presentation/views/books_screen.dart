import 'package:eraa_books_store/Features/Splash/presentation/views/splash_screen.dart';
import 'package:eraa_books_store/Features/all_books/presentation/manager/cubit/books_cubit.dart';
import 'package:eraa_books_store/Features/all_books/presentation/manager/cubit/books_states.dart';
import 'package:eraa_books_store/Features/all_books/presentation/views/widgets/book_item_for_vertical_lists.dart';
import 'package:eraa_books_store/Features/home/presentation/views/widgets/book_item.dart';
import 'package:eraa_books_store/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../home/data/models/newArrivalsModel.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  TextEditingController search = TextEditingController();

  ScrollController scrollController = ScrollController();
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if(isLoading)return;
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        setState(() {
          isLoading=true;
          BlocProvider.of<SearchCubit>(context).searchBooks(search.text)
              .then((value) {isLoading=false;});

        });
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    search.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              controller: search,
              onChanged: (String value) {
                BlocProvider.of<SearchCubit>(context)
                  ..resetCubit()
                  ..searchBooks(value);
              },
            ),
            const SizedBox(
              height: 16,
            ),
            BlocProvider.value(
              value: BlocProvider.of<SearchCubit>(context)
                ..searchBooks(search.text),
              child: BlocConsumer<SearchCubit, SearchCubitState>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = BlocProvider.of<SearchCubit>(context);
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: cubit.products.length + 1,
                      itemBuilder: (context, index) {
                        if (index == cubit.products.length) {
                          if(!cubit.isThereNextPage){
                            return Container();
                          }
                          return const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          return BookItemForVerticalLists(products: cubit.products[index],listType: "All Books",showLastRow: isLoggedIn,);
                        }
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
