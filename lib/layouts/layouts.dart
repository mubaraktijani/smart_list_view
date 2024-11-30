
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:grouped_list/grouped_list.dart' show GroupedListOrder, GroupedListView;
import 'package:smart_list_view/loader/index.dart';
import 'package:smart_list_view/smart_list_view.dart';

class GridDelegate {
	final int crossAxisCount;
	final double? itemMaxWidth;
	final double crossAxisSpacing;
	final double mainAxisSpacing;
	final double childAspectRatio;

	const GridDelegate({
		this.itemMaxWidth,
		this.crossAxisCount = 2,
		this.mainAxisSpacing = 16.0,
		this.crossAxisSpacing = 16.0,
		this.childAspectRatio = 1.0, 
	});

	int screenCrossAxisCounts(BuildContext context) {
		double screenWidth = MediaQuery.of(context).size.width;
		if (itemMaxWidth == null) return crossAxisCount;
		return (screenWidth / itemMaxWidth!).floor();
	}
}

class LoaderStyle {
	final Color baseColor;
	final Color highlightColor;
	final ShimmerDirection direction;

	const LoaderStyle({
		this.baseColor = const Color(0xFFE0E0E0), 
		this.highlightColor = const Color(0xFF868686),
		this.direction = ShimmerDirection.ltr
	});
}

class SmartListViewLayout<T> extends StatelessWidget {

	final List<T> items;
	final bool shrinkWrap;
	final bool isLoading;
	final bool showLoadMoreButton;

	final LoaderStyle loaderStyle;
	final GridDelegate gridDelegate;
	final ScrollPhysics? physics;
	final SmartListLayout layout;
	final GroupedListOrder order;
	final ScrollController? controller;
	final EdgeInsetsGeometry? padding;

	final dynamic Function(T)? groupBy;
	final Widget Function(dynamic)? separatorBuilder;
	final Widget Function(BuildContext, T) itemBuilder;
	final Function()? onLoadMoreClicked;

	const SmartListViewLayout({
		super.key, 
		this.order = GroupedListOrder.ASC, 
		this.physics, 
		this.padding, 
		this.gridDelegate = const GridDelegate(), 
		this.loaderStyle = const LoaderStyle(),
		this.groupBy, 
		this.layout = SmartListLayout.list,
		this.controller, 
		this.shrinkWrap = false, 
		this.separatorBuilder,
		required this.items, 
		required this.itemBuilder,
		this.isLoading = false,
		this.showLoadMoreButton = false, 
		this.onLoadMoreClicked, 
	});

	static Widget loader({
		LoaderStyle loaderStyle = const LoaderStyle(),
		SmartListLayout layout = SmartListLayout.list,
		EdgeInsetsGeometry? padding,
		GridDelegate gridDelegate = const GridDelegate(),
	}) => Shimmer.fromColors(
		baseColor: loaderStyle.baseColor,
		highlightColor: loaderStyle.highlightColor,
		direction: loaderStyle.direction,
		child: SmartListViewLayout(
			items: List.filled(20, 0), 
			layout: layout,
			padding: padding, 
			physics: const NeverScrollableScrollPhysics(),
			isLoading: true,
			shrinkWrap: true, 
			loaderStyle: loaderStyle,
			itemBuilder: (context, item) => SmartListViewLoader(
				layout: layout,
			), 
			gridDelegate: gridDelegate,
		)
	);

	int get itemCount => isLoading || showLoadMoreButton 
		? items.length+1 
		: items.length;
	
	@override
	Widget build(BuildContext context) {
		switch (layout) {
			case SmartListLayout.grid:
				return _gridView(context);
			case SmartListLayout.grouped:
				return _groupedListView();
			default:
				return _listView();
		}
	}

	Widget _itemBuilder(BuildContext context, int index) {
		if(items.length < index+1) return loadingView();
		return itemBuilder(context, items[index]);
	}
	
	Widget _listView() => ListView.separated(
		padding: padding,
		itemCount: itemCount,
		physics: physics,
		shrinkWrap: shrinkWrap,
		controller: controller,
		itemBuilder: _itemBuilder,
		separatorBuilder: (context, index) => separatorBuilder != null
			? separatorBuilder!(index)
			: const SizedBox(),
	);

	Widget _groupedListView() => GroupedListView(
		sort: false,
		order: order,
		elements: items,
		shrinkWrap: shrinkWrap,
        controller: controller,
		padding: padding,
		groupBy: groupBy!,
		footer: isLoading || showLoadMoreButton ? loadingView() : null,
		groupItemBuilder: (context, element, _, __) => itemBuilder(context, element),
		groupSeparatorBuilder: separatorBuilder
	);

	Widget _gridView(BuildContext context) => GridView.builder(
		padding: padding,
		physics: physics,
		itemCount: itemCount,
		controller: controller,
		shrinkWrap: shrinkWrap,
		itemBuilder: _itemBuilder,
		gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
			crossAxisCount: gridDelegate.screenCrossAxisCounts(context),
			mainAxisSpacing: gridDelegate.mainAxisSpacing,
			crossAxisSpacing: gridDelegate.crossAxisSpacing,
			childAspectRatio: gridDelegate.childAspectRatio,
		)
	);

	Widget loadingView() => AnimatedSwitcher( 
		duration: const Duration(milliseconds: 300),
		child: isLoading
			? SmartListViewLoader.loader(
				layout: layout, 
				loaderStyle: loaderStyle
			)
			: Card(
				child: InkWell(
					onTap: onLoadMoreClicked,
					child: const Center(
						child: Text('Load More...')
					)
				)
			)
	);
}