part of '../layouts.dart';

class _GroupedViewLayout<T> extends StatelessWidget {

	final List<T> items;
	final ScrollController? controller;
	final SmartViewDecoration decoration;
	final SmartViewGroupedDelegate<T> delegate;
	final Widget Function(BuildContext, T) itemBuilder;
	final Widget? loadMoreButton;

	const _GroupedViewLayout({
		super.key,
		this.controller,
		this.loadMoreButton,
		required this.items,
		required this.delegate,
		required this.decoration,
		required this.itemBuilder
	});
	
	@override
	Widget build(BuildContext context) => GroupedListView(
		footer: loadMoreButton ?? delegate.footer,
		itemBuilder: delegate.itemBuilder, 
		itemComparator: delegate.itemComparator, 
		groupComparator: delegate.groupComparator,  
		groupHeaderBuilder: delegate.groupHeaderBuilder, 
		indexedItemBuilder: delegate.indexedItemBuilder, 
		groupSeparatorBuilder: delegate.groupSeparatorBuilder , 
		groupStickyHeaderBuilder: delegate.groupStickyHeaderBuilder,
		interdependentItemBuilder: delegate.interdependentItemBuilder, 
		sort: delegate.sort,
		order: delegate.order,
		separator: delegate.separator,
		floatingHeader: delegate.floatingHeader,
		useStickyGroupSeparators: delegate.useStickyGroupSeparators,
		stickyHeaderBackgroundColor: delegate.stickyHeaderBackgroundColor,
		elements: items,
		groupBy: delegate.groupBy ?? (item) => item.toString(),
		groupItemBuilder: (context, element, groupStart, groupEnd) {
			if(delegate.groupItemBuilder == null) {
			  return itemBuilder(context, element);
			}

			return delegate.groupItemBuilder!(context, element, groupStart, groupEnd);
		},
		primary: decoration.primary,
		reverse: decoration.reverse,
		shrinkWrap: decoration.shrinkWrap,
		clipBehavior: decoration.clipBehavior,
		physics: decoration.physics,
		dragStartBehavior: decoration.dragStartBehavior,
		padding: decoration.padding,
		keyboardDismissBehavior: decoration.keyboardDismissBehavior,
		controller: controller,
	);
}