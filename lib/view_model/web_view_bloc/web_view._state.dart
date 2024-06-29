part of 'web_view.dart';

abstract class WebViewState extends Equatable{
  const WebViewState();
}

class WebViewInitialState extends WebViewState {
  @override
  List<Object> get props => [];
}


class WebViewLoadingState extends WebViewState {
  @override
  List<Object> get props => [];
}


class WebViewLoadedState extends WebViewState {
  @override
  List<Object> get props => [];
}


class WebViewErrorState extends WebViewState {
  @override
  List<Object> get props => [];
}

