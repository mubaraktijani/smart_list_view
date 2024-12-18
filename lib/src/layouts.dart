
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart' show GroupedListView;
import 'package:shimmer/shimmer.dart';
import 'package:smart_list_view/src/models.dart';

part './layouts/grid_view.dart';
part './layouts/grouped_view.dart';
part './layouts/list_view.dart';

enum SmartListLayout {

	list(),
	grid(),
	grouped();

	Widget view<T>({
		bool isLoading = false,
		required SmartViewDelegate<T> delegate,
		required SmartViewDecoration decoration,
		required SmartViewGridDelegate gridDelegate,
		required SmartViewListDelegate listDelegate,
		required SmartViewGroupedDelegate<T> groupedDelegate
	}) {
		bool showLoadMoreButton = !decoration.loadingDelegate.infiniteScroll;

		int itemCount = isLoading || showLoadMoreButton
			? delegate.items.length+1 
			: delegate.items.length;

		Widget loadMoreButton = decoration.loadingDelegate.getLoadMoreButton(
			isLoading: isLoading, 
			layout: this
		);

		itemBuilder(context, item) {
			if(delegate.items.length < index+1) return loadMoreButton;
			return delegate.itemBuilder(context, delegate.items[index]);
		}

		switch (this) {
			case SmartListLayout.grid:
				return _GridViewLayout(
					delegate: gridDelegate, 
					itemCount: itemCount, 
					decoration: decoration,
					controller: delegate.controller,
					itemBuilder: itemBuilder
				);
			case SmartListLayout.grouped:
				return _GroupedViewLayout<T>(
					loadMoreButton: isLoading || showLoadMoreButton 
						? loadMoreButton
						: null,
					items: delegate.items, 
					delegate: groupedDelegate, 
					decoration: decoration,
					controller: delegate.controller, 
					itemBuilder: delegate.itemBuilder,
				);
			default:
				return _ListViewLayout(
					delegate: listDelegate, 
					itemCount: itemCount,
					decoration: decoration,
					controller: delegate.controller,
					itemBuilder: itemBuilder
				);
		}
	}

	loader({
		required SmartViewDecoration decoration,
		required SmartViewGridDelegate gridDelegate,
		required SmartViewListDelegate listDelegate,
		required SmartViewGroupedDelegate<dynamic> groupedDelegate,
	}) => Shimmer.fromColors(
		baseColor: decoration.loadingDelegate.baseColor,
		highlightColor: decoration.loadingDelegate.highlightColor,
		direction: decoration.loadingDelegate.direction,
		child: view(
			delegate: SmartViewDelegate<dynamic>(
				items: List<int>.filled(20, 0), 
				controller: ScrollController(), 
				itemBuilder: (context, item) => decoration
					.loadingDelegate
					.getItemSkeleton(this)
			), 
			decoration: SmartViewDecoration(
				physics: const NeverScrollableScrollPhysics(),
				padding: decoration.padding,
				primary: decoration.primary,
				shrinkWrap: decoration.shrinkWrap
			), 
			gridDelegate: gridDelegate, 
			listDelegate: listDelegate, 
			groupedDelegate: groupedDelegate
		)
	);
}