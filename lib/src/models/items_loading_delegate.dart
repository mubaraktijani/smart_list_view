part of '../models.dart';

class ItemsLoadingDelegate {
	final bool infiniteScroll;

	final Color baseColor;
	final Color highlightColor;
	final ShimmerDirection direction;

	final Widget? listItemSkelton;
	final Widget? gridItemSkelton;
	final Widget? groupedItemSkelton;
	final Widget? groupedSeparatorSkelton;
	final Widget? gridLoadMoreCard;
	final Widget? listLoadMoreCard;
	final Widget Function(BuildContext context)? gridViewBuilder;
	final Widget Function(BuildContext context)? listViewBuilder;
	final Widget Function(BuildContext context)? groupedViewBuilder;

	const ItemsLoadingDelegate({
		this.gridLoadMoreCard, 
		this.listLoadMoreCard,
		this.infiniteScroll = true,
		this.baseColor = const Color(0xFFE0E0E0), 
		this.direction = ShimmerDirection.ltr,
		this.highlightColor = const Color(0xFF868686),
		this.gridViewBuilder,
		this.listViewBuilder,
		this.listItemSkelton,
		this.gridItemSkelton, 
		this.groupedItemSkelton,
		this.groupedViewBuilder,
		this.groupedSeparatorSkelton,
	});

	Widget getItemSkeleton(SmartListLayout layout) {
		switch (layout) {
			case SmartListLayout.grid:
				return gridItemSkelton ?? const GridViewTileSkeleton();
			case SmartListLayout.grouped:
				return groupedItemSkelton ?? const ListTileSkeleton();
			default:
				return listItemSkelton ?? const ListTileSkeleton();
		}
	}
	
	Widget getLoadMoreButton({
		bool isLoading = false,
		Function()? onLoadMoreClicked,
		required SmartListLayout layout
	}) {
		Widget loadMore;

		switch (layout) {
			case SmartListLayout.grid:
				loadMore = gridLoadMoreCard ?? const LoadMoreGridCard();
			default:
				loadMore = listLoadMoreCard ?? const LoadMoreListTile();
		}
		
		return AnimatedSwitcher( 
			duration: const Duration(milliseconds: 300),
			child: isLoading
				? getItemSkeleton(layout)
				: InkWell(
					onTap: onLoadMoreClicked,
					child: loadMore
				)
		);
	}
}