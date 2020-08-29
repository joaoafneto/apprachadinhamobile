class ContaModel {
  int _numPessoas;
  double _valor;
  int _porcentoGarcon;

  ContaModel(this._numPessoas, this._porcentoGarcon, this._valor);

  int get getNumPessoas {
    return _numPessoas;
  }

  double get getValor {
    return _valor;
  }

  int get getPorcentoGarcon {
    return _porcentoGarcon;
  }

  set setNumPessoas(int numPessoas) {
    _numPessoas = numPessoas;
  }

  set setValor(double valor) {
    _valor = valor;
  }

  set setPorcentoGarcon(int porcentoGarcon) {
    _porcentoGarcon = porcentoGarcon;
  }
}
