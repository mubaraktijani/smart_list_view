part of '../models.dart';

class ItemsLoadingErrorDelegate {
	final Widget? icon;
	final bool showError;
	final String? message;
	final TextStyle? textStyle;
	final Widget Function(BuildContext context, dynamic error)? builder;

	const ItemsLoadingErrorDelegate({
		this.icon, 
		this.message,
		this.builder,
		this.showError = true,
		this.textStyle,
	});

	getView(BuildContext context, dynamic error) => builder != null 
		? builder!(context, error)
		: EmptyView(
			icon: icon ?? const Icon(
				CupertinoIcons.exclamationmark_triangle,
				color: Color.fromARGB(161, 160, 24, 14),
				size: 50
			),
			message: message ?? 'Oops! An error occur',
			caption: showError ? error.toString() : null,
			textStyle: textStyle,
		);
}