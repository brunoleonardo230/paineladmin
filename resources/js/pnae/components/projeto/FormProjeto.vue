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
										Cadastro de Projeto
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
                                        <select v-model="projeto.fornecedor_id" id="fornecedor" class="form-control m-input m-input--square ">
                                            <option :value="''">-- Selecione o fornecedor --</option>
                                            <option v-for="fornecedor in fornecedores" :value="fornecedor.fornecedor_id">
                                                {{fornecedor.nome}}
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
                                        <select v-model="editalAux" @change="selectEditalProdutos()" id="editalAux" class="form-control m-input m-input--square ">
                                            <option :value="''">-- Selecione o edital --</option>
                                            <option v-for="edital in editais" :value="edital">
                                                {{edital.titulo}}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
											Selecione o edital
										</span>
									</div>
								</div>
							</div>

                            <div class="form-group m-form__group row" style="padding-top: 0px;">
                                <div class="col-lg-6 col-xl-6 col-md-6 col-sm-12">
                                    <label>
                                        Data inicial do projeto
                                    </label>
                                    <input type="date" class="form-control m-input" v-model="projeto.data_projeto">
                                    <span class="m-form__help">
                                        Selecione a data inicial do projeto
                                    </span>
                                </div>
                                <div class="col-lg-6 col-xl-6 col-md-6 col-sm-12">
                                    <label>
                                        Data final do projeto
                                    </label>
                                    <input type="date" class="form-control m-input" v-model="projeto.data_final_projeto">
                                    <span class="m-form__help">
                                        Selecione a data final do projeto
                                    </span>
                                </div>
                            </div>

                            <div class="form-group m-form__group row">
                                 <div class="col-lg-1 text-center">
                                     <button data-toggle="modal" data-target="#novo-produto" type="button" title="Adicionar contato" class="btn btn-success">
                                         <i class="fa fa-plus"></i> Adicionar produto
                                     </button>
                                 </div>

                                 <!-- Modal Novo Produto -->
                                 <div class="modal fade" id="novo-produto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                     <div class="modal-dialog modal-lg" role="document">
                                         <div class="modal-content">
                                             <div class="modal-header">
                                                 <h5 class="modal-title" id="exampleModalLabel">Adicionar produto</h5>
                                                 <button type="button" @click="limpaNovoProduto()" class="close" data-dismiss="modal" aria-label="Close">
                                                     <span aria-hidden="true">&times;</span>
                                                 </button>
                                             </div>
                                             <div class="modal-body">
                                                 <div class="form-group row">
                                                     <div class="col-lg-6">
                                                         <label>
                                                             Produto:
                                                         </label>
                                                         <select @change="changeProduto()" id="produto" v-model="novo_produto.has_produto" name="produto" class="form-control m-input">
                                                             <option value="" selected="selected">Selecione o produto</option>
                                                             <option v-for="produto in produtos" :value="produto">
                                                                 {{produto.has_produto.produto}}
                                                             </option>
                                                         </select>
                                                         <span class="m-form__help">
                                                             Selecione o produto
                                                         </span>
                                                     </div>
                                                     <div class="col-lg-6">
                                                         <label>
                                                             Qtd:
                                                         </label>
                                                         <div class="input-group m-input-group">
                                                             <input type="number" class="form-control m-input" v-model="novo_produto.quantidade" :max="quantidadeMax">
                                                             <div class="input-group-prepend">
                                                                 <span class="input-group-text">
                                                                     {{novo_produto.has_produto ? novo_produto.has_produto.has_produto.has_unidade_medida.sigla : "kg"}}
                                                                 </span>
                                                             </div>
                                                         </div>
                                                         <span class="m-form__help">
                                                             Digite a quantidade
                                                         </span>
                                                     </div>
                                                 </div>
                                                 <div class="form-group row">
                                                     <div class="col-lg-6">
                                                         <label>
                                                             Valor Unitário:
                                                         </label>
                                                         <div class="input-group m-input-group">
                                                             <div class="input-group-prepend">
                                                                 <span class="input-group-text">
                                                                     R$
                                                                 </span>
                                                             </div>
                                                             <money v-model="novo_produto.valor_unitario" v-bind="money" class="form-control m-input"></money>
                                                             <!-- <input type="text" class="form-control m-input" v-model="novo_produto.valor_unitario"> -->
                                                         </div>
                                                         <span class="m-form__help">
                                                             Digite o valor unitário
                                                         </span>
                                                     </div>
                                                     <div class="col-lg-6">
                                                         <label>
                                                             Valor Total:
                                                         </label>
                                                         <div class="input-group m-input-group">
                                                             <div class="input-group-prepend">
                                                                 <span class="input-group-text">
                                                                     R$
                                                                 </span>
                                                             </div>
                                                             <input :value="(novo_produto.quantidade*novo_produto.valor_unitario) | formaMoeda" disabled class="form-control m-input"/>
                                                         </div>
                                                     </div>
                                                 </div>
                                                 <div class="form-group row">
                                                     <div class="col-lg-6">
                                                         <label>
                                                             Frequência de entrega:
                                                         </label>
                                                         <select v-model="novo_produto.has_cronograma_entrega" id="cronograma" name="cronograma" class="form-control m-input">
                                                             <option value="" selected="selected">Selecione o cronograma</option>
                                                             <option v-for="cronograma in cronogramas_entrega" :value="cronograma">
                                                                 {{cronograma.frequencia}}
                                                             </option>
                                                         </select>
                                                         <span class="m-form__help">
                                                             Selecione o cronograma de entrega
                                                         </span>
                                                     </div>
                                                     <div class="col-lg-3">
                                                         <label>
                                                             Data inicial da entrega:
                                                         </label>
                                                         <input v-model="novo_produto.data_inicial_entrega" type="date" placeholder="" class="form-control m-input">
                                                     </div>
                                                     <div class="col-lg-3">
                                                         <label>
                                                             Data final da entrega:
                                                         </label>
                                                         <input v-model="novo_produto.data_final_entrega" type="date" placeholder="" class="form-control m-input">
                                                     </div>
                                                 </div>
                                             </div>
                                             <div class="modal-footer">
                                                 <button type="button" @click="limpaNovoProduto()" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
                                                 <button @click="setProduto()" type="button" class="btn btn-primary">
                                                     Adicionar
                                                 </button>
                                             </div>
                                         </div>
                                     </div>
                                 </div>

                                <br>
                                <br>
                                <br>

                                <div class="col-lg-12">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>
                                                    Produto
                                                </th>
                                                <th>
                                                    Cronograma
                                                </th>
                                                <th>
                                                    Data inicial
                                                </th>
                                                <th>
                                                    Data final
                                                </th>
                                                <th>
                                                    Qtd.
                                                </th>
                                                <th>
                                                    Valor unitário.
                                                </th>
                                                <th>
                                                    Valor total.
                                                </th>
                                                <th class="text-center">
                                                    Opções
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-if="projeto.has_projeto_produto.length == 0">
                                                <td colspan="8">
                                                    <p class="text-center">
                                                        Adicione produto!
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr v-for="(prod, key) in projeto.has_projeto_produto">
                                                <td>
                                                    {{prod.has_produto.has_produto.produto}}
                                                </td>
                                                <td>
                                                    {{prod.has_cronograma_entrega.frequencia}}
                                                </td>
                                                <td>
                                                    {{prod.data_inicial_entrega | date}}
                                                </td>
                                                <td>
                                                    {{prod.data_final_entrega | date}}
                                                </td>
                                                <td>
                                                    {{prod.quantidade}} {{prod.has_produto.has_produto.has_unidade_medida.sigla}}
                                                </td>
                                                <td>
                                                    R$ {{prod.valor_unitario | formaMoeda}}
                                                </td>
                                                <td>
                                                    R$ {{(prod.quantidade * prod.valor_unitario) | formaMoeda}}
                                                </td>
                                                <td class="text-center">
                                                    <div class="btn-group" role="group" aria-label="First group">
                                                        <button type="button" @click="editProduto(prod,key)" data-toggle="modal" data-target="#novo-produto" class="m-btn btn btn-sm btn-primary">
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

                            <div class="m-portlet__foot m-portlet__foot--fit">
								<div class="m-form__actions m-form__actions">
                                    <template v-if="retornoDados">
                                        <a :href="urlBase+'/pnae/projetos/imprimir/'+retornoDados.projeto_id" target="_blank" class="btn btn-success">
    										<i class="fa fa-print"></i> Imprimir projeto
    									</a>
                                        <a class="btn btn-danger" :href="urlBase+'/pnae/projetos/contrato/imprimir/'+projeto.projeto_id" target="_blank">
                                            <i class="fa fa-print"></i> Imprimir Contrato
                                        </a>
                                    </template>
									<button type="button" @click="salvar()" class="btn btn-primary">
										{{ btn.action }}
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
                loading : false,
                urlBase: urlBase,
                titulo: 'Cadastrar projeto',
                retornoDados : '',
                money: {
                    decimal: ',',
                    thousands: '.',
                    // prefix: 'R$ ',
                    // suffix: ' #',
                    precision: 2,
                    masked: false
                },
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
                fornecedores : [],
                produtos     : [],
                cronogramas_entrega : [],
                editais             : [],
                editalAux : '',
                projeto : {
                    projeto_id          : '',
                    fornecedor_id       : '',
                    edital_id           : '',
                    valor_total_projeto : 0,
                    data_projeto        : moment().format('YYYY-MM-DD'),
                    data_final_projeto  : moment().format('YYYY-12-31'),
                    has_projeto_produto : [],
                },
                quantidadeMax : 0,
                novo_produto : {
                    key                     : null,
                    projeto_produtos_id     : '',
                    projeto_id              : '',
                    produto_id              : '',
                    has_produto             : '',
                    quantidade              : '',
                    valor_unitario          : '',
                    valor_total             : '',
                    data_inicial_entrega    : moment().format('YYYY-MM-DD'),
                    data_final_entrega      : moment().format('YYYY-12-31'),
                    cronograma_entrega_id   : '',
                    has_cronograma_entrega  : ''
                }
            }
        },
        methods : {
            editProduto : function(prod, key){
                self = this;
                self.novo_produto = prod;
                self.novo_produto.key = key;
                console.log(self.novo_produto);
            },
            removeProduto : function(key){
                self = this;
                self.projeto.has_projeto_produto.splice(key, 1);
            },
            setProduto : function(){
                self = this;
                var retorno = false;
                var comp = false;
                if (!self.checkProduto() || self.checkValorTotalProjeto((self.novo_produto.quantidade * self.novo_produto.valor_unitario))) {
                    return true;
                }

                if (self.novo_produto.key == null) {
                    self.projeto.has_projeto_produto.forEach(function(p){
                        if (self.novo_produto.has_produto.produto_id == p.produto_id) {
                            comp = true;
                            return Swal({
                                type: 'error',
                                title: 'Atenção',
                                html: 'Produto já adicionado!',
                            });
                        }
                    });

                    if (!comp) {
                        self.projeto.has_projeto_produto.push({
                            projeto_produtos_id     : '',
                            projeto_id              : '',
                            produto_id              : self.novo_produto.has_produto.produto_id,
                            has_produto             : self.novo_produto.has_produto,
                            quantidade              : self.novo_produto.quantidade,
                            valor_unitario          : self.novo_produto.valor_unitario,
                            valor_total             : self.novo_produto.valor_total,
                            data_inicial_entrega    : self.novo_produto.data_inicial_entrega,
                            data_final_entrega      : self.novo_produto.data_final_entrega,
                            cronograma_entrega_id   : self.novo_produto.has_cronograma_entrega.cronograma_entrega_id,
                            has_cronograma_entrega  : self.novo_produto.has_cronograma_entrega
                        });
                    }
                }else {
                    self.projeto.has_projeto_produto[self.novo_produto.key] = self.novo_produto;
                }
                $('#novo-produto').modal('hide'); // Fecha modal
                self.limpaNovoProduto();
            },
            limpaNovoProduto : function(){
                this.novo_produto = {
                    projeto_id              : '',
                    produto_id              : '',
                    has_produto             : '',
                    quantidade              : '',
                    valor_unitario          : '',
                    valor_total             : '',
                    data_inicial_entrega    : moment().format('YYYY-MM-DD'),
                    data_final_entrega      : moment().format('YYYY-12-31'),
                    cronograma_id           : '',
                    has_cronograma_entrega  : ''
                }
            },
            salvar : function() {
                self = this;

                self.projeto.has_projeto_produto.forEach(function(produto){
                    var valor = 0;
                    valor = produto.valor_unitario * produto.quantidade;
                    self.projeto.valor_total_projeto += valor;
                });

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/projetos/salvar', self.projeto).then((response) => {
                            self.retorno = response.body;
                            self.retornoDados = response.body.dados;
                            console.log(response.body);
                            self.formRequest = {};
                        }, response => {
                            var form = response.body;
                            self.formRequest = form.errors;
                            self.retorno = 0;
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    self.loading = false;
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
            getProdutos : function() {
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/produtos/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.produtos = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getCronogramaEntrega : function() {
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/cronogramas-de-entrega/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.cronogramas_entrega = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            changeProduto : function(){
                this.novo_produto.valor_unitario = this.novo_produto.has_produto.valor;
                this.checkQtdProdutoFornecido();
            },
            selectEditalProdutos : function(){
                self = this;
                self.loading = true;

                var url = urlBase + '/pnae/projetos/recuperar-projeto-produtos/'+self.projeto.fornecedor_id+'/'+self.editalAux.edital_id;

                self.$http.get(url).then((response) => {
                    if (response.body) {
                        self.projeto.edital_id = '';
                        self.editalAux = '';

                        Swal({
                            type: 'error',
                            title: 'O fornecedor já é participante nesse edital!',
                        });
                    }else {
                        self.projeto.edital_id = self.editalAux.edital_id;
                        self.produtos = self.editalAux.edital_has_produto;
                    }

                    self.loading = false;
                }, response => {
                    Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                    self.loading = false;
                });
            },
            checkQtdProdutoFornecido : function(){
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/editais/check-qtd-produto-fornecido/'+self.projeto.edital_id+'/'+self.novo_produto.has_produto.produto_id;

                self.$http.get(url).then((response) => {
                    self.quantidadeMax = response.body;
                    self.novo_produto.quantidade = response.body;
                    self.novo_produto.valor_total = (self.novo_produto.quantidade + self.novo_produto.valor_unitario);

                    if (response.body == 0) {
                        self.novo_produto = {
                            key                     : null,
                            projeto_produtos_id     : '',
                            projeto_id              : '',
                            produto_id              : '',
                            has_produto             : '',
                            quantidade              : '',
                            valor_unitario          : '',
                            valor_total             : '',
                            data_inicial_entrega    : moment().format('YYYY-MM-DD'),
                            data_final_entrega      : moment().format('YYYY-12-31'),
                            cronograma_entrega_id   : '',
                            has_cronograma_entrega  : ''
                        };
                        self.loading = false;

                        return Swal({
                            type: 'error',
                            title: 'O produto inserido já teve seu volume contratual máximo esgotado. Favor cadastrar, se possível, outro produto.',
                        });
                    }
                    self.loading = false;
                }, response => {
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
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
            checkValorTotalProjeto : function(ultimo){
                self = this;
                let valorTotalProjeto = ultimo;

                // if (ultimo > 20000) {
                //     valorTotalProjeto = ultimo;
                // }else {
                    self.projeto.has_projeto_produto.forEach(function(p){
                        let valorTotal = 0;
                        valorTotal = p.quantidade * p.valor_unitario;

                        valorTotalProjeto = valorTotalProjeto + valorTotal;
                    });
                // }
                console.log(valorTotalProjeto);
                if (valorTotalProjeto > 20000) {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'O projeto excedeu o valor máximo de R$ 20mil reais!',
                    });
                    return true;
                }
                return false;
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
            checkProduto : function(){
                if (this.novo_produto.has_produto == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Adicione o produto!',
                    });
                    return false;
                }
                if (this.novo_produto.quantidade == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Digite a quantidade!',
                    });
                    return false;
                }
                if (this.novo_produto.valor_unitario == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Digite o valor unitário!',
                    });
                    return false;
                }
                if (this.novo_produto.has_cronograma_entrega == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Selecione a frequência de entrega!',
                    });
                    return false;
                }
                if (this.novo_produto.data_inicial_entrega == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Selecione a data inicial da entrega!',
                    });
                    return false;
                }
                if (this.novo_produto.data_final_entrega == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Selecione a data final da entrega!',
                    });
                    return false;
                }
                if (parseFloat(this.novo_produto.quantidade) > parseFloat(this.quantidadeMax)) {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'A quantidade inserida é maior que a permitida, por favor, diminua a quantidade desse produto!',
                    });
                    return false;
                }
                return true;
            },
        },
        mounted () {
            this.getFornecedores();
            this.getCronogramaEntrega();
            this.getEdital();
            this.checkEdit();
        },
    };
</script>

<style scoped>
</style>
