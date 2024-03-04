import "package:flutter/material.dart";

class CustomTextField extends StatelessWidget {
  final TextEditingController? editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? labelText;
  final bool isObsecure;
  final Color? colorLabel;
  const CustomTextField(
      {super.key,
      this.editingController,
      this.assetRef,
      this.iconData,
      required this.isObsecure,
      this.labelText,
      this.colorLabel});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: iconData != null
              ? Icon(
                  iconData,
                  color: Colors.pink,
                )
              : Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(assetRef.toString()),
                ),
          labelStyle: TextStyle(
              fontSize: 18,
              color: colorLabel == null ? colorLabel : Colors.black),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.grey))),
      obscureText: isObsecure,
    );
  }
}
