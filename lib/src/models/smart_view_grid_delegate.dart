part of '../models.dart';

class SmartViewGridDelegate {

	final int crossAxisCount;
	final double? itemMaxWidth;
	final double crossAxisSpacing;
	final double mainAxisSpacing;
	final double childAspectRatio;

	const SmartViewGridDelegate({
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