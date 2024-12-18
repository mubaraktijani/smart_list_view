part of '../models.dart';

class SmartViewListDelegate {

	final Widget Function(BuildContext, int)? separatorBuilder;

	const SmartViewListDelegate({
		this.separatorBuilder
	});
}