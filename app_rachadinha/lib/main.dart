import 'package:flutter/material.dart';
import 'package:app_rachadinha/model/ContaModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rachadinha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepPurple, brightness: Brightness.dark),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _valor = TextEditingController();
  final _numPessoas = TextEditingController();
  final _porcentoGarcom = TextEditingController();
  ContaModel _conta = ContaModel(0, 0, 0);
  var _infoTextTotal = "Preencha os dados";
  var _infoTextPercent = "";
  var _infoTextTotalWitholtPercent = "";
  var _infoTextIndividual = "";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rachadinha"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  void _resetFields() {
    _conta.setNumPessoas = 0;
    _conta.setPorcentoGarcon = 0;
    _conta.setValor = 0;
    _infoTextTotal = "Preencha os dados";
    _infoTextPercent = "";
    _infoTextTotalWitholtPercent = "";
    _infoTextIndividual = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _janelaInput("Valor total da conta", _valor),
                    _janelaInput("Quantidade de pagantes", _numPessoas),
                    _janelaInput("Porcentagem do garçon", _porcentoGarcom),
                  ],
                ),
              ),
              _buttonCalcular(),
              _textInfoTotal(),
              _textInfoTotalWithoutPercent(),
              _textInfoPercent(),
              _textInfoIndividual()
            ],
          ),
        ));
  }

  _janelaInput(String field, TextEditingController controller) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: _editText(field, controller)),
    );
  }

  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 22,
        color: Colors.blue,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 22,
          color: Colors.grey,
        ),
      ),
    );
  }

  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          "Calcular",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _calculate();
          }
        },
      ),
    );
  }

  void _calculate() {
    setState(() {
      _conta.setNumPessoas = int.parse(_numPessoas.text);
      _conta.setValor = double.parse(_valor.text);
      _conta.setPorcentoGarcon = double.parse(_porcentoGarcom.text);

      _atualizaConta();
    });
  }

  void _atualizaConta() {
    String individual;
    String gorgeta = "Você foi inteligente.";
    String total;

    if (_conta.getPorcentoGarcon == 0) {
      individual = (_conta.getValor / _conta.getNumPessoas).toStringAsFixed(2);
      total = _conta.getValor.toStringAsFixed(2);
    } else {
      individual =
          ((_conta.getValor + _conta.getPorcentoGarcon * _conta.getValor) /
                  _conta.getNumPessoas)
              .toStringAsFixed(2);
      total = (_conta.getValor + _conta.getPorcentoGarcon * _conta.getValor)
          .toStringAsFixed(2);
      gorgeta = (_conta.getPorcentoGarcon * _conta.getValor).toStringAsFixed(2);
    }
    _infoTextTotal = "O total: R\$" + total + ".";
    _infoTextIndividual = "Valor individual:R\$" + individual + ".";
    _infoTextPercent = "Gorgeta:R\$" + gorgeta + ".";
    _infoTextTotalWitholtPercent = "Total sem gorjeta: R\$${_conta.getValor}";
  }

  // // Widget text
  _textInfoTotal() {
    return Text(
      _infoTextTotal,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
    );
  }

  _textInfoTotalWithoutPercent() {
    return Text(
      _infoTextTotalWitholtPercent,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
    );
  }

  _textInfoPercent() {
    return Text(
      _infoTextPercent,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
    );
  }

  _textInfoIndividual() {
    return Text(
      _infoTextIndividual,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25.0),
    );
  }
}
