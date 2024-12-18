part of '../models.dart';

class SmartViewDecoration {
	final bool? primary;
	final bool reverse;
	final bool shrinkWrap;
	final Clip clipBehavior;
	final ScrollPhysics? physics;
	final DragStartBehavior dragStartBehavior;
	final EdgeInsetsGeometry? padding;
	final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

	final ItemsEmptyDelegate emptyDelegate;
	final ItemsLoadingDelegate loadingDelegate;
	final ItemsLoadingErrorDelegate loadingErrorDelegate;

	const SmartViewDecoration({
		this.padding,
		this.physics,
		this.primary,
		this.reverse = false,
		this.shrinkWrap = false,
		this.clipBehavior = Clip.hardEdge,
		this.emptyDelegate = const ItemsEmptyDelegate(),
		this.loadingDelegate = const ItemsLoadingDelegate(),
		this.dragStartBehavior = DragStartBehavior.start, 
		this.loadingErrorDelegate = const ItemsLoadingErrorDelegate(),
		this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual
	});
}