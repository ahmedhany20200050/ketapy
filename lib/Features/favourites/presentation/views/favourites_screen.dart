import 'package:eraa_books_store/Features/all_books/presentation/views/widgets/book_item_for_vertical_lists.dart';
import 'package:eraa_books_store/Features/favourites/data/favourite_model.dart';
import 'package:eraa_books_store/Features/favourites/presentation/manager/cubit/favourites_states.dart';
import 'package:eraa_books_store/Features/home/data/models/newArrivalsModel.dart';
import 'package:eraa_books_store/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cubit/favourites_cubit.dart';

class FavouoritesScreen extends StatefulWidget {
  const FavouoritesScreen({super.key});

  @override
  State<FavouoritesScreen> createState() => _FavouoritesScreenState();
}

class _FavouoritesScreenState extends State<FavouoritesScreen> {
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
          BlocProvider.of<FavouritesCubit>(context).getFavourites()
              .then((value) {isLoading=false;});

        });
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
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

            const SizedBox(
              height: 8,
            ),
            BlocProvider.value(
              value: BlocProvider.of<FavouritesCubit>(context)
                ..getFavourites(),
              child: BlocConsumer<FavouritesCubit, FavouritesCubitState>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = BlocProvider.of<FavouritesCubit>(context);
                  print("Ui favourites");
                  print(cubit.favourites);
                  return Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: cubit.favourites.length + 1,
                      itemBuilder: (context, index) {
                        if (index == cubit.favourites.length) {
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
                          var fav=cubit.favourites[index];
                          Products product=Products(
                            name: fav.name,
                            id: fav.id,
                            description: fav.description,
                            image: fav.image,
                            bestSeller: fav.bestSeller,
                            category: fav.category,
                            discount: fav.discount,
                            price: fav.price,
                            priceAfterDiscount: (double.parse(fav.price!)*(fav.discount!/100)).ceilToDouble(),
                            stock: fav.stock,
                          );
                          return BookItemForVerticalLists(products: product);
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
