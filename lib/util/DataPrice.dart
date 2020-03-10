class DataPrice{
  final double amount;
  final double dataVolume;

  DataPrice({this.amount, this.dataVolume});

  static List<DataPrice> getPlan(amount, dataVolume) {
    List<DataPrice> period = [];
    for(var i = 1; i<10; i++){
      var cost = ((i / 10) * amount) ;
      var gb = (i / 10) * dataVolume;

      var data = DataPrice(amount: cost, dataVolume: gb);
      period.add(data);

    }
    return period;
  }

}