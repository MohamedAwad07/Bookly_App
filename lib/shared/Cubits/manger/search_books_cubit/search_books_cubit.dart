import 'package:bloc/bloc.dart';
import 'package:bookly/shared/Cubits/manger/search_books_cubit/search_books_state.dart';
import '../../../../Layout/data/models/repos/home_repo.dart';
import '../../../Constants/constants.dart';


class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit(this.homeRepo) : super(SearchBooksInitial());
  final HomeRepo homeRepo;
  Future<void> fetchSearchBooks({required String category}) async {
    if (category == "") {
      emit(SearchBooksWaiting());
    } else {
      emit(SearchBooksLoading());
      var result = await homeRepo.fetchSearchBooks(category: category);
      if (result.length() == 0) {
        emit(SearchBooksWaiting());
      } else {
        result.fold((failure) {
          emit(SearchBooksFailure(failure.errMessage));
        }, (books) {
          emit(SearchBooksSuccess(books));
        });
      }
    }
  }

}
