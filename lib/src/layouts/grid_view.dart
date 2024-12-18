part of '../layouts.dart';

class _GridViewLayout extends StatelessWidget {

	final int itemCount;
	final ScrollController? controller;
	final SmartViewDecoration decoration;
	final SmartViewGridDelegate delegate;
	final Widget Function(BuildContext, int) itemBuilder;

	const _GridViewLayout({
		super.key,
		this.controller,
		required this.delegate,
		required this.itemCount,
		required this.decoration,
		required this.itemBuilder
	});
	
	@override
	Widget build(BuildContext context) => GridView.builder(
		primary: decoration.primary,
		reverse: decoration.reverse,
		physics: decoration.physics,
		padding: decoration.padding,
		itemCount: itemCount,
		controller: controller,
		shrinkWrap: decoration.shrinkWrap,
		itemBuilder: itemBuilder,
		clipBehavior: decoration.clipBehavior,
		dragStartBehavior: decoration.dragStartBehavior,
		keyboardDismissBehavior: decoration.keyboardDismissBehavior,
		gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
			crossAxisCount: delegate.screenCrossAxisCounts(context),
			mainAxisSpacing: delegate.mainAxisSpacing,
			crossAxisSpacing: delegate.crossAxisSpacing,
			childAspectRatio: delegate.childAspectRatio,
		)
	);
}