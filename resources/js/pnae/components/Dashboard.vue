<template>
    <div id="dashboard">
        <div class="m-content">
            <div class="row">
                <div class="col-lg-7">
                    <div class="row"> 
                        <div class="col-12">
                            <div class="small-box bg-danger">
                                <div class="inner">
                                    <h3>R$ {{ (valorTotalAContratar - valorTotalProdutosContratados) | formaMoeda }} <small style="font-size: 10pt;"> de R$ {{ valorTotalAContratar | formaMoeda }}</small></h3>
                                    <p>Total Disponível</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-folder-o"></i>
                                </div>

                                <a :href="url + '/pnae/editais/index'" class="small-box-footer">
                                    Ver mais <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="small-box bg-success">
                                <div class="inner">
                                    <h3>R$ {{ valorTotalProdutosContratados | formaMoeda }}</h3>
                                    <p>Total Contratado</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-folder-o"></i>
                                </div>
                                <a :href="url + '/pnae/projetos/index'" class="small-box-footer">
                                    Ver mais <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="small-box bg-marron">
                                <div class="inner">
                                    <h3>R$ {{ valorTotalProdutosFornecidos | formaMoeda  }}</h3>
                                    <p>Total Fornecido</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-shopping-cart"></i>
                                </div>
                                <a :href="url + '/pnae/entradas/index'" class="small-box-footer">
                                    Ver mais <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="small-box bg-info">
                                <div class="inner">
                                    <h3>{{ qtdeFornecedores }}</h3>
                                    <p>Fornecedores</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-truck"></i>
                                </div>
                                <a :href="url + '/pnae/fornecedores/index'" class="small-box-footer">
                                    Ver mais <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="small-box bg-roxa">
                                <div class="inner">
                                    <h3>{{ qtdeContratos }}</h3>
                                    <p>Nº Contratos</p>
                                </div>
                                <div class="icon">
                                    <i class="fa fa-file-text-o"></i>
                                </div>
                                <a :href="url + '/pnae/projetos/index'" class="small-box-footer">
                                    Ver mais <i class="fa fa-arrow-circle-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
        		<div class="col-lg-7">
                    <div class="m-portlet m--bg-azul m-portlet--bordered-semi m-portlet--full-height">
                        <div class="m-portlet__head">
                            <div class="m-portlet__head-caption">
                                <div class="m-portlet__head-title">
                                    <h3 class="m-portlet__head-text m--font-light">
                                        Projetos
                                    </h3>
                                </div>
                            </div>
                            <div class="m-portlet__head-tools">
                                <ul class="m-portlet__nav">
                                    <li class="m-portlet__nav-item m-dropdown m-dropdown--inline m-dropdown--arrow m-dropdown--align-right m-dropdown--align-push">
                                        <a href="#" class="m-portlet__nav-link m-dropdown__toggle btn btn--sm m-btn--pill m-btn btn-outline-light m-btn--hover-light">
                                            Todos
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="m-portlet__body">
                            <div class="m-widget29">
                                <div class="m-widget_content">
                                    <h3 class="m-widget_content-title">
                                        Maior Contrato
                                    </h3>
                                    <div class="m-widget_content-items">
                                        <div class="m-widget_content-item">
                                            <span>
                                                Valor
                                            </span>
                                            <span class="m--font-brand">
                                                R$ {{ maiorContrato != null ? maiorContrato.valor_unitario_total * maiorContrato.quantidade_total : 0 | formaMoeda }}
                                            </span>
                                        </div>
                                        <div class="m-widget_content-item">
                                            <span>
                                                Total de Produtos
                                            </span>
                                            <span class="m--font-accent">
                                                {{ maiorContrato != null ? maiorContrato.quantidade_total : '--' }}
                                            </span>
                                        </div>
                                        <div class="m-widget_content-item">
                                            <span>
                                                Fornecido
                                            </span>
                                            <span>
                                                {{ maiorContrato != null ? maiorContrato.total_entregue : '--' }}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-widget_content">
                                    <h3 class="m-widget_content-title">
                                        Menor Contrato
                                    </h3>
                                    <div class="m-widget_content-items">
                                        <div class="m-widget_content-item">
                                            <span>
                                                Valor
                                            </span>
                                            <span class="m--font-brand">
                                                R$ {{ menorContrato != null ? menorContrato.valor_unitario_total * menorContrato.quantidade_total : 0 | formaMoeda }}
                                            </span>
                                        </div>
                                        <div class="m-widget_content-item">
                                            <span>
                                                Total de Produtos
                                            </span>
                                            <span class="m--font-accent">
                                                {{ menorContrato != null ? menorContrato.quantidade_total : '--' }}
                                            </span>
                                        </div>
                                        <div class="m-widget_content-item">
                                            <span>
                                                Fornecido
                                            </span>
                                            <span>
                                                {{ menorContrato != null ? menorContrato.total_entregue : '--' }}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-widget_content">
                                    <h3 class="m-widget_content-title">
                                        Média de Contratos
                                    </h3>
                                    <div class="m-widget_content-items">
                                        <div class="m-widget_content-item">
                                            <span>
                                                Valor
                                            </span>
                                            <span class="m--font-brand">
                                                R$ {{ mediaContratos != null ? mediaContratos.valor_unitario_total * mediaContratos.quantidade_total : 0 | formaMoeda }}
                                            </span>
                                        </div>
                                        <div class="m-widget_content-item">
                                            <span>
                                                Total de Produtos
                                            </span>
                                            <span class="m--font-accent">
                                                {{ mediaContratos != null ? mediaContratos.quantidade_total : 0 | formaNumero }}
                                            </span>
                                        </div>
                                        <div class="m-widget_content-item">
                                            <span>
                                                Fornecido
                                            </span>
                                            <span>
                                                {{ mediaContratos != null ? mediaContratos.total_entregue : 0 | formaNumero }}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="m-portlet">
                        <div class="m-portlet__head">
                            <div class="m-portlet__head-caption">
                                <div class="m-portlet__head-title">
                                    <h3 class="m-portlet__head-text">
                                        Mais Ofertados
                                    </h3>
                                </div>
                            </div>
                            <div class="m-portlet__head-tools">
                                <ul class="m-portlet__nav">
                                    <li class="m-portlet__nav-item m-dropdown m-dropdown--inline m-dropdown--arrow m-dropdown--align-right m-dropdown--align-push">
                                        <a class="m-portlet__nav-link m-dropdown__toggle btn btn--sm m-btn--pill btn-secondary m-btn">
                                            Todos
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="m-portlet__body m-portlet__body--no-padding">
                            <div class="row m-row--no-padding m-row--col-separator-xl">
                                <div class="col-md-12 col-lg-12 col-xl-12">
                                    <div class="m-widget1">
                                        <div v-if="produtosMaisContradados.length < 1" class="m-widget1__item">
                                            <div class="row m-row--no-padding align-items-center">
                                                <div class="col">
                                                    <h3 class="m-widget1__title">
                                                        Nenhum item registrado
                                                    </h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div v-else v-for="produto in produtosMaisContradados" class="m-widget1__item">
                                            <div class="row m-row--no-padding align-items-center">
                                                <div class="col">
                                                    <h3 class="m-widget1__title">
                                                        {{ produto.produto.produto }}
                                                    </h3>
                                                </div>
                                                <div class="col">
                                                    <h3 class="m-widget1__title">
                                                        {{ produto.total_produtos }}
                                                    </h3>
                                                </div>
                                                <div class="col m--align-right">
                                                    <span class="m-widget1__number m--font-success">
                                                        R$ {{ produto.valor_total | formaMoeda }}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
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
        props : ['dados'],
        name: 'dashboard',
        data () {
            return {
                url: urlBase,
                qtdeContratos : 0,
                maiorContrato : {},
                menorContrato : {},
                mediaContratos : {},
                qtdeFornecedores : 0,
                valorTotalAContratar : 0,
                valorTotalProdutosFornecidos : 0,
                valorTotalProdutosContratados : 0,
                produtosMaisContradados : [],
            }
        },
        methods : {
            checkDados() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.qtdeContratos = dados.qtdeContratos;
                    this.maiorContrato = dados.maiorContrato;
                    this.menorContrato = dados.menorContrato;
                    this.mediaContratos = dados.mediaContratos;
                    this.qtdeFornecedores = dados.qtdeFornecedores;
                    this.produtosMaisContradados = dados.produtosMaisContradados;
                    this.valorTotalAContratar = dados.valorTotalAContratar;
                    this.valorTotalProdutosFornecidos = dados.valorTotalProdutosFornecidos;
                    this.valorTotalProdutosContratados = dados.valorTotalProdutosContratados;
                }
            }
        },
        mounted() {
            this.checkDados();
        }
    };
</script>

<style scoped>
    .m--bg-azul {
        background-color: #716aca !important;
    }

    .bg-info, .bg-info>a {
        color: #fff!important;
    }

    .bg-info {
        background-color: #17a2b8!important;
    }

    .small-box {
        border-radius: .25rem;
        box-shadow: 0 0 1px rgba(0,0,0,.125), 0 1px 3px rgba(0,0,0,.2);
        display: block;
        margin-bottom: 20px;
        position: relative;
    }

    .small-box>.inner {
        padding: 10px;
    }

    @media (min-width: 1200px)
    .col-lg-3 .small-box h3, .col-md-3 .small-box h3, .col-xl-3 .small-box h3 {
        font-size: 2.2rem;
    }

    @media (min-width: 992px)
    .col-lg-3 .small-box h3, .col-md-3 .small-box h3, .col-xl-3 .small-box h3 {
        font-size: 1.6rem;
    }

    .small-box h3, .small-box p {
        z-index: 5;
    }

    .small-box h3 {
        font-size: 2.2rem;
        font-weight: 700;
        margin: 0 0 10px 0;
        padding: 0;
        white-space: nowrap;
    }

    .small-box p {
        font-size: 1rem;
    }

    .small-box .icon {
        color: rgba(0,0,0,.15);
        z-index: 0;
    }

    .small-box .icon>i.fa, .small-box .icon>i.fab, .small-box .icon>i.far, .small-box .icon>i.fas, .small-box .icon>i.glyphicon, .small-box .icon>i.ion {
        font-size: 70px;
        top: 20px;
    }

    .small-box .icon>i {
        font-size: 90px;
        position: absolute;
        right: 15px;
        top: 15px;
        transition: all .3s linear;
    }

    .small-box>.small-box-footer {
        background: rgba(0,0,0,.1);
        color: rgba(255,255,255,.8);
        display: block;
        padding: 3px 0;
        position: relative;
        text-align: center;
        text-decoration: none;
        z-index: 10;
    }

    .bg-info, .bg-info>a {
        color: #fff!important;
    }

    .bg-success, .bg-success>a {
        color: #fff!important;
    }

    .bg-success {
        background-color: #28a745!important;
    }

    .bg-warning, .bg-warning>a {
        color: #1f2d3d!important;
    }

    .bg-warning {
        background-color: #ffc107!important;
    }

    .bg-danger, .bg-danger>a {
        color: #fff!important;
    }

    .bg-danger {
        background-color: #dc3545!important;
    }

    .bg-marron {
        background-color: #deac17!important;
    }

    .bg-marron, .bg-marron>a {
        color: #fff!important;
    }

    .bg-roxa {
        background-color: rgb(113, 106, 202)!important;
    }

    .bg-roxa, .bg-roxa>a {
        color: #fff!important;
    }

    .small-box>.small-box-footer:hover {
        background: rgba(0,0,0,.15);
        color: #fff;
    }

    .small-box:hover {
        text-decoration: none;
    }
</style>
