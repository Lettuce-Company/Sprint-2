var alertas = [];

function obterdados(placa) {
    fetch(`/medidas/tempo-real/${placa}`)
        .then(resposta => {

            if (resposta.ok) {
                resposta.json().then(resposta => {

                    console.log(`Dados recebidos: ${JSON.stringify(resposta)}`);

                    alertar(resposta, placa);
                });
            } else {

                console.error('Nenhum dado encontrado ou erro na API');
            }
        })
        .catch(function (error) {
            console.error(`Erro na obtenção dos dados do aquario p/ gráfico: ${error.message}`);
        });

}

function alertar_temperatura(resposta, placa) {
    var temp = resposta[0].temperatura
    var umid = resposta[0].umidade


    console.log(placa === resposta[0].placa)
    
    var grauDeAviso ='';

        var limites = {
            critico_mtQuente: 10,
            emergencia_Quente: 8,
            atencao_quente: 4,
            ideal_3: 0,
            ideal_0: 3,
            atencao_frio: -0.1,
            emergencia_frio: -0.4,
            critico_mtFrio: -0.5
        };
    
    
    if (temperatura >= limites) {
            classe_temperatura = 'cor-alerta critico_mtQuente';
            console.log("caiu no 1")
        }
        else if (temperatura < limites.critico_mtQuente && temperatura >= limites.emergencia_quente) {
            classe_temperatura = 'cor-alerta emergencia_quente';
            console.log("caiu no 2")
        }
        else if (temperatura < limites.emergencia_Quente && temperatura >= limites.atencao_quente) {
            classe_temperatura = 'cor-alerta atencao_quente';
            console.log("caiu no 3")
        }
        else if (temperatura <= limites.ideal_3 && temperatura >= limites.ideal_0) {
            classe_temperatura = 'cor-alerta ideal';
            console.log("caiu no 4")
        }
        else if (temperatura <= limites.atencao_frio && temperatura > limites.emergencia_frio) {
            classe_temperatura = 'cor-alerta atencao_frio';
            console.log("caiu no 5")
        }
        else if (temperatura <= limites.emergencia_frio && temperatura > limites.critico_mtFrio ) {
            classe_temperatura = 'cor-alerta emergencia_frio';
            console.log("caiu no 6")
        }
        else if (temperatura <= limites.critico_mtFrio) {
            classe_temperatura = 'cor-alerta critico_mtFrio';
            console.log("caiu no 7")
        }

        var card;


            temp_caminhao.innerHTML = temperatura + "°C";
        

        // alterando
        card.className = classe_temperatura;


    var card;

    if (placa == 1) {
        temp_aquario_1.innerHTML = temp + "°C";
        card = card_1
    } else if (placa == 2) {
        temp_aquario_2.innerHTML = temp + "°C";
        card = card_2
    } else if (placa == 3) {
        temp_aquario_3.innerHTML = temp + "°C";
        card = card_3
    } else if (placa == 4) {
        temp_aquario_4.innerHTML = temp + "°C";
        card = card_4
    }

    card.className = classe_temperatura;
}

function exibirAlerta(temp, placa, grauDeAviso, grauDeAvisoCor) {
    var indice = alertas.findIndex(item => item.placa == placa);

    if (indice >= 0) {
        alertas[indice] = { placa, temp, grauDeAviso, grauDeAvisoCor }
    } else {
        alertas.push({ placa, temp, grauDeAviso, grauDeAvisoCor });
    }

    exibirCards();
    
// Dentro da div com classe grauDeAvisoCor há um caractere "invisível", 
// que pode ser inserido clicando com o seu teclado em alt+255 ou pelo código adicionado acima.
}

function removerAlerta(placa) {
    alertas = alertas.filter(item => item.placa != placa);
    exibirCards();
}
 
function exibirCards() {
    alerta.innerHTML = '';

    for (var i = 0; i < alertas.length; i++) {
        var mensagem = alertas[i];
        alerta.innerHTML += transformarEmDiv(mensagem);
    }
}

function transformarEmDiv({placa, temp, grauDeAviso, grauDeAvisoCor }) {
    return `<div class="mensagem-alarme">
    <div class="informacao">
    <div class="${grauDeAvisoCor}">&#12644;</div> 
     <h3>Aquário ${idAquario} está em estado de ${grauDeAviso}!</h3>
    <small>Temperatura ${temp}.</small>   
    </div>
    <div class="alarme-sino"></div>
    </div>`;
}
