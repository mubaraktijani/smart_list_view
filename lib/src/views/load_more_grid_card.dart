part of '../views.dart';

class LoadMoreGridCard extends StatelessWidget {

	const LoadMoreGridCard({super.key});
	
	Decoration get _decoration => BoxDecoration(
		borderRadius: BorderRadius.circular(5),
		color: Colors.white,
	);

	@override
	Widget build(BuildContext context) => Card(
		color: Colors.transparent,
		child: GridTile(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					Expanded(
						child: Container(
							decoration: const BoxDecoration(
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(8),
									topRight: Radius.circular(8),
								),
								color: Colors.white
							)
						)
					),
					const SizedBox(height: 10),
					Container(
						margin: const EdgeInsets.symmetric(horizontal: 30),
						height: 8,
						decoration: _decoration
					),
					const SizedBox(height: 8),
					Container(
						margin: const EdgeInsets.symmetric(horizontal: 20),
						height: 8,
						decoration: _decoration
					),
					const SizedBox(height: 10),
				]
			)
		)
	);
}