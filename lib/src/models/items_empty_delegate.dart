part of '../models.dart';

class ItemsEmptyDelegate {
	final Widget? icon;
	final String? message;
	final TextStyle? textStyle;
	final Widget Function(BuildContext)? builder;

	const ItemsEmptyDelegate({
		this.icon, 
		this.message,
		this.builder,
		this.textStyle, 
	});

	getView(BuildContext context) => builder ?? EmptyView(
		icon: icon,
		message: message,
		textStyle: textStyle,
	);

}