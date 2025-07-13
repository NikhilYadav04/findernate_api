import 'package:delightful_toast/delight_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/app.dart';
import 'package:social_media_clone/services/connectivityServices.dart';

class GlobalConnectivityListener extends StatefulWidget {
  final Widget child;
  const GlobalConnectivityListener({Key? key, required this.child})
      : super(key: key);

  @override
  State<GlobalConnectivityListener> createState() =>
      _GlobalConnectivityListenerState();
}

class _GlobalConnectivityListenerState
    extends State<GlobalConnectivityListener> {
  @override
  void initState() {
    super.initState();
    // Wait until after build so that context is mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NetworkProvider>(context, listen: false)
          .addListener(_handleConnectivity);
    });
  }

  void _handleConnectivity() {
    final connected =
        Provider.of<NetworkProvider>(context, listen: false).isConnected;

    _ToastCardWidget.showToasty(
      maxHeight: 800,
      text: connected
          ? "Connected to Internet Connection!!"
          : "Please Connect To Internet!!",
      icon: connected ? Icons.wifi : Icons.wifi_off_sharp,
      color: connected ? Colors.green : Colors.red,
    );
  }

  @override
  void dispose() {
    Provider.of<NetworkProvider>(context, listen: false)
        .removeListener(_handleConnectivity);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _ToastCardWidget {
  static void showToasty({
    required double maxHeight,
    required String text,
    required IconData icon,
    required Color color,
  }) {
    // 1) Grab a context that is under your Navigator/Overlay
    final overlayCtx = navKey.currentState?.overlay?.context;
    if (overlayCtx == null) return;

    // 2) Build the toast’s widget
    WidgetBuilder toastBuilder = (ctx) {
      return Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                   
                text,
                style: const TextStyle(color: Colors.white,fontFamily: "Poppins-Bold",fontSize: 15),
              ),
            ),
          ],
        ),
      );
    };

    // 3) Instantiate DelightToastBar with only the builder
    final toast = DelightToastBar(
      snackbarDuration: Duration(days: 1),
      builder: toastBuilder, // ← no 'context' here
    );

    // 4) Then call show(...) with the overlay context
    toast.show(overlayCtx); // ← pass your valid BuildContext here
  }
}
