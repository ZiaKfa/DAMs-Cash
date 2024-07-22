import 'package:dams_cash/components/quantity_notifier.dart';
import 'package:dams_cash/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantitySelector extends StatefulWidget {
  final int quantity;
  final Product product;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.product,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> with AutomaticKeepAliveClientMixin {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    bool addIsDisabled = false;
    bool removeIsDisabled = false;
    return ChangeNotifierProvider(
      create: (context) => QuantityNotifier(
        initialQuantity: quantity,
        onAdd: widget.onAdd,
        onRemove: widget.onRemove,
      ),
    child: 
    Row(
      children: [
        IconButton(
          onPressed: () {
            if(addIsDisabled){
              return;
            } else {
              addIsDisabled = true;
              setState(() {
                quantity--;
              });
              widget.onRemove();
            }
            Future.delayed(const Duration(microseconds: 500), () {
              addIsDisabled = false;
            });
          },
          icon: const Icon(Icons.remove),
        ),
        Text(quantity.toString()),
        IconButton(
          onPressed: () {
            if(removeIsDisabled){
              return;
            } else {
              removeIsDisabled = true;
              setState(() {
                quantity++;
              });
              widget.onAdd();
            }
            Future.delayed(const Duration(microseconds: 500), () {
              removeIsDisabled = false;
            });
          },
          icon: const Icon(Icons.add),
        ),
      ],
    ),
    );

  }
  
  @override
  bool get wantKeepAlive => true;
}