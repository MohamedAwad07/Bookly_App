import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/styles.dart';
import '../../shared/Components/components.dart';
import '../../shared/Constants/constants.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              label: 'Search',
              controller: searchController,
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
            Padding(
              padding: const EdgeInsetsDirectional.only(
                top: 10.0,
                start: 10.0,
                // end: 30.0,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('/DetailsView');
                  },
                  //
                  child: const Text(
                    "sui",
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20.0,
                ),
                itemCount: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
