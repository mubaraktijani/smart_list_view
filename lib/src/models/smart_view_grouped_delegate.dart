part of '../models.dart';

class SmartViewGroupedDelegate<T> {

	final bool sort;
	final bool floatingHeader;
	final bool useStickyGroupSeparators;
	final Color stickyHeaderBackgroundColor;
	final Widget separator;
	final Widget? footer;
	final GroupedListOrder order;
	final dynamic Function(T)? groupBy;


	final int Function(T, T)? itemComparator;
	final int Function(dynamic, dynamic)? groupComparator;

	final Widget Function(T)? groupHeaderBuilder;
	final Widget Function(T)? groupStickyHeaderBuilder;
	final Widget Function(dynamic)? groupSeparatorBuilder;
	final Widget Function(BuildContext, T)? itemBuilder;
	final Widget Function(BuildContext, T, int)? indexedItemBuilder;
	final Widget Function(BuildContext, T?, T, T?)? interdependentItemBuilder;
	final Widget Function(BuildContext, T, bool, bool)? groupItemBuilder;

	const SmartViewGroupedDelegate({
		this.footer, 
		this.itemBuilder, 
		this.itemComparator, 
		this.groupComparator, 
		this.groupItemBuilder, 
		this.groupHeaderBuilder, 
		this.indexedItemBuilder, 
		this.groupSeparatorBuilder, 
		this.groupStickyHeaderBuilder, 
		this.interdependentItemBuilder, 
		this.groupBy,
		this.sort = true, 
		this.order = GroupedListOrder.ASC, 
		this.separator = const SizedBox.shrink(), 
		this.floatingHeader = false, 
		this.useStickyGroupSeparators = false, 
		this.stickyHeaderBackgroundColor = const Color(0xffF7F7F7)
	});
}