import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../utilis/app_colors.dart';
import '../../../view_model/web_view_bloc/web_view.dart';
import '../../widgets/custom_appbar.dart';

class WebViewHelper extends StatefulWidget {
  final String url, title;

  const WebViewHelper(this.url, this.title, {super.key});

  @override
  State<WebViewHelper> createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    webViewControllerInitialization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(59.0),
        child: myAppBar(title: widget.title, context: context, shouldPop: true),
      ),
      body: BlocBuilder<WebViewBloc, WebViewState>(builder: (context, state) {
        if (state is WebViewLoadedState) {
          return WebViewWidget(
            controller: controller,
          );
        }
        if (state is WebViewLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is WebViewErrorState) {
          return const Center(child: Text('Something went wrong'));
        }
        return Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        ));
      }),
    );
  }

  void webViewControllerInitialization() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            context.read<WebViewBloc>().add(const WebViewLoadingEvent());
          },
          onPageFinished: (String url) {
            context.read<WebViewBloc>().add(const WebViewLoadedEvent());
          },
          onHttpError: (HttpResponseError error) {
            context.read<WebViewBloc>().add(const WebViewErrorEvent());
          },
          onWebResourceError: (WebResourceError error) {
            context.read<WebViewBloc>().add(const WebViewErrorEvent());
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
}
