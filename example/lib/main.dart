import 'package:flutter/material.dart';
import 'package:smart_list_view/layouts/layouts.dart';
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
					Expanded(child: gridView()),
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
					futureItems: demoItems(),
					padding: const EdgeInsets.symmetric(horizontal: 16),
					shrinkWrap: true,
					itemBuilder: (context, item) => Text('Item ${item+1}'),
					separatorBuilder: (item) => const SizedBox(height: 16),
					infiniteScroll: true,
					onLoadMore: (lastItem, page) => demoItems(lastItem: lastItem)
				)
			)
		]
	);

	Widget gridView() => Column(
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
					padding: const EdgeInsets.symmetric(horizontal: 16),
					shrinkWrap: true,
					itemBuilder: (context, item) => Text('Grid ${item+1}'),
					infiniteScroll: true,
					gridDelegate: const GridDelegate(
						itemMaxWidth: 120
					),
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
