part of '../models.dart';

class SmartViewDelegate<T> {
	final List<T> items;
	final Future<List<T>> Function()? futureItems;
	final ScrollController controller;
	Widget Function(BuildContext, T) itemBuilder;
	final Future<List<T>> Function(T lastItem, int page)? onLoadMore;

	SmartViewDelegate({
		this.onLoadMore,
		this.futureItems, 
		required this.items, 
		required this.controller, 
		required this.itemBuilder
	});
}