part of './index.dart';

class ListTileSkeleton extends StatelessWidget {
	const ListTileSkeleton({super.key});
	
	Decoration get _decoration => BoxDecoration(
		borderRadius: BorderRadius.circular(5),
		color: Colors.white,
	);

	@override
	Widget build(BuildContext context) => ListTile(
		dense: true,
		tileColor: Colors.transparent,
		leading: const CircleAvatar(backgroundColor: Colors.white),
		contentPadding: EdgeInsets.zero,
		title: Container(
			height: 10,
			decoration: _decoration
		),
		subtitle: Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				const SizedBox(height: 8),
				Container(
					width: 100,
					height: 6,
					decoration: _decoration
				),
				const SizedBox(height: 4),
				Container(
					width: 50,
					height: 6,
					decoration: _decoration
				)
			]
		),
		trailing: Container(
			width: 20,
			height: 20,
			decoration: _decoration
		)
	);
}
