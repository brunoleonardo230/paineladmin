<template>
    <div id="form-edital">
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
                                        {{ titulo }}
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <form class="m-form m-form--fit">
                            <div class="m-portlet__body">
                                <div class="m-form__section m-form__section--first">
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-6">
                                            <label class="">
                                                Titulo:
                                            </label>
                                            <input type="text" class="form-control m-input" v-model="edital.titulo" placeholder="Digite o titulo">
                                            <span class="m-form__help">
                                                Por favor, digite o titulo
                                            </span>
                                        </div>
                                        <div class="col-lg-6">
                                            <label>
                                                Descrição:
                                            </label>
                                            <textarea class="form-control m-input" v-model="edital.descricao" placeholder="Digite a descrição"></textarea>
                                            <span class="m-form__help">
                                                Por favor, digite a descrição
                                            </span>
                                        </div>
                                        <div class="col-lg-6">
                                            <label class="">
                                                Data inicial:
                                            </label>
                                            <input type="date" class="form-control m-input" v-model="edital.data_inicial" placeholder="Digite o titulo">
                                            <span class="m-form__help">
                                                Por favor, selecione a data inicial do edital
                                            </span>
                                        </div>
                                        <div class="col-lg-6">
                                            <label class="">
                                                Data final:
                                            </label>
                                            <input type="date" class="form-control m-input" v-model="edital.data_final" placeholder="Digite o titulo">
                                            <span class="m-form__help">
                                                Por favor, selecione a data final do edital
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
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-4 col-md-4 col-sm-12">
                                            <label class="">
                                                Produto:
                                            </label>
                                            <select class="form-control m-input" v-model="produto_aux.produto" id="produto" name="produto">
                                                <option value="" selected>Selecione</option>
                                                <option v-for="produto in produtos" :value="produto">
                                                    {{produto.produto}}
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
                                                <input type="number" v-model="produto_aux.quantidade" class="form-control m-input">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                         {{((produto_aux.produto) ? produto_aux.produto.has_unidade_medida.sigla : "KG")}}
                                                     </span>
                                                 </div>
                                             </div>
                                            <span class="m-form__help">
                                                Por favor, digite a quantidade
                                            </span>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-12">
                                            <label class="">
                                                Valor unitário:
                                            </label>
                                            <div class="input-group m-input-group">
                                                <div class="input-group-prepend">
                                                    <span class="input-group-text">
                                                         R$
                                                     </span>
                                                 </div>
                                                 <money v-model="produto_aux.valor" v-bind="money" class="form-control m-input"></money>
                                             </div>
                                            <span class="m-form__help">
                                                Por favor, digite o valor unitário
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
                                                                Item
                                                            </th>
                                                            <th>
                                                                Produto
                                                            </th>
                                                            <th>
                                                                Quantidade
                                                            </th>
                                                            <th>
                                                                Valor unitário
                                                            </th>
                                                            <th>
                                                                Valor total
                                                            </th>
                                                            <th class="text-center">
                                                                Opções
                                                            </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr v-if="edital.edital_has_produto.length < 1">
                                                            <td colspan="6">
                                                                <p class="text-center">
                                                                    Adicione produtos!
                                                                </p>
                                                            </td>
                                                        </tr>
                                                        <tr v-else v-for="(produto, index) in edital.edital_has_produto">
                                                            <td class="align-middle">
                                                                {{ produto.produto.produto_id }}
                                                            </td>
                                                            <td class="align-middle">
                                                                {{ produto.produto.produto }}
                                                            </td>
                                                            <td class="align-middle">
                                                                {{ produto.quantidade }}{{ produto.produto.has_unidade_medida.sigla }}
                                                            </td>
                                                            <td class="align-middle">
                                                                R$ {{ produto.valor | formaMoeda}}
                                                            </td>
                                                            <td class="align-middle">
                                                                R$ {{ (produto.valor * produto.quantidade) | formaMoeda}}
                                                            </td>
                                                            <td class="text-center">
                                                                <div data-v-0421c35d="" role="group" aria-label="First group" class="btn-group">
                                                                    <button @click="editarProduto(index, produto)" type="button" class="m-btn btn btn-sm btn-primary">
                                                                        <i class="fa fa-edit"></i>
                                                                    </button>
                                                                    <button @click="excluirProduto(index)" type="button" class="m-btn btn btn-sm btn-danger">
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
                            </div>
                            <div class="m-portlet__foot m-portlet__foot--fit">
                                <div class="m-form__actions m-form__actions">
                                    <button type="button" @click="salvar()" class="btn btn-primary">
                                        Salvar
                                    </button>
                                    <a :href="urlBase+'pnae/editais/listar'" class="btn btn-secondary">
                                        Cancelar
                                    </a>
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
    import Endereco from '../endereco/Endereco.vue'
    import Contatos from '../contato/Contatos.vue'

    export default {
    	props : ['dados'],
        components: { Endereco, Contatos },
        name: 'form-edital',
        data () {
            return {
                loading : false,
                money: {
                    decimal: ',',
                    thousands: '.',
                    // prefix: 'R$ ',
                    // suffix: ' #',
                    precision: 2,
                    masked: false
                },
                urlBase: urlBase,
                titulo: 'Cadastro de Edital',
                formRequest : '',
                form_errors: {},
                produtos : [],
                produto_aux : {
                    key     : null,
                    edital_produtos_id : '',
                    produto : '',
                    produto_id : '',
                    quantidade : '',
                    valor      : '',
                },
                edital: {
                    edital_id : '',
                    titulo : '',
                    descricao : '',
                    data_inicial    : moment().format('YYYY-MM-DD'),
                    data_final      : moment().format('YYYY-12-31'),
                    edital_has_produto : [],
                },
            }
        },
        methods : {
            editarProduto : function(index, produto){
                self.produto_aux = produto;
                self.produto_aux.key = index;
            },
            excluirProduto : function(index){
                self = this;
                self.edital.edital_has_produto.splice(index, 1);
            },
            addProduto : function(){
                self = this;
                var comp = false;
                if (!self.checkProduto()) {
                    return true;
                }
                if (self.produto_aux.key == null) {
                    self.edital.edital_has_produto.forEach(function(p){
                        if (self.produto_aux.produto.produto_id == p.produto_id) {
                            comp = true;
                            return Swal({
                                type: 'error',
                                title: 'Atenção',
                                html: 'Produto já adicionado!',
                            });
                        }
                    });

                    if (!comp) {
                        self.produto_aux.produto_id = self.produto_aux.produto.produto_id;
                        self.edital.edital_has_produto.push(self.produto_aux);

                        self.limpaProdutoAux();
                    }
                }else {
                    self.produto_aux.produto_id = self.produto_aux.produto.produto_id;
                    self.edital.edital_has_produto[self.produto_aux.key] = self.produto_aux;

                    self.limpaProdutoAux();
                }
            },
            salvar : function() {
                self = this;

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        // console.log(self.edital)
                        return self.$http.post(urlBase + '/pnae/editais/salvar', self.edital).then((response) => {
                            self.retorno = response.body;
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

                            return Swal({
                                type: 'error',
                                title: 'Há campos em brancos!',
                                html: msg,
                            });
                        }

                        return Swal({
                            type: self.retorno.status,
                            title: self.retorno.msg,
                        });
                    }

                }).catch(Swal.noop)
            },
            getProdutos : function(){
                this.loading = true;
                var url = "/pnae/produtos/recuperar-todos";

                this.$http.get(urlBase + url).then((response) => {
                    this.produtos = response.body;
                    this.loading = false;
                }, response => {
                    this.loading = false;
                    return Swal({
                        type: this.response.status,
                        title: this.response.msg,
                    });
                });
            },
            checkProduto : function(){
                if (this.produto_aux.produto == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Adicione o produto!',
                    });
                    return false;
                }
                if (this.produto_aux.quantidade == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Digite a quantidade!',
                    });
                    return false;
                }
                if (this.produto_aux.valor == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Digite o valor unitário!',
                    });
                    return false;
                }
                return true;
            },
            limpaProdutoAux : function(){
                this.produto_aux = {
                    key     : null,
                    edital_produtos_id : '',
                    produto : '',
                    produto_id : '',
                    quantidade : '',
                    valor      : '',
                };
            }
        },
        mounted () {
            this.getProdutos();
        },
    };
</script>

<style scoped>
</style>
