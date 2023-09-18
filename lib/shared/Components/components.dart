import 'package:bookly/Layout/data/models/book_model/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../services/asset_handler.dart';
import '../../services/styles.dart';
import '../Constants/color_manager.dart';

Widget customAppBar({required BuildContext context}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5.0,
        ),
        child: Row(
          children: [
            Image.asset(
              AssetHandler.logo,
              height: 25.0,
              width: 85.0,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                GoRouter.of(context).push('/SearchView');
              },
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                size: 24.0,
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget customListViewItem({
  required BuildContext context,
  required String? imageUrl,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15.0),
    child: AspectRatio(
      aspectRatio: 3 / 4,
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl ??
            "",
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
        ),
      ),
    ),
  );
}

Widget customBestSellerItem({
  required BuildContext context,
  required BookModel bookModel,
}) {
  String? imageUrl = bookModel.volumeInfo.imageLinks?.thumbnail;
  return SizedBox(
    height: 120.0,
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imageUrl ??
                  "",
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 30.0,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 7.0),
                child: Text(
                  bookModel.volumeInfo.title!,
                  style: Styles.textStyle20.copyWith(fontSize: 18.0),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Text(
                bookModel.volumeInfo.authors![0],
                style: Styles.textStyle14.copyWith(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 7.0,
              ),
              Row(
                children: [
                  Text(
                    'Free',
                    style: Styles.textStyle20.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const Spacer(),
                  ratingItem(bookModel: bookModel, isDetail: false),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget customAppBarBookDetails({required BuildContext context}) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.shopping_cart_outlined,
        ),
      ),
    ],
  );
}

Widget customAppBarSearchView({required BuildContext context}) {
  return Row(
    children: [
      IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
    ],
  );
}

Widget ratingItem({
  BookModel? bookModel,
  num? averageRating,
  int? rating,
  required bool isDetail,
}) {
  String? text;
  String? text2;
  if (bookModel?.volumeInfo.averageRating.toString() == 'null') {
    text = '0';
  } else {
    text = bookModel?.volumeInfo.averageRating.toString();
  }
  if (averageRating.toString() == 'null') {
    text2 = '0';
  } else {
    text2 = averageRating.toString();
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const Opacity(
        opacity: 0.9,
        child: Icon(
          FontAwesomeIcons.solidStar,
          color: Colors.amber,
          size: 15.0,
        ),
      ),
      const SizedBox(
        width: 6.3,
      ),
      Text(
        isDetail ? text2 : text ?? '0',
        style: Styles.textStyle16.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18.0,
        ),
      ),
      const SizedBox(
        width: 5.0,
      ),
      Text(
        isDetail
            ? '(${rating ?? 0})'
            : '(${bookModel?.volumeInfo.ratingsCount ?? 0})',
        style: Styles.textStyle14.copyWith(
          color: Colors.grey,
        ),
      ),
    ],
  );
}

Widget defaultTextField({
  required String label,
  required TextEditingController controller,
  IconButton? sufIcon,
  TextInputType? keyboard,
  bool isObscure = false,
  required BuildContext context,
  void Function()? obscure,
}) {
  var normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.0),
      borderSide: const BorderSide(width: 2));
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 25.0,
      end: 25.0,
    ),
    child: TextField(
      style: Theme.of(context).textTheme.titleMedium,
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboard,
      decoration: InputDecoration(
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: normalBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        labelText: label,
        suffixIcon: sufIcon,
      ),
    ),
  );
}
