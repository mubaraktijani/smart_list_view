part of '../views.dart';

class LoadingErrorView extends StatelessWidget {

	final Widget? icon;
	final String? message;
	final TextStyle? textStyle;
	final Function()? onReload;

	const LoadingErrorView({
		super.key,
		this.icon,
		this.message,
		this.textStyle,
		this.onReload,
	});

	double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

	TextStyle getTextStyle(BuildContext context) => (textStyle ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle());

	@override
	Widget build(BuildContext context) => Center(
		child: Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				icon ?? const Icon(CupertinoIcons.chevron_up),
				SizedBox(height: getHeight(context) * .025),
				Text(
					"Oops! Something went wrong...",
					textAlign: TextAlign.center,
					textScaler: const TextScaler.linear(1.3),
					style: getTextStyle(context).copyWith (
						fontSize: getTextStyle(context).fontSize ?? 16,
						fontWeight: FontWeight.w500
					)
				),
				SizedBox(height: getHeight(context) * .01),
				Container(
					width: MediaQuery.of(context).size.width * .7,
					constraints: BoxConstraints(
						maxWidth: 400,
						minWidth: 200,
					),
					child: Text(
						message ?? "There was an error loading the page resource you requested. Please try again later or contact us for assistance",
						textAlign: TextAlign.center,
						style: getTextStyle(context).copyWith(
							fontSize: getTextStyle(context).fontSize ?? 16,
							fontWeight: FontWeight.w400
						)
					)
				),
				SizedBox(height: getHeight(context) * .03),
				ElevatedButton(
					onPressed: onReload ?? () {},
					child: const Text('Reload')
				)
			]
		)
	);
}