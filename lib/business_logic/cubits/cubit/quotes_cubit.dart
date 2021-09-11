import 'package:bloc/bloc.dart';
import '../../../data/models/quote.dart';
import '../../../data/repositories/quotes_repository.dart';
import 'package:meta/meta.dart';

part 'quotes_state.dart';

class QuotesCubit extends Cubit<QuotesState> {
  QuotesCubit(this.quoteRepository) : super(QuotesInitial());
  final QuoteRepository quoteRepository;

  Quote? quote;

  void loadRandomQuote() {
    quoteRepository.fetchRandomQuote().then((value) {
      quote = value;
      emit(RandomQuoteLoaded());
    });
  }
}
