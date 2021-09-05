<template>
    <div id="form-projeto">
        <loading v-show="loading"></loading>
        <div class="m-content">
			<div class="row">
				<div class="col-lg-12">
					<div class="m-portlet">
						<div class="m-portlet__head">
							<div class="m-portlet__head-caption">
								<div class="m-portlet__head-title">
									<span class="m-portlet__head-icon m--hide">
										<i class="la la-gear"></i>
									</span>
									<h3 class="m-portlet__head-text">
										Registrar Entrada de Mercadoria
									</h3>
								</div>
							</div>
						</div>
						<form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
							<div class="m-portlet__body">
								<div class="form-group m-form__group row">
                                    <div class="col-lg-6 col-xl-6 col-md-6 col-sm-12">
										<label>
											Fornecedor
										</label>
                                        <select v-model="fornecedor" @change="getProjetosProdutos()" id="fornecedor" class="form-control m-input m-input--square ">
                                            <option :value="''">-- Selecione o fornecedor --</option>
                                            <option v-for="fornecedor in fornecedores" :value="fornecedor">
                                                {{ fornecedor.nome }}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
											Selecione o fornecedor
										</span>
									</div>
                                    <div class="col-lg-6 col-xl-6 col-md-6 col-sm-12">
										<label>
											Edital
										</label>
                                        <select v-model="edital" @change="getProjetosProdutos()" id="fornecedor" class="form-control m-input m-input--square ">
                                            <option :value="''">-- Selecione o edital --</option>
                                            <option v-for="edital in editais" :value="edital">
                                                {{ edital.titulo }}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
											Selecione o edital
										</span>
									</div>
								</div>
							</div>

                            <hr>

                            <div class="m-form__section m-form__section" style="margin: 0px 0 0px 0;">
                                <div class="m-form__heading">
                                    <h3 class="m-form__heading-title">
                                        Produtos:
                                    </h3>
                                </div>
                                <div class="form-group m-form__group row" style="padding-top: 0px;">
                                    <div class="col-lg-4 col-md-4 col-sm-12">
                                        <label class="">
                                            Produto:
                                        </label>
                                        <select id="produto" v-model="entrada_mercadoria_aux.produto" @change="checkQtdEntradaMercadoria()" name="produto" class="form-control m-input">
                                            <option value="" selected="selected">Selecione o produto</option>
                                            <option v-for="produto in produtos" :value="produto">
                                                {{ produto.has_produto.produto }}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
                                            Por favor, selecione o produto
                                        </span>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-12">
                                        <label class="">
                                            Quantidade:
                                        </label>
                                        <div class="input-group m-input-group">
                                            <input @change="verificarQtdMax()" type="text" class="form-control m-input" v-model="entrada_mercadoria_aux.qtd_entregue" :placeholder="(entrada_mercadoria_aux.produto ? 'Qtd máxima: '+qtdEntradaMercadoriaMax : '')">
                                            <div class="input-group-prepend">
                                                <span class="input-group-text">
                                                    {{ entrada_mercadoria_aux.produto.has_produto != null ? entrada_mercadoria_aux.produto.has_produto.has_unidade_medida.sigla : "kg" }}
                                                </span>
                                            </div>
                                        </div>
                                        <span class="m-form__help">
                                            Digite a quantidade
                                        </span>
                                    </div>
                                    <div class="col-lg-3 col-md-3 col-sm-12">
                                        <label>
                                            Data da entrega:
                                        </label>
                                        <input v-model="entrada_mercadoria_aux.dta_entrega" type="date" placeholder="" class="form-control m-input">
                                        <span class="m-form__help">
                                            Digite a data da entrega do produto
                                        </span>
                                    </div>
                                    <div class="col-lg-2 col-md-2 col-sm-12 padding-top-25">
                                        <button @click="addProduto()" type="button" title="Adicionar contato" class="btn btn-success">
                                            <i class="fa fa-plus"></i> Adicionar
                                        </button>
                                    </div>

                                    <br><br><br><br><br>

                                    <div class="col-lg-12">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>
                                                            Produto
                                                        </th>
                                                        <th>
                                                            Quantidade
                                                        </th>
                                                        <th>
                                                            Data da entrega
                                                        </th>
                                                        <th class="text-center">
                                                            Opções
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-if="entrada.entrada_mercadoria.length < 1">
                                                        <td colspan="4">
                                                            <p class="text-center">
                                                                Adicione produtos!
                                                            </p>
                                                        </td>
                                                    </tr>
                                                    <tr v-for="(entrada, key) in entrada.entrada_mercadoria">
                                                        <td class="align-middle">
                                                            {{ entrada.produto.has_produto.produto }}
                                                        </td>
                                                        <td class="align-middle">
                                                            {{ entrada.qtd_entregue }} {{ entrada.produto.has_produto.has_unidade_medida.sigla }}
                                                        </td>
                                                        <td class="align-middle">
                                                            {{ entrada.dta_entrega | date }}
                                                        </td>
                                                        <td class="text-center">
                                                            <div role="group" aria-label="First group" class="btn-group">
                                                                <button type="button" @click="editProduto(entrada, key)" class="m-btn btn btn-sm btn-primary">
                                                                    <i class="fa fa-edit"></i>
                                                                </button>
                                                                <button type="button" @click="removeProduto(key)" class="m-btn btn btn-sm btn-danger">
                                                                    <i class="fa fa-trash"></i>
                                                                </button>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="m-portlet__foot m-portlet__foot--fit">
								<div class="m-form__actions m-form__actions">
                                    <template v-if="retornoDados">
                                        <a :href="urlBase+'/pnae/entradas/imprimir-recibo/'+retornoDados.entrada_id" target="_blank" class="btn btn-success">
                                            <i class="fa fa-print"></i> Imprimir recibo
                                        </a>
                                    </template>
									<button type="button" @click="salvar()" class="btn btn-primary">
										Salvar
									</button>
									<button type="reset" class="btn btn-secondary">
										Cancelar
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
    </div>
</template>

<script>
    export default {
    	props : ['dados'],
        name: 'form-projeto',
        data () {
            return {
                urlBase: urlBase,
                retornoDados : '',
                loading : false,
                titulo: 'Registrar entrada',
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
                fornecedores : [],
                produtos     : [],
                fornecedor   : '',
                edital       : '',
                cronogramas_entrega : [],
                editais             : [],
                entrada_mercadoria_aux : {
                    key                     : null,
                    entrada_mercadoria_id   : '',
                    projeto_produtos_id     : '',
                    produto                 : '',
                    qtd_entregue            : '',
                    dta_entrega             : moment().format("YYYY-MM-DD"),
                },
                entrada : {
                    entrada_id         : '',
                    projeto_id         : '',
                    entrada_mercadoria : []
                },
                qtdEntradaMercadoriaMax : '',
            }
        },
        methods : {
            editProduto(prod, key) {
                self = this;
                self.entrada_mercadoria_aux = prod;
                self.entrada_mercadoria_aux.key = key;
            },
            removeProduto(key) {
                self = this;
                self.entrada.entrada_mercadoria.splice(key, 1);
            },
            addProduto() {
                self = this;
                var comp = false;
                
                if (!self.checkProduto()) {
                    return true;
                }

                self.entrada_mercadoria_aux.projeto_produtos_id = self.entrada_mercadoria_aux.produto.projeto_produtos_id;
                if (self.entrada_mercadoria_aux.key == null) {
                    self.entrada.entrada_mercadoria.forEach(function(p){
                        if (self.entrada_mercadoria_aux.projeto_produtos_id == p.projeto_produtos_id) {
                            comp = true;
                            return Swal({
                                type: 'error',
                                title: 'Atenção',
                                html: 'Produto já adicionado!',
                            });
                        }
                    });

                    if (!comp) {
                        self.entrada.entrada_mercadoria.push(self.entrada_mercadoria_aux);

                        self.limpaEntradaMercadoriaAux();
                    }
                } else {
                    self.entrada.entrada_mercadoria[self.entrada_mercadoria_aux.key] = self.entrada_mercadoria_aux;

                    self.limpaEntradaMercadoriaAux();
                }
            },
            verificarQtdMax : function(){
                self = this;

                if (self.entrada_mercadoria_aux.qtd_entregue > self.qtdEntradaMercadoriaMax) {
                    self.entrada_mercadoria_aux.qtd_entregue = '';

                    Swal({
                        type: 'error',
                        title: 'Não é possível entregar uma quantidade maior do que consta no projeto!',
                    });
                    return false;
                }

                if (self.entrada_mercadoria_aux.qtd_entregue == 0) {
                    Swal({
                        type: 'error',
                        title: 'Digite a quantidade entregue!',
                    });

                    return false;
                }

                return true;
            },
            checkQtdEntradaMercadoria : function(){
                self = this;

                if(!self.entrada_mercadoria_aux.produto){
                    return false;
                }

                self.loading = true;
                var url = urlBase+'/pnae/entradas/check-qtd-entrada-mercadoria/'+self.entrada_mercadoria_aux.produto.projeto_produtos_id;

                self.$http.get(url).then((response) => {
                    self.qtdEntradaMercadoriaMax = self.entrada_mercadoria_aux.produto.quantidade - response.body;

                    if (self.qtdEntradaMercadoriaMax == 0) {
                        self.entrada_mercadoria_aux.produto = '';
                        self.loading = false;
                        return Swal({
                            type: 'error',
                            title: 'A quantidade máxima de entrega já atingiu o limite!',
                        });
                    }

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            salvar : function() {
                self = this;

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/entradas/salvar', self.entrada).then((response) => {
                            self.retorno = response.body;
                            self.retornoDados = response.body.dados;
                            self.formRequest = {};
                        }, response => {
                            var form = response.body;
                            self.formRequest = form.errors;
                            self.retorno = 0;
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    // console.log(result);
                    if (result.dismiss != "cancel") {
                        if (self.retorno == 0) {
                            self.form_errors = self.mountErrors(self.formRequest);
                            var msg = self.formErros(self.formRequest);
                            self.retorno = '';
                            return Swal({
                                type: 'error',
                                title: 'Há campos em brancos!',
                                html: msg,
                            });
                        }

                        Swal({
                            type: self.retorno.status,
                            title: self.retorno.msg,
                        });
                        self.retorno = '';
                        return true;
                    }
                }).catch(Swal.noop)
            },
            getFornecedores : function() {
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/fornecedores/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.fornecedores = response.body;
                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getProjetosProdutos : function() {
                self = this;
                self.loading = true;

                if (self.fornecedor.fornecedor_id && self.edital.edital_id) {
                    var fornecedor_id = self.fornecedor.fornecedor_id;
                    var edital_id = self.edital.edital_id;

                    var url = urlBase + '/pnae/projetos/recuperar-projeto-produtos/'+fornecedor_id+'/'+edital_id;

                    self.$http.get(url).then((response) => {
                        if (response.body) {
                            self.entrada.projeto_id = response.body.projeto_id;
                            self.produtos = response.body.has_projeto_produto;
                        } else {
                            self.entrada = {
                                projeto_id         : '',
                                entrada_mercadoria : []
                            };
                            return Swal({
                                type: 'error',
                                title: 'Não há produtos para esse fornecedor!',
                            });
                        }
                        self.loading = false;
                    }, response => {
                        return Swal({
                            type: 'error',
                            title: 'Ocorreu um erro. Tente atualizar a página!',
                        });
                    });
                }

                self.loading = false;
            },
            getEdital : function() {
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/editais/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.editais = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            checkEdit : function() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.unidade_medida.unidade_medida_id   = dados.unidade_medida_id;
                    this.unidade_medida.nome                = dados.nome;

                    this.titulo = 'Editar unidade de medida';

                    this.btn.action = "Salvar";
                    this.btn.icon   = "fa fa-check";
                } else {
                    this.btn.action = "Cadastrar";
                    this.btn.icon   = "fa fa-check";
                }
            },
            limpaEntradaMercadoriaAux : function(){
                this.entrada_mercadoria_aux = {
                    entrada_mercadoria_id   : '',
                    projeto_produtos_id     : '',
                    produto                 : '',
                    qtd_entregue            : '',
                    dta_entrega             : moment().format("YYYY-MM-DD"),
                };
            },
            checkProduto : function(){
                if (this.entrada_mercadoria_aux.produto == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Adicione o produto!',
                    });
                    return false;
                }
                if (this.entrada_mercadoria_aux.qtd_entregue == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Digite a quantidade entregue!',
                    });
                    return false;
                }
                if (this.entrada_mercadoria_aux.dta_entrega == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Selecione a data da entrega!',
                    });
                    return false;
                }
                return true;
            },
        },
        mounted () {
            this.getFornecedores();
            this.getEdital();
            this.checkEdit();
        },
    };
</script>

<style scoped>
</style>
