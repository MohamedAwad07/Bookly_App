import 'package:bookly/Layout/data/models/book_model/book_model.dart';
import 'package:bookly/services/styles.dart';
import 'package:bookly/shared/Cubits/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../services/asset_handler.dart';
import '../../services/launch_url.dart';
import '../../shared/Components/components.dart';
import '../../shared/Constants/constants.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var widthMedia = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          //    hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 30.0,
              end: 30.0,
              top: 10.0,
            ),
            child: Column(
              children: [
                customAppBarBookDetails(context: context),
                const SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: widthMedia * 0.15),
                  child: SizedBox(
                    height: 250.0,
                    child: customListViewItem(
                      context: context,
                      imageUrl: detailBook.imageLinks?.thumbnail ?? "",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Text(
                    detailBook.title!,
                    style: Styles.textStyle30.copyWith(fontSize: 20.0),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  detailBook.authors![0],
                  style: Styles.textStyle18.copyWith(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ratingItem(
                    isDetail: true,
                    averageRating: detailBook.averageRating,
                    rating: detailBook.ratingsCount),
                const SizedBox(
                  height: 32.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              'Free',
                              style: Styles.textStyle20.copyWith(
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 48.0,
                          decoration: const BoxDecoration(
                            color: Color(0xffef8262),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              launchCustomUr(context, detailBook.previewLink);
                            },
                            child: const Text(
                              'Preview',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    height: 40.0,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'You can also Like',
                    style: Styles.textStyle14.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
                  builder: (BuildContext context, FeaturedBooksState state) {
                    if (state is SimilarBooksSuccess) {
                      return LimitedBox(
                        maxHeight: 120.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                '/DetailsView',
                              );
                              detailBook = state.books[index].volumeInfo;
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: AspectRatio(
                                aspectRatio: 3 / 4,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: state.books[index].volumeInfo
                                          .imageLinks?.thumbnail ??
                                      '',
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                          itemCount: state.books.length,
                        ),
                      );
                    } else if (state is SimilarBooksFailure) {
                      return Text(
                        state.errMessage,
                        style: Styles.textStyle16,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
