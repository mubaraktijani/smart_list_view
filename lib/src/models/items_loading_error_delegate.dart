part of '../models.dart';

class ItemsLoadingErrorDelegate {
	final Widget? icon;
	final String? message;
	final Widget Function(BuildContext context, dynamic error)? builder;

	const ItemsLoadingErrorDelegate({
		this.icon, 
		this.message,
		this.builder
	});
}