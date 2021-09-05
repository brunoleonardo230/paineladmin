<template>
    <div id="ajuste-projeto">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head" style="height: 4.1rem;">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Filtrar produtos
                            </h3>
                        </div>
                    </div>
                </div>

                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <div class="row align-items-center m--margin-bottom-30 m--margin-top-30">
                                <div class="col-xl-12">
                                    <div class="row">
                                        <div class="col-lg-3 col-xl-3 col-md-3 col-sm-12">
                                            <label>
                                                Edital
                                            </label>
                                            <select v-model="pesquisa.edital" id="edital" class="form-control m-input m-input--square ">
                                                <option :value="''">-- Selecione o edital --</option>
                                                <option v-for="edital in editais" :value="edital">
                                                    {{edital.titulo}}
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 col-xl-3 col-md-3 col-sm-12">
                                            <label>
                                                Produto
                                            </label>
                                            <select v-model="pesquisa.produto" id="produtos" class="form-control m-input m-input--square ">
                                                <option :value="''">-- Selecione o produto --</option>
                                                <option v-for="produto in pesquisa.edital.edital_has_produto" :value="produto">
                                                    {{produto.has_produto.produto}}
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-3 col-xl-3 col-md-3 col-sm-12">
                                            <label>
                                                Fornecedor
                                            </label>
                                            <select v-model="pesquisa.fornecedor_id" id="fornecedor" class="form-control m-input m-input--square ">
                                                <option :value="''">-- Selecione o fornecedor --</option>
                                                <option v-for="fornecedor in fornecedores" :value="fornecedor.fornecedor_id">
                                                    {{fornecedor.nome}}
                                                </option>
                                            </select>
                                        </div>
                                        <div class="col-lg-2 col-xl-2 col-md-2 col-sm-12 padding-top-25">
                                            <button type="button" @click="buscarLevantamento()" class="btn btn-primary m-btn m-input m-input--square">
                                                <span>
                                                    <i class="la la-search"></i>
                                                    <span>
                                                        BUSCAR
                                                    </span>
                                                </span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-4 order-1 order-xl-2 m--align-right">
                                    <div class="m-separator m-separator--dashed d-xl-none"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__body">
                    <div class="m-section">
                        <div class="m-section__content">
                            <div class="row align-items-center m--margin-bottom-30">
                                <div class="col-xl-12" v-if="projetos.length != 0">
                                    <div class="row">
                                        <div class="col-lg-12 col-xl-12 col-md-12 col-sm-12">
                                            <label>
                                                Digete o percentual a ser reduzido <br><br>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4 col-xl-4 col-md-4 col-sm-12">
                                            <div class="input-group">
                                                <input type="text" v-model="porcentagem_ajuste" class="form-control" placeholder="Porcentagem a ser removida" aria-describedby="basic-addon2">
                                                <div class="input-group-append">
                                                    <span class="input-group-text" id="basic-addon2">
                                                        %
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-2 col-xl-2 col-md-2 col-sm-12">
                                            <button type="button" @click="calcularAjuste()" class="btn btn-primary m-btn m-input m-input--square">
                                                <span>
                                                    <i class="fa fa-level-down"></i>
                                                    <span>
                                                        Calcular
                                                    </span>
                                                </span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="table-responsive">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <tr>
                                            <th style="vertical-align: middle;" v-if="projetos.length > 0">
                                                <label class="kt-checkbox" style="margin-bottom: 0rem;" @click="checkAll()">
                                                    <input type="checkbox" v-model="chackAll">
                                                    <span></span>
                                                </label>
                                            </th>
                                            <th style="vertical-align: middle;">
                                                Cod.
                                            </th>
                                            <th style="vertical-align: middle;">
                                                Fornecedor
                                            </th>
                                            <th style="vertical-align: middle;">
                                                CPF/CNPJ
                                            </th>
                                            <th style="vertical-align: middle;">
                                                Edital
                                            </th>
                                            <th style="vertical-align: middle;">
                                                Produto
                                            </th>
                                            <th style="vertical-align: middle;">
                                                Qtd.
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="projetos.length < 1">
                                            <td colspan="6">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-for="projeto in projetos">
                                            <td style="vertical-align: middle;">
                                                <label class="kt-checkbox" style="margin-bottom: 0rem;">
                                                    <input type="checkbox" @click="unckeckAll()" :value="projeto" v-model="projeto_produtos">
                                                    <span></span>
                                                </label>
                                            </td>
                                            <td style="vertical-align: middle;">
                                                {{projeto.projeto_id}}
                                            </td>
                                            <td style="vertical-align: middle;">
                                                {{projeto.fornecedor}}
                                            </td>
                                            <td style="vertical-align: middle;">
                                                {{projeto.cpf_cnpj}}
                                            </td>
                                            <td style="vertical-align: middle;">
                                                {{projeto.titulo}}
                                            </td>
                                            <td style="vertical-align: middle;">
                                                {{projeto.produto}}
                                            </td>
                                            <td style="vertical-align: middle;">
                                                {{projeto.quantidade}}{{projeto.sigla}}
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal -->
                <div class="modal fade" id="modalAjustar" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Cálculo de ajuste</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Ajuste de <b>{{porcentagem_ajuste}}%</b> nos produtos abaixo</p>
                                <!-- <p>Saldo restante: {{saldoRestante}}</p> -->
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th style="vertical-align: middle;">
                                                    Cod.
                                                </th>
                                                <th style="vertical-align: middle;">
                                                    Fornecedor
                                                </th>
                                                <th style="vertical-align: middle;">
                                                    CPF/CNPJ
                                                </th>
                                                <th style="vertical-align: middle;">
                                                    Edital
                                                </th>
                                                <th style="vertical-align: middle;">
                                                    Produto
                                                </th>
                                                <th style="vertical-align: middle;">
                                                    Nova Qtd.
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-if="produtos_recalculado.length < 1">
                                                <td colspan="6">
                                                    <p class="text-center">
                                                        Nenhum registro encontrado!
                                                    </p>
                                                </td>
                                            </tr>
                                            <tr v-for="produto in produtos_recalculado">
                                                <td style="vertical-align: middle;">
                                                    {{produto.projeto_produtos_id}}
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    {{produto.fornecedor}}
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    {{produto.cpf_cnpj}}
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    {{produto.titulo}}
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    {{produto.produto}}
                                                </td>
                                                <td style="vertical-align: middle;">
                                                    {{produto.quantidade}}{{produto.sigla}}
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" @click="limparReajuste()" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                <button type="button" @click="confirmarReajuste()" class="btn btn-primary">Confirmar ajuste</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'ajuste-projeto',
        data () {
            return {
                loading      : false,
                urlBase      : urlBase,
                retornoDados : '',
                retorno      : '',
                money        : {
                    decimal: ',',
                    thousands: '.',
                    precision: 2,
                    masked: false
                },
                modal_projeto : {
                    fornecedor : '',
                },
                titulo: 'Ajustar projeto',
                projetos : [],
                btn: {
                    action  : '',
                    icon    : '',
                },
                chackAll            : false,
                produtos            : [],
                editais             : [],
                fornecedores        : [],
                projeto_produtos    : [],
                produtos_recalculado : [],
                porcentagem_ajuste  : '',
                pesquisa : {
                    edital : '',
                    produto : '',
                    fornecedor_id : '',
                },
            }
        },
        computed : {
            saldoRestante : function(){
                var saldo = 0;
                self.produtos_recalculado.forEach(function(p){
                    saldo += p.quantidade;
                });

                return self.pesquisa.produto.quantidade - saldo;
            },
        },
        methods : {
            confirmarReajuste : function(){
                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/projetos/projeto-produtos/salvar', self.produtos_recalculado).then((response) => {
                            self.retorno = response.body;
                            self.retornoDados = response.body.dados;
                            self.buscarLevantamento();
                            self.produtos_recalculado = [];
                            self.formRequest = {};
                            self.projeto_produtos = [];
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
            limparReajuste : function(){
                self.produtos_recalculado = [];
                self.projeto_produtos     = [];
                // self.produtos_recalculado = [];
            },
            calcularAjuste : function(){
                self = this;
                if (self.checkAjuste()) { return true; }
                $('#modalAjustar').modal('show');
                var prods = [];
                self.projeto_produtos.forEach(function(produto, key){
                    var nova_qtd = 0;
                    nova_qtd = Math.round((produto.quantidade - ((produto.quantidade * self.porcentagem_ajuste)/100)));

                    prods[key] = {
                        fornecedor  : produto.fornecedor,
                        cpf_cnpj    : produto.cpf_cnpj,
                        titulo      : produto.titulo,
                        produto     : produto.produto,
                        projeto_produtos_id     : produto.projeto_produtos_id,
                        produto_id              : produto.produto_id,
                        projeto_id              : produto.projeto_id,
                        quantidade              : nova_qtd,
                        valor_unitario          : produto.valor_unitario,
                        data_inicial_entrega    : produto.data_inicial_entrega,
                        data_final_entrega      : produto.data_final_entrega,
                        cronograma_entrega_id   : produto.cronograma_entrega_id,
                        sigla   : produto.sigla
                    };
                });
                self.produtos_recalculado = prods;
            },
            checkAll : function(){
                self = this;

                self.chackAll = (self.chackAll == true ? false : true);
                if (self.chackAll) {
                    self.projetos.forEach(function(projeto) {
                        self.projeto_produtos.push(projeto);
                    });
                }else {
                    self.projeto_produtos = [];
                }

            },
            unckeckAll : function(){
                this.chackAll = false;
            },
            buscarLevantamento : function(){
                self = this;
                if (self.checkBusca()) { return true; }
                var url = urlBase+"/pnae/ajuste-de-projetos/buscar";
                var parametro = {
                    edital_id       : self.pesquisa.edital.edital_id,
                    produto_id      : self.pesquisa.produto.produto_id,
                    fornecedor_id   : self.pesquisa.fornecedor_id,
                }
                self.$http.get(url, {params: parametro}).then(response => {
                    self.projetos = response.body;
                    // console.log(response.body);
                }, response => {
                    // error callback
                });
            },
            getEditais() {
                this.loading = true;
                var url = urlBase + '/pnae/editais/recuperar-todos';

                this.$http.get(url).then((response) => {
                    this.editais = response.body;
                    this.loading = false;
                }, response => {
                    this.loading = false;
                    return Swal({
                        type: this.response.status,
                        title: this.response.msg,
                    });
                });
            },
            getFornecedores() {
                this.loading = true;

                var url = urlBase + '/pnae/fornecedores/recuperar-todos';

                this.$http.get(url).then((response) => {
                    this.fornecedores = response.body;
                    this.loading = false;
                }, response => {
                    this.loading = false;

                    return Swal({
                        type: this.response.status,
                        title: this.response.msg,
                    });
                });
            },
            checkAjuste : function(){
                self = this;
                if (self.porcentagem_ajuste == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Digite a porcentagem a ser reajustado',
                    });
                    return true;
                }
                if (self.projeto_produtos.length == 0) {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Selecione um ou mais projeto abaixo',
                    });
                    return true;
                }
                return false;
            },
            checkBusca : function(){
                self = this;

                if (self.pesquisa.edital == '') {
                    Swal({
                        type: 'error',
                        title: 'Atenção',
                        html: 'Selecione um edital!',
                    });
                    return true;
                }
                return false;
            },
        },
        mounted () {
            this.getEditais();
            this.getFornecedores();
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
    .vertical-align{
        vertical-align: middle;
    }
    .table td, .table th {
        padding: .55rem;
        vertical-align: top;
        border-top: 1px solid #f4f5f8;
    }
</style>
