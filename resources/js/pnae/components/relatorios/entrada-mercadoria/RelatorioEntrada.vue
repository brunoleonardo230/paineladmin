<template>
    <div id="relatorio-entrada">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="row">
                <div class="col-md-3">
                    <div class="m-portlet">
                        <div class="m-portlet__head">
                            <div class="m-portlet__head-caption">
                                <div class="m-portlet__head-title">
                                    <h3 class="m-portlet__head-text">
                                        Filtros
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <div class="m-portlet__body">
                            <div class="m-portlet m-portlet-- m-portlet--head-sm" m-portlet="true">
                                <div class="m-portlet__head">
                                    <div class="m-portlet__head-caption">
                                        <div class="m-portlet__head-title">
                                            <h3 class="m-portlet__head-text">
                                                Por Data
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="m-portlet__head-tools">
                                        <ul class="m-portlet__nav">
                                            <li class="m-portlet__nav-item">
                                                <a href="javascript:;" m-portlet-tool="toggle" class="m-portlet__nav-link m-portlet__nav-link--icon">
                                                    <i class="la la-plus"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="m-portlet__body">
                                    <div class="m-scrollable" data-scrollable="true" data-max-height="150">
                                        <div class="form-group">
                                            <label>De:</label>
                                            <input type="text" v-mask="['##/##/####']" class="form-control m-input" v-model="filtros.data_inicio" placeholder="">
                                        </div>
                                        <div class="form-group">
                                            <label>Até:</label>
                                            <input type="text" v-mask="['##/##/####']" class="form-control m-input" v-model="filtros.data_fim" placeholder="">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="m-portlet m-portlet-- m-portlet--head-sm" m-portlet="true">
                                <div class="m-portlet__head">
                                    <div class="m-portlet__head-caption">
                                        <div class="m-portlet__head-title">
                                            <h3 class="m-portlet__head-text">
                                                Por Edital
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="m-portlet__head-tools">
                                        <ul class="m-portlet__nav">
                                            <li class="m-portlet__nav-item">
                                                <a href="javascript:;" m-portlet-tool="toggle" class="m-portlet__nav-link m-portlet__nav-link--icon">
                                                    <i class="la la-plus"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="m-portlet__body">
                                    <div class="m-scrollable" data-scrollable="true" data-max-height="100">
                                        <h6 v-if="editais.length == 0" class="text-center">
                                            Não há editais.
                                        </h6>
                                        <div class="form-group">
                                            <label class="m-checkbox" v-for="edital in editais">
                                                <input type="checkbox" :value="edital.edital_id" v-model="filtros.editais_id">
                                                {{ edital.descricao }}
                                                <span></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="m-portlet m-portlet-- m-portlet--head-sm" m-portlet="true">
                                <div class="m-portlet__head">
                                    <div class="m-portlet__head-caption">
                                        <div class="m-portlet__head-title">
                                            <h3 class="m-portlet__head-text">
                                                Por Fornecedor
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="m-portlet__head-tools">
                                        <ul class="m-portlet__nav">
                                            <li class="m-portlet__nav-item">
                                                <a href="javascript:;" m-portlet-tool="toggle" class="m-portlet__nav-link m-portlet__nav-link--icon">
                                                    <i class="la la-plus"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="m-portlet__body">
                                    <div class="m-scrollable" data-scrollable="true" data-max-height="100">
                                        <h6 v-if="fornecedores.length == 0" class="text-center">
                                            Não há fornecedores.
                                        </h6>
                                        <div class="form-group">
                                            <label class="m-checkbox" v-for="fornecedor in fornecedores">
                                                <input type="checkbox" :value="fornecedor.fornecedor_id" v-model="filtros.fornecedores_id">
                                                {{ fornecedor.nome }}
                                                <span></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="m-portlet m-portlet-- m-portlet--head-sm" m-portlet="true">
                                <div class="m-portlet__head">
                                    <div class="m-portlet__head-caption">
                                        <div class="m-portlet__head-title">
                                            <h3 class="m-portlet__head-text">
                                                Por Produto
                                            </h3>
                                        </div>
                                    </div>
                                    <div class="m-portlet__head-tools">
                                        <ul class="m-portlet__nav">
                                            <li class="m-portlet__nav-item">
                                                <a href="javascript:;" m-portlet-tool="toggle" class="m-portlet__nav-link m-portlet__nav-link--icon">
                                                    <i class="la la-plus"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="m-portlet__body">
                                    <div class="m-scrollable" data-scrollable="true" data-max-height="100">
                                        <h6 v-if="produtos.length == 0" class="text-center">
                                            Não há produtos.
                                        </h6>
                                        <div class="form-group">
                                            <label class="m-checkbox" v-for="produto in produtos">
                                                <input type="checkbox" :value="produto.produto_id" v-model="filtros.produtos_id">
                                                {{ produto.produto }}
                                                <span></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="m-portlet__foot">
                            <div class="row align-items-center">
                                <div class="col-lg-12 m--align-left">
                                    <button type="button" @click="filtrar()" class="btn btn-sm btn-primary">
                                        Buscar
                                    </button>
                                    <button type="reset" class="btn btn-sm btn-secondary">
                                        Limpar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="m-portlet m-portlet--mobile">
                        <div class="m-portlet__head">
                            <div class="m-portlet__head-caption">
                                <div class="m-portlet__head-title">
                                    <h3 class="m-portlet__head-text">
                                        Relatório de Entrada de Produtos
                                    </h3>
                                </div>
                            </div>
                            <div class="m-portlet__head-tools">
                                <ul class="m-portlet__nav">
                                    <li class="m-portlet__nav-item">
                                        <div class="m-dropdown m-dropdown--inline m-dropdown--arrow m-dropdown--align-right m-dropdown--align-push" m-dropdown-toggle="hover" aria-expanded="true">
                                            <a href="#" class="m-portlet__nav-link btn btn-lg btn-secondary m-btn m-btn--icon m-btn--icon-only m-btn--pill m-dropdown__toggle">
                                                <i class="la la-refresh"></i>
                                            </a>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="m-portlet__body">
                            <div class="m-section">
                                <div class="m-section__content">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover table-striped">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        Edital
                                                    </th>
                                                    <th>
                                                        Produto
                                                    </th>
                                                    <th>
                                                        Fornecedor
                                                    </th>
                                                    <th class="text-center">
                                                        Data Entrega
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-if="qtdeEntradas < 1">
                                                    <td colspan="4">
                                                        <p class="text-center">
                                                            {{ msg }}
                                                        </p>
                                                    </td>
                                                </tr>
                                                <tr v-else v-for="entrada in entradas.data">
                                                    <td>
                                                        {{ entrada.has_projeto_produto.has_projeto.has_edital.titulo }}
                                                    </td>
                                                    <td>
                                                        {{ entrada.has_projeto_produto.has_produto.produto }}
                                                    </td>
                                                    <td>
                                                        {{ entrada.has_projeto_produto.has_projeto.has_fornecedor.nome }}
                                                    </td>
                                                    <td class="text-center">
                                                        {{ entrada.dta_entrega | date }}
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <pagination v-if="qtdeEntradas > 0" :data="entradas" @pagination-change-page="filtrar"></pagination>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'relatorio-entrada',
        data () {
            return {
                loading : false,
                url: urlBase,
                filtros: {
                    data_inicio   : '',
                    data_fim      : '',
                    editais_id: [],
                    produtos_id: [],
                    fornecedores_id: [],
                },
                produtos: [],
                fornecedores: [],
                editais: [],
                entradas: [],
                qtdeEntradas : 0,
                msg: 'Selecione um filtro!',
                form_errors: {},
            }
        },
        methods : {
            filtrar(page = 1) {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/entrada-de-produtos/filtrar?page=' + page;
    
                self.$http.post(url, self.filtros).then((response) => {
                    self.entradas = response.data;
                    self.qtdeEntradas = self.entradas.data.length;

                    if (self.qtdeEntradas < 1) {
                        this.msg = "Nenhum registro encontrado!";
                    }

                    self.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getProdutos() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/produtos/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.produtos = response.body;
                    self.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getEditais() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/editais/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.editais = response.body;
                    self.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getFornecedores() {
                self = this;
                self.loading = true;
                var url = urlBase + '/pnae/fornecedores/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.fornecedores = response.body;
                    self.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
        },
        mounted () {
            this.getProdutos();
            this.getFornecedores();
            this.getEditais();
        },
    };
</script>
