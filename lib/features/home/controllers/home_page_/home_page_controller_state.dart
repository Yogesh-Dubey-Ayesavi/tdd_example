part of 'home_page_controller.dart';

@freezed
sealed class HomePageControllerState with _$HomePageControllerState {
  const HomePageControllerState._();
  const factory HomePageControllerState.loading() = HomePageLoadingState;
  const factory HomePageControllerState.data({required List<PostModel> posts}) = HomePageWithDataState;
  const factory HomePageControllerState.error(Object e) = HomePageWithErrorState;
  const factory HomePageControllerState.networkError() =
      HomePageWithWithNetworkErrorState;
}

extension HomePageControllerStateX on HomePageControllerState {
  bool get loading => this is HomePageLoadingState;
  bool get data => this is HomePageWithDataState;
  bool get error => this is HomePageWithErrorState;
  bool get networkError => this is HomePageWithWithNetworkErrorState;
}
