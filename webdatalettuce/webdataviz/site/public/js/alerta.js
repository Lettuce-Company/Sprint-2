var alertasUmd = [];
var alertasTemp = [];

function exibirAlertaTemp(temp, placa, grauDeAviso, grauDeAvisoCor) {
    var indice = alertasTemp.findIndex(item => item.placa == placa);

    if (indice >= 0) {
        alertasTemp[indice] = { placa, temp, grauDeAviso, grauDeAvisoCor }
    } else {
        alertasTemp.push({ placa, temp, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards();
}

function exibirAlertaUmid(Umid, placa, grauDeAviso, grauDeAvisoCor) {
    var indice = alertasUmd.findIndex(item => item.placa == placa);

    if (indice >= 0) {
        alertasUmd[indice] = { placa, Umid, grauDeAviso, grauDeAvisoCor }
    } else {
        alertasUmd.push({ placa, Umid, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards();
}

function removerAlerta(placa) {
    alertas = alertas.filter(item => item.placa != placa);
    exibirCards();
}
 
function exibirCards() {
    exibirUmidade()
    exibirTemperatura()
}

function transformarEmDivTemperatura({placa, temp, grauDeAviso}) {
    return `<div class="mensagem-alarme">
    <div class="informacao">
     <h3>O caminhão ${placa} está em estado ${grauDeAviso}!</h3>
    <small>Temperatura ${temp}.</small> 
    </div>
    <img src='https://static.vecteezy.com/system/resources/previews/009/394/762/original/bell-icon-transparent-notification-free-png.png' />
    </div>`;
}

function transformarEmDivUmidade({placa, Umid, grauDeAviso}) {
    return `<div class="mensagem-alarme" id='umidade_aviso'>
    <div class="informacao">
     <h3>O caminhão ${placa} está em estado ${grauDeAviso}!</h3>
    <small>Umidade ${Umid}.</small> 
    </div>
    <img src='https://static.vecteezy.com/system/resources/previews/009/394/762/original/bell-icon-transparent-notification-free-png.png' />
    </div>`;
}

function exibirUmidade(){
    alerta_umid.innerHTML = '';
    for (var i = 0; i < alertasUmd.length; i++) {
        var mensagem = alertasUmd[i];
        alerta_umid.innerHTML += transformarEmDivUmidade(mensagem);
    }
}

function exibirTemperatura(){
    alerta_temp.innerHTML = '';
    for (var i = 0; i < alertasTemp.length; i++) {
        var mensagem = alertasTemp[i];
        alerta_temp.innerHTML += transformarEmDivTemperatura(mensagem);
    }
}
