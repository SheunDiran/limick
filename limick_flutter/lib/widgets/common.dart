import 'package:flutter/material.dart';
import 'package:limick_client/limick_client.dart';

import '../theme.dart';

/// Turns any error into a sentence a reader can act on.
String friendlyError(Object error) {
  if (error is AppException) return error.message;
  if (error is ServerpodClientNetworkException) {
    return "Can't reach Limick. Check your connection.";
  }
  if (error is ServerpodClientUnauthorized ||
      error is ServerpodClientForbidden) {
    return 'Your session expired. Please sign in again.';
  }
  if (error is ServerpodClientHttpException && error.statusCode >= 500) {
    return 'Something went wrong on our side. Try again in a moment.';
  }
  final text = error.toString().toLowerCase();
  if (text.contains('socket') ||
      text.contains('connection') ||
      text.contains('failed host lookup') ||
      text.contains('xmlhttprequest')) {
    return "Can't reach Limick. Check your connection.";
  }
  return 'Something went wrong. Please try again.';
}

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void showError(BuildContext context, Object error) =>
    showMessage(context, friendlyError(error));

String timeAgo(DateTime time) {
  final d = DateTime.now().difference(time.toLocal());
  if (d.inSeconds < 45) return 'now';
  if (d.inMinutes < 60) return '${d.inMinutes}m';
  if (d.inHours < 24) return '${d.inHours}h';
  if (d.inDays < 7) return '${d.inDays}d';
  final t = time.toLocal();
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${months[t.month - 1]} ${t.day}';
}

String compactCount(int n) {
  if (n < 1000) return '$n';
  if (n < 1000000) return '${(n / 1000).toStringAsFixed(n < 10000 ? 1 : 0)}k';
  return '${(n / 1000000).toStringAsFixed(1)}M';
}

/// Centred loading indicator in the accent colour.
class Loading extends StatelessWidget {
  const Loading({super.key});
  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 22,
      height: 22,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: context.palette.accent,
      ),
    ),
  );
}

/// A quiet empty or error state with an optional action.
class Empty extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const Empty({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.onAction,
  });

  factory Empty.error(Object error, {VoidCallback? onRetry}) => Empty(
    icon: Icons.cloud_off_outlined,
    title: 'Hmm.',
    message: friendlyError(error),
    actionLabel: onRetry == null ? null : 'Try again',
    onAction: onRetry,
  );

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 32, color: p.faint),
              const SizedBox(height: 16),
              Text(
                title,
                style: serif(size: 24, color: p.ink),
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: p.muted, height: 1.5),
                ),
              ],
              if (actionLabel != null) ...[
                const SizedBox(height: 20),
                OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Keeps content at a comfortable reading width on large screens.
class Readable extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  const Readable({super.key, required this.child, this.maxWidth = 640});
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topCenter,
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    ),
  );
}

/// Small rounded label, e.g. a topic or a status.
class Tag extends StatelessWidget {
  final String label;
  final Color? color;
  final IconData? icon;
  const Tag(this.label, {super.key, this.color, this.icon});
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final c = color ?? p.muted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: c),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: c,
            ),
          ),
        ],
      ),
    );
  }
}
