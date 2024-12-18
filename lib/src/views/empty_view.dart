part of '../views.dart';

class EmptyView extends StatelessWidget {

	final Widget? icon;
	final String? message;
	final TextStyle? textStyle;

	const EmptyView({
		super.key,
		this.icon,
		this.message,
		this.textStyle
	});

	@override
	Widget build(BuildContext context) => Center(
		child: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				icon ?? const Icon(CupertinoIcons.chevron_up),
				const SizedBox(height: 16),
				Text(
					message ?? "It seems like you haven't made any \ntransactions yet.",
					textAlign: TextAlign.center,
					style: textStyle ?? const TextStyle(
						fontSize: 16,
						fontWeight: FontWeight.w400
					)
				)
			]
		)
	);
}