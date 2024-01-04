class WriteRegister {
  final String id;
  final int registerAddress;
  final int newValue;

  WriteRegister({
    required this.id,
    required this.registerAddress,
    required this.newValue,
  });
}
