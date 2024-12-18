import 'package:flutter/material.dart';
import 'package:smart_list_view/smart_list_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
	const MainApp({super.key});

	@override
	Widget build(BuildContext context) => MaterialApp(
		home: Scaffold(
			body: Column(
				children: [
					Expanded(child: listView()),
					Expanded(child: gridView(context)),
					// Expanded(child: listView())
				]
			)
		)
	);

	Widget listView() => Column(
		children: [
			const Text(
				'List View',
				style: TextStyle(
					fontSize: 20,
					fontWeight: FontWeight.bold
				)
			),
			Expanded(
				child: SmartListView.list(
					onLoadMore: (lastItem, page) => demoItems(lastItem: lastItem),
					decoration: const SmartViewDecoration(
						padding: EdgeInsets.symmetric(horizontal: 16)
					),
					futureItems: demoItems(),
					itemBuilder: (context, item) => Text('Item ${item+1}')
				)
			)
		]
	);

	Widget gridView(BuildContext context) => Column(
		children: [
			const Text(
				'Grid View',
				style: TextStyle(
					fontSize: 20,
					fontWeight: FontWeight.bold
				)
			),
			Expanded(
				child: SmartListView.grid(
					futureItems: demoItems(),
					decoration: const SmartViewDecoration(
						padding: EdgeInsets.symmetric(horizontal: 16),
						loadingDelegate: ItemsLoadingDelegate(
							infiniteScroll: false,
							gridLoadMoreCard: Text('ddd')
						)
					),
					delegate: SmartViewGridDelegate(
						itemMaxWidth: MediaQuery.of(context).size.width * .3
					),
					itemBuilder: (context, item) => Text('Grid ${item+1}'),
					onLoadMore: (lastItem, page) => demoItems(lastItem: lastItem)
				)
			)
		]
	);

	Future<List<int>> demoItems({int lastItem = 0}) async {
		await Future.delayed(const Duration(seconds: 60));
		return List.generate(10, (index) => lastItem + (index+1))
			.toList();
	}
}
