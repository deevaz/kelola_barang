abstract class Bentuk {
  void hitungLuas();
}

class Persegi extends Bentuk {
  final double sisi;

  Persegi(this.sisi);

  @override
  void hitungLuas() {
    print('Luas Persegi: ${sisi * sisi}');
  }
}

class Lingkaran extends Bentuk {
  final double jariJari;

  Lingkaran(this.jariJari);

  @override
  void hitungLuas() {
    print('luas Lingkaran: ${3.14 * jariJari * jariJari}');
  }
}

void contohAbstraksi() {
  Bentuk persegi = Persegi(4);
  Bentuk lingkaran = Lingkaran(3);

  persegi.hitungLuas();
  lingkaran.hitungLuas();
}
