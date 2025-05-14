class Tes {
  void sequence() {
    print('1');
    print('2');
    print('3');
  }

  void selection(int nilai) {
    if (nilai > 50 && nilai < 100) {
      print('nilai lebih besar dari 50');
    } else {
      print('nilai kurang dari 50');
    }
  }

  void iteration() {
    for (int i = 0; i < 5; i++) {
      print(i);
    }
  }

  void operatorOr() {
    String cuaca = 'hujan';
    if (cuaca == 'hujan' || cuaca == 'panas') {
      print('bawa payung');
    } else {
      print('tidak usah bawa payung');
    }
  }

  void operatorNot(bool hujan) {
    if (!hujan) {
      print('tidak hujan, tidak perlu payung');
    } else {
      print('Hujan, bawa payung');
    }
  }

  void panggilFungsi() {
    sequence();
    selection(75);
    iteration();
    operatorOr();
    operatorNot(false);
  }
}
