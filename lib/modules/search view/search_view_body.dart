import 'package:bookly/modules/search%20view/waiting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../services/styles.dart';
import '../../shared/Components/components.dart';
import '../../shared/Constants/constants.dart';
import '../../shared/Cubits/manger/search_books_cubit/search_books_cubit.dart';
import '../../shared/Cubits/manger/search_books_cubit/search_books_state.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 15.0,
          // end: 30.0,
          top: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customAppBarSearchView(context: context),
            const SizedBox(
              height: 30.0,
            ),
            defaultTextField(
              label: 'Search for a book ...',
              onChange: (value) {
                BlocProvider.of<SearchBooksCubit>(context)
                    .fetchSearchBooks(category: value);
              },
              sufIcon: IconButton(
                onPressed: () {},
                icon: const Opacity(
                  opacity: 0.8,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
              context: context,
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Padding(
              padding: EdgeInsetsDirectional.only(
                top: 10.0,
                start: 10.0,
                // end: 30.0,
              ),
              child: Text(
                'Search Result',
                style: Styles.textStyle20,
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
                  start: 10.0,
                  // end: 30.0,
                ),
                child: BlocBuilder<SearchBooksCubit, SearchBooksState>(
                  builder: (context, state) {
                    if (state is SearchBooksFailure) {
                      return const Center(
                        child: Text(
                          "No Suggestions",
                          style: Styles.textStyle16,
                        ),
                      );
                    } else if (state is SearchBooksSuccess) {
                      return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                GoRouter.of(context).push(
                                  '/DetailsView',
                                );
                                detailBook = state.books[index].volumeInfo;
                              },
                              child: customBestSellerItem(
                                context: context,
                                bookModel: state.books[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 15.0,
                            );
                          },
                          itemCount: state.books.length);
                    } else if (state is SearchBooksLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return const Waiting();
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
