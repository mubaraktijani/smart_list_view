part of '../layouts.dart';

class _ListViewLayout extends StatelessWidget {

	final int itemCount;
	final ScrollController? controller;
	final SmartViewDecoration decoration;
	final SmartViewListDelegate delegate;
	final Widget Function(BuildContext, int) itemBuilder;

	const _ListViewLayout({
		this.controller,
		required this.delegate,
		required this.itemCount,
		required this.decoration,
		required this.itemBuilder
	});
	
	@override
	Widget build(BuildContext context) => ListView.separated(
		primary: decoration.primary,
		reverse: decoration.reverse,
		shrinkWrap: decoration.shrinkWrap,
		clipBehavior: decoration.clipBehavior,
		physics: decoration.physics,
		dragStartBehavior: decoration.dragStartBehavior,
		padding: decoration.padding,
		keyboardDismissBehavior: decoration.keyboardDismissBehavior,
		controller: controller,
		itemCount: itemCount,
		itemBuilder: itemBuilder,
		separatorBuilder: delegate.separatorBuilder != null
			? delegate.separatorBuilder!
			: (context, index) => const SizedBox(height: 4)
	);
}