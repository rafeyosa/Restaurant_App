import 'package:flutter/material.dart';

class RestaurantMenuItem extends StatelessWidget {
  const RestaurantMenuItem({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: Image.network(
                  '',
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        alignment: Alignment.center,
                        child: const Icon(Icons.no_food,
                            color: Colors.white24, size: 100));
                  },
                ),
              ),
              Container(
                height: 30,
                width: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Rp. 100.000',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 120,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}