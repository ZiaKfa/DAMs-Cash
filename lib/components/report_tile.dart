import 'package:dams_cash/components/quantity_selector.dart';
import 'package:dams_cash/models/report.dart';
import 'package:dams_cash/models/branch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportTile extends StatefulWidget {
  final ReportItem reportItem;

  const ReportTile({
    super.key,
    required this.reportItem
  });

  @override
  State<ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<ReportTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Branch>(
      builder: (context,branch,child) => Column(
        children: [
          Row(
            children: [
              ClipRRect(
                child: Image.asset("lib/assets/images/${widget.reportItem.product.category}.jpg", width: 100, height: 100, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10,),
                Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(widget.reportItem.product.name, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 5,),
                  Text("Rp.${widget.reportItem.product.price}"),
                  ],
                ),
                ),
              const Spacer(),
            QuantitySelector(
              quantity: widget.reportItem.quantity,
              product: widget.reportItem.product, 
              onAdd: (){
                branch.addToReport(widget.reportItem.product);
                widget.reportItem.product.updateStock(widget.reportItem.product,widget.reportItem.product.stock);
              }, 
              onRemove: (){
                branch.removeFromReport(widget.reportItem);
                widget.reportItem.product.updateStock(widget.reportItem.product,widget.reportItem.product.stock);
              }
              )
            ],
          ),
          const Divider(
            color: Colors.black,
            height: 20,
            thickness: 1,
            indent: 2,
            endIndent: 2,
          ), 
        ],
      
      )
    );
  }
}