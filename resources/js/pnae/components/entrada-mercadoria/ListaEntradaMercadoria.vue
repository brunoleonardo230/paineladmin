<template>
    <div id="lista-entrada-mercadoria">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Listar Entradas de Mercadorias
                            </h3>
                        </div>
                    </div>
                    <div class="m-portlet__head-tools">
                        <ul class="m-portlet__nav">
                            <li class="m-portlet__nav-item">
                                <div class="m-dropdown m-dropdown--inline m-dropdown--arrow m-dropdown--align-right m-dropdown--align-push" m-dropdown-toggle="hover" aria-expanded="true">
                                    <a href="#" class="m-portlet__nav-link btn btn-lg btn-secondary  m-btn m-btn--icon m-btn--icon-only m-btn--pill  m-dropdown__toggle">
                                        <i class="la la-refresh"></i>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="m-portlet__body">
                    <div class="m-form m-form--label-align-right m--margin-bottom-30">
                        <div class="row align-items-center">
                            <div class="col-xl-8 order-2 order-xl-1">
                                <div class="form-group m-form__group row align-items-center">
                                    <div class="col-md-4">
                                        <div class="m-input-icon m-input-icon--left">
                                            <input type="text" class="form-control m-input" placeholder="Buscar..." id="generalSearch">
                                            <span class="m-input-icon__icon m-input-icon__icon--left">
                                                <span>
                                                    <i class="la la-search"></i>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4 order-1 order-xl-2 m--align-right">
                                <a :href="urlBase + '/pnae/entradas/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Registro
                                        </span>
                                    </span>
                                </a>
                                <div class="m-separator m-separator--dashed d-xl-none"></div>
                            </div>
                        </div>
                    </div>
                    <div class="m-section">
                        <div class="m-section__content">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th>
                                                #
                                            </th>
                                            <th>
                                                Fornecedor
                                            </th>
                                            <th nowrap="true">
                                                CPF/CNPJ
                                            </th>
                                            <th>
                                                Edital
                                            </th>
                                            <th nowrap="true" class="text-center">
                                                Opções
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="entradas.length == 0">
                                            <td colspan="8">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-for="entrada in entradas">
                                            <td>
                                                {{ entrada.entrada_id }}
                                            </td>
                                            <td>
                                                {{ entrada.has_projeto.has_fornecedor.nome }}
                                            </td>
                                            <td nowrap="true">
                                                {{entrada.has_projeto.has_fornecedor.cpf_cnpj | maskCpfCnpj}}
                                            </td>
                                            <td>
                                                {{ entrada.has_projeto.has_edital.titulo }}
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <a :href="urlBase+'/pnae/entradas/imprimir-recibo/'+entrada.entrada_id" target="_blank" class="btn btn-success m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                									<i class="fa fa-print"></i>
                								</a>
                                                <button @click="verEntrada(entrada)" type="button" data-toggle="modal" data-target="#modal-entrada-mercadoria" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                									<i class="fa fa-eye"></i>
                								</button>
                                                <button type="button" @click="deletar(entrada.entrada_id)" title="Desativar fornecedor produto" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                								</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal entrada mercadoria -->
            <div class="modal fade" id="modal-entrada-mercadoria" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">
                                Lista de produtos
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th>
                                                    Fornecedor
                                                </th>
                                                <th>
                                                    Edital
                                                </th>
                                                <th>
                                                    Produto
                                                </th>
                                                <th>
                                                    Qtd.
                                                </th>
                                                <th>
                                                    Valor Unitário
                                                </th>
                                                <th>
                                                    Valor Total
                                                </th>
                                                <th>
                                                    Data da Entregua
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-if="entrada.has_entrada_mercadoria.length" v-for="entrada_mercadoria in entrada.has_entrada_mercadoria">
                                                <td>
                                                    {{entrada.has_projeto.has_fornecedor.nome}}
                                                </td>
                                                <td>
                                                    {{entrada.has_projeto.has_edital.titulo}}
                                                </td>
                                                <td>
                                                    {{entrada_mercadoria.has_projeto_produto.has_produto.produto}}
                                                </td>
                                                <td>
                                                    {{entrada_mercadoria.qtd_entregue}}
                                                </td>
                                                <td>
                                                    {{entrada_mercadoria.has_projeto_produto.valor_unitario}}
                                                </td>
                                                <td>
                                                    R$ {{entrada_mercadoria.qtd_entregue * entrada_mercadoria.has_projeto_produto.valor_unitario | formaMoeda }}
                                                </td>
                                                <td>
                                                    {{entrada_mercadoria.dta_entrega | date}}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" @click="fecharModal()" class="btn btn-secondary" data-dismiss="modal">
                                Fechar
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'lista-entrada-mercadoria',
        data () {
            return {
                loading : false,
                urlBase: urlBase,
                titulo: 'Cadastrar produto',
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
                entradas : [],
                entrada : '',
            }
        },
        methods : {
            verEntrada : function(entrada){
                this.entrada = entrada;
            },
            deletar : function(entrada_id){
                self = this;
                var url = urlBase + "/pnae/entradas/deletar/" + entrada_id;

                Swal({
                    title: 'Deletar Entrada?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(url).then((response) => {
                            self.getEntrada();
                            self.retorno = response.body;
                        }, response => {
                            self.retorno = response.body;
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    self.loading = false;

                    return Swal({
                        type: self.retorno.status,
                        title: self.retorno.msg,
                    });
                }).catch(Swal.noop)
            },
            getEntrada : function() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/entradas/recuperar-paginado';

                self.$http.get(url).then((response) => {
                    self.entradas = response.body.data;
                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            salvarProduto : function(){
                self = this;

                var produto_fornecido = {
                    fornecedor_id        : self.edit_produto.fornecedor_id,
                    edital_id            : self.edit_produto.edital_id,
                    produtos             : [
                        {
                            produto_fornecido_id : self.edit_produto.produto_fornecido_id,
                            produto              : self.edit_produto.has_produto,
                            quantidade           : self.edit_produto.quantidade,
                            valor_unitario       : self.edit_produto.valor_unitario,
                            valor_total          : self.edit_produto.valor_total,
                            cronograma           : self.edit_produto.has_cronograma,
                            data_inicial_entrega : self.edit_produto.data_inicial_entrega,
                            data_final_entrega   : self.edit_produto.data_final_entrega,
                        }
                    ],
                };

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/projetos/salvar', produto_fornecido).then((response) => {
                            self.retorno = response.body;
                            self.formRequest = {};
                            self.edit_produto = '';
                        }, response => {
                            var form = response.body;
                            self.formRequest = form.errors;
                            self.retorno = 0;
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
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
                }).catch(Swal.noop)
            },
            editarProduto : function(projeto){
                let pr = projeto;
                this.edit_produto = pr;
                this.getProdutos();
                this.getCronogramaEntrega();
                this.getEdital();
                console.log(this.edit_produto);
            },
            fecharModal : function(){
                this.entrada = '';
            },
            getProdutosFornecidos : function(projeto){
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/projetos/recuperar/'+projeto.fornecedor_id+'/'+projeto.edital_id;

                self.$http.get(url).then((response) => {
                    self.produtos_fornecidos = response.body;
                    self.modal_projeto.fornecedor = projeto.has_fornecedor.nome;
                    self.loading = false;
                }, response => {
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getProjetos : function() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/projetos/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.projetos = response.body.data;
                    self.loading = false;
                }, response => {
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
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
        },
        mounted () {
            this.getEntrada();
        },
    };
</script>

<style media="screen">
    .modal .modal-content .modal-footer {
        padding: 15px 25px 15px 25px !important;
    }

    .modal .modal-content .modal-header{
        /* padding: 15px 25px 15px 25px !important; */
    }

    .row-form{
        border: 1px solid #e6e7ea;
        padding-top: 8px;
    }

    .button-produto-save{
        display: flex;
        /* align-items: center; */
        justify-content: flex-end;
        text-align: right;
    }
    .modal-header {
        display: -ms-flexbox;
        display: flex;
        -ms-flex-align: start;
        align-items: flex-start;
        -ms-flex-pack: justify;
        justify-content: space-between;
        padding: 1rem 1rem;
        border-bottom: 1px solid #dee2e6;
        border-top-left-radius: .3rem;
        border-top-right-radius: .3rem;
    }
</style>
