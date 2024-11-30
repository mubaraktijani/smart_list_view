part of './smart_list_view.dart';

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

		if (!widget.infiniteScroll) {
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

		if(loadedItems.isEmpty && !isLoading) return emptyView();

		return main(loadedItems);
	}

	Widget main(List<T> items) {
		if(widget.futureItems == null) view(items);

		return RefreshIndicator(
			onRefresh: () => loadItems(),
			child: view(items)
		);
	}

	Widget _loader() => SmartListViewLayout.loader(
		layout: widget.layout,
		padding: widget.padding,
		loaderStyle: widget.loaderStyle,
		gridDelegate: widget.gridDelegate
	);

	Widget view(List<T> items) => SmartListViewLayout(
		items: items, 
		layout: widget.layout,
		padding: widget.padding,
		groupBy: widget.groupBy,
		isLoading: isLoading,
		shrinkWrap: widget.shrinkWrap,
		controller: scrollController,
		loaderStyle: widget.loaderStyle,
		itemBuilder: widget.itemBuilder,
		gridDelegate: widget.gridDelegate,
		separatorBuilder: widget.separatorBuilder,
		onLoadMoreClicked: () => loadItems(isLoadMore: true),
		showLoadMoreButton: showLoadMoreButton,
	);

	Widget emptyView() => const Center(
		child: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				// SvgPicture.asset(
				// 	'assets/icons/transaction-empty.svg',
				// 	width: Sizes.size48
				// ),
				// Gap(Sizes.size12),
				Text(
					"It seems like you haven't made any \ntransactions yet.",
					textAlign: TextAlign.center,
					// style: AppTextTheme.displayMedium!.copyWith(
					// 	fontSize: Sizes.text16,
					// 	fontWeight: FontWeight.w400
					// )
				)
			]
		)
	);
}