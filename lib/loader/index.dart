

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_list_view/layouts/layouts.dart';
import 'package:smart_list_view/smart_list_view.dart';

part './grid_tile.dart';
part './list_tile_skeleton.dart';

class SmartListViewLoader extends StatelessWidget {

	final SmartListLayout layout;

	const SmartListViewLoader({
		super.key, 
		this.layout= SmartListLayout.list
	});

	static loader({
		LoaderStyle loaderStyle = const LoaderStyle(),
		SmartListLayout layout = SmartListLayout.list
	}) => Shimmer.fromColors(
		baseColor: loaderStyle.baseColor,
		highlightColor: loaderStyle.highlightColor,
		direction: loaderStyle.direction,
		child: SmartListViewLoader(layout: layout)
	);

	@override
	Widget build(BuildContext context) {
		switch (layout) {
			case SmartListLayout.grid:
				return const GridViewTileSkeleton();
			default:
				return const ListTileSkeleton();
		}
	}
}