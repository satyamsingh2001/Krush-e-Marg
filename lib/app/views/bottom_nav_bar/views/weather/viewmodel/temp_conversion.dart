String convertKelvinToCelsius(double? kelvin) {
  if (kelvin != null) {
    return (kelvin - 273.15).toStringAsFixed(2);
  }
  return 'N/A'; // Return a default value or handle the null case as needed
}
