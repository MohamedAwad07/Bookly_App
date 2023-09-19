import 'package:equatable/equatable.dart';
import '../../../../Layout/data/models/book_model/book_model.dart';

abstract class SearchBooksState extends Equatable {
  const SearchBooksState();

  @override
  List<Object> get props => [];
}

class SearchBooksInitial extends SearchBooksState {}

class SearchBooksFailure extends SearchBooksState {
  final String errMessage;

  const SearchBooksFailure(this.errMessage);
}

class SearchBooksSuccess extends SearchBooksState {
  final List<BookModel> books;

  const SearchBooksSuccess(this.books);
}

class SearchBooksLoading extends SearchBooksState {}

class SearchBooksWaiting extends SearchBooksState {}
