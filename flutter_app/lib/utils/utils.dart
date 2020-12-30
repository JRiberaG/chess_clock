String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0'); // Adds a 0 if needed
  String strMinutes = twoDigits(duration.inMinutes);
  String strSeconds = twoDigits(duration.inSeconds.remainder(60));

  return '$strMinutes:$strSeconds';
}
