import 'package:flutter/material.dart';
import 'package:smart_list_view/src/layouts.dart';
import 'package:smart_list_view/src/models.dart';

class SmartListView<T> extends StatefulWidget {

	final List<T> items;
	final SmartListLayout layout;
	final Future<List<T>>? futureItems;
	final Widget Function(BuildContext, T) itemBuilder;
	final Future<List<T>> Function(T lastItem, int page)? onLoadMore;

	final SmartViewDecoration decoration;
	final SmartViewGridDelegate gridDelegate;
	final SmartViewListDelegate listDelegate;
	final SmartViewGroupedDelegate<T> groupedDelegate;
	
	const SmartListView({
		super.key, 
		this.items = const [],
		this.layout = SmartListLayout.list,
		this.onLoadMore,
		this.futureItems,
		this.decoration = const SmartViewDecoration(), 
		this.listDelegate = const SmartViewListDelegate(), 
		this.gridDelegate = const SmartViewGridDelegate(), 
		this.groupedDelegate = const SmartViewGroupedDelegate(), 
		required this.itemBuilder,
	});

	static Widget list<T>({
		List<T>? items,
		Future<List<T>>? futureItems,
		SmartViewListDelegate delegate = const SmartViewListDelegate(),
		SmartViewDecoration decoration = const SmartViewDecoration(),
		Future<List<T>> Function(T lastItem, int page)? onLoadMore,
		required Widget Function(BuildContext, dynamic) itemBuilder
	}) => SmartListView<T>(
		items: items ?? [],
		onLoadMore: onLoadMore,
		decoration: decoration,
		itemBuilder: itemBuilder,
		futureItems: futureItems,
		listDelegate: delegate,
	);

	static Widget grid<T>({
		List<T>? items,
		Future<List<T>>? futureItems,
		SmartViewGridDelegate delegate = const SmartViewGridDelegate(),
		SmartViewDecoration decoration = const SmartViewDecoration(),
		Future<List<T>> Function(T lastItem, int page)? onLoadMore,
		required Widget Function(BuildContext, dynamic) itemBuilder
	}) => SmartListView<T>(
		items: items ?? [],
		layout: SmartListLayout.grid,
		onLoadMore: onLoadMore,
		decoration: decoration,
		itemBuilder: itemBuilder,
		futureItems: futureItems,
		gridDelegate: delegate,
	);

	static Widget grouped<T>({
		List<T>? items,
		Future<List<T>>? futureItems,
		SmartViewGroupedDelegate<T> delegate = const SmartViewGroupedDelegate(),
		SmartViewDecoration decoration = const SmartViewDecoration(),
		Future<List<T>> Function(T lastItem, int page)? onLoadMore,
		required Widget Function(BuildContext, dynamic) itemBuilder
	}) => SmartListView<T>(
		items: items ?? [],
		onLoadMore: onLoadMore,
		itemBuilder: itemBuilder,
		futureItems: futureItems,
		groupedDelegate: delegate,
		decoration: decoration,
	);

	@override
	State<SmartListView> createState() => _SmartListViewState<T>();
}

class _SmartListViewState<T> extends State<SmartListView<T>> {

	int page = 0;
	bool isLoading = false;
	List<T> loadedItems = [];
	bool showLoadMoreButton = false;

	final ScrollController scrollController = ScrollController();

	@override
	void initState() {
		super.initState();
		isLoading = (widget.futureItems != null);
		Future.microtask(loadItems);
		if(widget.onLoadMore != null) {
			this.scrollController.addListener(loadMoreScrollListener);
		}
	}

	@override
	void dispose() {
		scrollController.dispose();
		super.dispose();
	}

	loadMoreScrollListener() async {
		if(widget.onLoadMore == null) return;
		if(isLoading) return;

		ScrollPosition position = scrollController.position;

		if (position.pixels < position.maxScrollExtent - 50) {
			setState(() => showLoadMoreButton = false);
			return;
		}

		if (!widget.decoration.loadingDelegate.infiniteScroll) {
			setState(() => showLoadMoreButton = true);
			return;
		}

		loadItems(isLoadMore: true);
	}

	Future<void> loadItems({bool isLoadMore = false}) async {
		try {
			List<T> items;
			if(!isLoadMore) {
				if(widget.futureItems == null) return;

				setState(() => isLoading = true);

				items = await widget.futureItems!;

				return setState(() {
					isLoading = false;
					loadedItems = items;
				});
			}

			if(
				widget.onLoadMore == null &&
				(widget.items.length < 10 || loadedItems.length < 10)
			) return;

			setState(() => isLoading = true);

			loadedItems = (loadedItems.isEmpty && page < 2)
				? widget.items
				: loadedItems;

			items = await widget.onLoadMore!(loadedItems.last, page+1);
			
			setState(() {
				page = page+1;
				isLoading = false;
				loadedItems.addAll(items);
			});
		} catch (e) {
			setState(() => isLoading = false);
		}
	}

	@override
	Widget build(BuildContext context) {
		if(widget.futureItems == null) return main(widget.items);

		if(loadedItems.isEmpty && isLoading) return _loader();

		if(loadedItems.isEmpty && !isLoading) return widget.decoration.emptyDelegate.getView(context);

		return main(loadedItems);
	}

	Widget main(List<T> items) {
		if(widget.futureItems == null) view(items);

		return RefreshIndicator(
			onRefresh: () => loadItems(),
			child: view(items)
		);
	}

	SmartViewDelegate<T> delegate({List<T>? items}) => SmartViewDelegate<T>(
		items: items ?? widget.items,
		controller: scrollController,
		onLoadMore: widget.onLoadMore,
		itemBuilder: widget.itemBuilder,
		futureItems: widget.futureItems,
	);

	Widget _loader() => widget.layout.loader(
		decoration: widget.decoration,
		gridDelegate: widget.gridDelegate,
		listDelegate: widget.listDelegate,
		groupedDelegate: widget.groupedDelegate
	);

	Widget view(List<T> items) => widget.layout.view(
		delegate: delegate(items: items),
		decoration: widget.decoration,
		gridDelegate: widget.gridDelegate,
		listDelegate: widget.listDelegate,
		groupedDelegate: widget.groupedDelegate
	);
}