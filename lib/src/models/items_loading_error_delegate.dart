part of '../models.dart';

class ItemsLoadingErrorDelegate {
	final Widget? icon;
	final bool showError;
	final String? message;
	final TextStyle? textStyle;
	final Widget Function(BuildContext context, dynamic error, Function()? refreshCallback)? builder;

	const ItemsLoadingErrorDelegate({
		this.icon, 
		this.message,
		this.builder,
		this.showError = true,
		this.textStyle
	});

	getView(BuildContext context, dynamic error, Function()? refreshCallback) => builder != null 
		? builder!(context, error, refreshCallback)
		: LoadingErrorView(
			icon: icon ?? const Icon(
				CupertinoIcons.exclamationmark_triangle,
				color: Color.fromARGB(161, 160, 24, 14),
				size: 50
			),
			message: showError ? error.toString() : null,
			textStyle: textStyle,
			onReload: refreshCallback
		);
}