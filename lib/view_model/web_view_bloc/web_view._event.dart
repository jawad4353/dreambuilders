part of 'web_view.dart';

abstract class WebViewEvent extends Equatable {
  const WebViewEvent();
}

class WebViewLoadingEvent extends WebViewEvent{
  const WebViewLoadingEvent();
  @override
  List<Object?> get props => [];
}

class WebViewLoadedEvent extends WebViewEvent{
  const WebViewLoadedEvent();
  @override
  List<Object?> get props => [];
}

class WebViewErrorEvent extends WebViewEvent{
  const WebViewErrorEvent();
  @override
  List<Object?> get props => [];
}