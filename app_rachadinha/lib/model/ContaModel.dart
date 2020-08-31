class ContaModel {
  int _numPessoas;
  double _valor;
  double _porcentoGarcon;

  ContaModel(this._numPessoas, this._porcentoGarcon, this._valor);

  int get getNumPessoas {
    return _numPessoas;
  }

  double get getValor {
    return _valor;
  }

  double get getPorcentoGarcon {
    return _porcentoGarcon;
  }

  set setNumPessoas(int numPessoas) {
    _numPessoas = numPessoas;
  }

  set setValor(double valor) {
    _valor = valor;
  }

  set setPorcentoGarcon(double porcentoGarcon) {
    _porcentoGarcon = porcentoGarcon / 100;
  }
}
