import 'package:bookly/services/styles.dart';
import 'package:bookly/shared/Components/components.dart';
import 'package:bookly/shared/Cubits/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/shared/Cubits/manger/newest_books_cubit/newset_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../shared/Constants/constants.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 30.0,
                // end: 30.0,
              ),
              child: customAppBar(context: context),
            ),
            const SizedBox(
              height: 15.0,
            ),
            BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
              builder: (BuildContext context, FeaturedBooksState state) {
                if (state is FeaturedBooksSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 185.0,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(
                                  '/DetailsView',
                                );
                                detailBook = state.books[index].volumeInfo;
                              },
                              child: customListViewItem(
                                context: context,
                                imageUrl: state.books[index].volumeInfo
                                    .imageLinks?.thumbnail,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10.0,
                            );
                          },
                          itemCount: state.books.length),
                    ),
                  );
                } else if (state is FeaturedBooksFailure) {
                  return const Center(
                    child: Text(
                      "No Suggestions",
                      style: Styles.textStyle16,
                    ),
                  );
                } else if (state is FeaturedBooksLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SimilarBooksSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LimitedBox(
                      maxHeight: 185.0,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(
                                  '/DetailsView',
                                );
                                detailBook = state.books[index].volumeInfo;
                              },
                              child: customListViewItem(
                                context: context,
                                imageUrl: state.books[index].volumeInfo
                                    .imageLinks?.thumbnail,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10.0,
                            );
                          },
                          itemCount: state.books.length),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 30.0,
                // end: 30.0,
              ),
              child: Text(
                'Newest Books',
                style: Styles.textStyle20.copyWith(
                  fontSize: 17.0,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            LimitedBox(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 10.0,
                  start: 30.0,
                  // end: 30.0,
                ),
                child: BlocBuilder<NewsetBooksCubit, NewsetBooksState>(
                  builder: (context, state) {
                    if (state is NewsetBooksSuccess) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(
                                  '/DetailsView',
                                );
                                detailBook = state.books[index].volumeInfo;
                              },
                              child: customBestSellerItem(
                                context: context,
                                bookModel: state.books[index],
                              )),
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 20.0,
                              ),
                          itemCount: state.books.length);
                    } else if (state is NewsetBooksFailure) {
                      return const Center(
                        child: Text(
                          "No Suggestions",
                          style: Styles.textStyle16,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
