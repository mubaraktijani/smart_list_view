library smart_list_view;

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart' show GroupedListOrder;
import 'package:smart_list_view/layouts/layouts.dart';

part './smart_list_view_state.dart';
part 'utils.dart';

class SmartListView<T> extends StatefulWidget {

	final List<T> items;
	final SmartListLayout layout;
	final Future<List<T>>? futureItems;
	final bool shrinkWrap;
	final bool infiniteScroll;
	final GroupedListOrder order;
	final EdgeInsetsGeometry? padding;
	final dynamic Function(T)? groupBy;
	final Widget Function(BuildContext, T) itemBuilder;
	final Widget Function(dynamic)? separatorBuilder;
	final Future<List<T>> Function(T lastItem, int page)? onLoadMore;


	final LoaderStyle loaderStyle;
	final GridDelegate gridDelegate;
	
	const SmartListView({
		super.key, 
		this.loaderStyle = const LoaderStyle(),
		this.gridDelegate = const GridDelegate(),
		this.items = const [], 
		this.layout = SmartListLayout.list, 
		this.order = GroupedListOrder.ASC, 
		this.padding, 
		this.groupBy, 
		this.onLoadMore,
		this.futureItems, 
		this.separatorBuilder, 
		this.shrinkWrap = false, 
		this.infiniteScroll = false, 
		required this.itemBuilder, 
	});

	static Widget list<T>({
		List<T> items = const [],
		Future<List<T>>? futureItems,
		bool shrinkWrap = false,
		bool infiniteScroll = false,
		LoaderStyle loaderStyle = const LoaderStyle(),
		GridDelegate gridDelegate = const GridDelegate(),
		EdgeInsetsGeometry? padding,
		Widget Function(dynamic)? separatorBuilder,
		Future<List<T>> Function(T lastItem, int page)? onLoadMore,
		required Widget Function(BuildContext, T) itemBuilder
	}) => SmartListView(
		items: items, 
		layout: SmartListLayout.list, 
		padding: padding, 
		onLoadMore: onLoadMore,
		shrinkWrap: shrinkWrap,
		itemBuilder: itemBuilder,
		loaderStyle: loaderStyle,
		futureItems: futureItems, 
		gridDelegate: gridDelegate,
		infiniteScroll: infiniteScroll,
		separatorBuilder: separatorBuilder, 
	);

	static Widget grid<T>({
		List<T> items = const [],
		Future<List<T>>? futureItems,
		bool shrinkWrap = false,
		bool infiniteScroll = false,
		LoaderStyle loaderStyle = const LoaderStyle(),
		GridDelegate gridDelegate = const GridDelegate(),
		EdgeInsetsGeometry? padding,
		Future<List<T>> Function(T lastItem, int page)? onLoadMore,
		required Widget Function(BuildContext, T) itemBuilder
	}) => SmartListView(
		items: items, 
		layout: SmartListLayout.grid, 
		padding: padding, 
		onLoadMore: onLoadMore,
		shrinkWrap: shrinkWrap,
		itemBuilder: itemBuilder,
		loaderStyle: loaderStyle,
		futureItems: futureItems, 
		gridDelegate: gridDelegate,
		infiniteScroll: infiniteScroll,
	);

	@override
	State<SmartListView> createState() => _SmartListViewState<T>();
}