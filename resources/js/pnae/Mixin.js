export default {
	data() {
		return {
            money: {
                decimal: ',',
                thousands: '.',
                precision: 2,
                masked: false
            },
            form_errors : {},
            status_requisicao: false,
            urlBase: window.location.protocol + "//" + window.location.host
		}
	},
	methods : {
		retornarMeses : function() {
			var meses = [];
            var qtdeMeses = 12;

            for (var i = 1; i <= qtdeMeses; i++) {
                meses.push({mes_id : i, nome : moment(i.toString()).format("MMMM")});
            }

			return meses;
		},
		formErros : function(erros) {
			var retorno = '';
			var cmpFormRequest = new Array();

			var arr = ((JSON.stringify(self.formRequest)).replace(/{|}/g,'')).replace(/"|"/g,"");
			var cmpEValores = arr.split(",");
			var arrAux = null;

			cmpEValores.forEach(function(value) {
				arrAux = value.split(":");
				cmpFormRequest.push(arrAux[0]);
			});

			cmpFormRequest.forEach(function(value) {
				if (erros[value]) {
					erros[value].forEach(function(erro) {
						retorno += erro+' <br>';
					});
				}
			});

			return retorno;
		},
		mountErrors : function(erros) {
			var retorno = '';
			var cmpFormRequest = new Array();
			var replace = ['dados_funcionais\.', 'locais_de_trabalho\.', 'locais_de_trabalho\.', 'endereco\.', 'dados_pessoais\.'];
			var strErrors = ((JSON.stringify(self.formRequest)).replace(/{|}/g,'')).replace(/"|"/g,"").replace(/[\[]/g, '').replace(/[\]]/g, '');

			var arrayErrors = strErrors.split(",");
			var strJson = '{';

			for (var i = 0; i < arrayErrors.length; i++) {
				var aux = arrayErrors[i].split(":");
				var atributo = aux[0];
				var valor = aux[1];

				if (atributo.indexOf(".") != -1) {
					var aux2 = atributo.split('.');
					atributo = aux2[1];
				}

				strJson += '\"' + atributo + '\":\"' + valor + '\"';

				if ((i+1) < arrayErrors.length) {
					strJson += ',';
				}
			}

			strJson += '}';

			return JSON.parse(strJson);
		},
		sleep: function(milliseconds) {
			var start = new Date().getTime();

			for (var i = 0; i < 1e7; i++) {
				if ((new Date().getTime() - start) > milliseconds) {
					break;
				}
			}
		},
		contatosErrors: function(contatos, formRequest) {
            if (formRequest['contatos.contatos']) {
                return 'contatos.contatos';
            } else {
                for(i = 0; i < contatos.length; i++ ) {
                    if(formRequest['contatos.contatos.'+i+'.contato'] || formRequest['contatos.contatos.'+i+'.tipo_contato']) {
                        return 'contatos.contatos.'+i;
                    }
                }
            }
		},
		countPaginate : function(lista) {
            var j = lista.from;
            var qtdeItens = lista.total;

            lista.data.forEach(function(data) {
				data.index = j++;
			});

            return lista;
        },
		isNow: function(data) {
			var hoje = new Date;

			data = moment(data).format('DD/MM');
			hoje = moment(hoje).format('DD/MM')

			return data == hoje;
		}
	},

	filters : {
		date : function(data) {
			if (data) {
				return moment(data).format('DD/MM/YYYY');
			}

			return '';
        },
		dataAniversario : function(data) {
			if (data) {
				var now = new Date;
				return data + '/' + now.getFullYear();
			}

			return '';
        },
		dateTime : function(data) {
			if (data) {
				return moment(data).format('DD/MM/YYYY - HH:mm');
			}

			return  '';
        },
        dateInFull: function(data) {
            var dia = moment(data).format('DD');
            var mes = moment(data).format('M');
            var meses = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];

            return dia + ' ' + meses[mes-1];
        },
		time : function(data) {
            return moment(data).format('HH:mm');
        },
        maskCpfCnpj : function(value) {
        	const cnpjCpf = value.replace(/\D/g, '');
  
			if (cnpjCpf.length === 11) {
				return cnpjCpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/g, "\$1.\$2.\$3-\$4");
			} 
			
			return cnpjCpf.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/g, "\$1.\$2.\$3/\$4-\$5");
        },
		formaMoeda : function(value) {
			var valor = parseFloat(value);

			return valor.toLocaleString('pt-BR', { minimumFractionDigits: 2});
		},
		formaNumero : function(value) {
			var numero = 0;

			if (value % 2 == 0) {
				numero = parseInt(value);
			} else {
				numero = parseFloat(value);
			}

			return numero;
		},
	}
}
