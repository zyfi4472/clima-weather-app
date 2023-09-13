import 'package:bloc/bloc.dart';
import 'package:clima_weather_app/repository/repo.dart';
import 'package:meta/meta.dart';

part 'price_state.dart';

class PriceCubit extends Cubit<PriceState> {
  PriceCubit() : super(PriceInitial());

  fetchPriceData(String fiatCurrency) async {
    try {
      emit(PriceLoading());

      final int? statusBTC = await DataRepo.fetchData('BTC', fiatCurrency);
      final int? statusETH = await DataRepo.fetchData('ETH', fiatCurrency);
      final int? statusLTC = await DataRepo.fetchData('LTC', fiatCurrency);

      if (statusBTC == 200 && statusETH == 200 && statusLTC == 200) {
        emit(
          PriceLoaded(),
        );
      } else if (statusBTC == 501 && statusETH == 501 && statusLTC == 501) {
        emit(
          PriceNoInternet(),
        );
      } else if (statusBTC == 404 && statusETH == 404 && statusLTC == 404) {
        emit(
          PriceException(error: 'Authentication Error'),
        );
      }
    } catch (e) {
      PriceException(error: 'Something went wrong');
    }
  }
}
