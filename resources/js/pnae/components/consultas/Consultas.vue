<template>
    <div id="contatos">
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Links Úteis
                            </h3>
                        </div>
                    </div>
                    <div class="m-portlet__head-tools">
                        <ul class="m-portlet__nav">
                            <li class="m-portlet__nav-item m-dropdown m-dropdown--inline m-dropdown--arrow m-dropdown--align-right m-dropdown--align-push" m-dropdown-toggle="hover">
                                <a href="#" class="m-portlet__nav-link m-dropdown__toggle dropdown-toggle btn btn--sm m-btn--pill btn-secondary m-btn m-btn--label-brand">
                                    Todos
                                </a>
                                <div class="m-dropdown__wrapper">
                                    <span class="m-dropdown__arrow m-dropdown__arrow--right m-dropdown__arrow--adjust"></span>
                                    <div class="m-dropdown__inner">
                                        <div class="m-dropdown__body">
                                            <div class="m-dropdown__content">
                                                <ul class="m-nav">
                                                    <li class="m-nav__section m-nav__section--first">
                                                        <span class="m-nav__section-text">
                                                            Todos
                                                        </span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="m-portlet__body">
                    <div class="m-widget4">
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Emissão Extrato DAP - SEAD
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://smap14.mda.gov.br/extratodap/" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
                            </div>
                        </div>
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Certidão Negativa de Débitos Trabalhistas - TST
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://www.tst.jus.br/certidao" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
                            </div>
                        </div>
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Certidão Negativa de Débito - SEFAZ
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://sistemas.sefaz.ma.gov.br/certidoes/jsp/emissaoCertidaoNegativa/emissaoCertidaoNegativa.jsf" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
                            </div>
                        </div>
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Certidão Negativa de Dívida Ativa - SEFAZ
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://sistemas.sefaz.ma.gov.br/certidoes/jsp/emissaoCertidaoNegativaDividaAtiva/emissaoCertidaoNegativaDividaAtiva.jsf" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
                            </div>
                        </div>
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Certidão Negativa de Débito Por CPF - Receita da Fazenda
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://servicos.receita.fazenda.gov.br/Servicos/certidao/CNDConjuntaInter/InformaNICertidao.asp?tipo=1" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
                            </div>
                        </div>
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Certidão Negativa de Débito Por CNPJ - Receita da Fazenda
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://servicos.receita.fazenda.gov.br/Servicos/certidao/CNDConjuntaInter/InformaNICertidao.asp?tipo=2" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
                            </div>
                        </div>
                        <div class="m-widget4__item">
                            <div class="m-widget4__info">
                                <span class="m-widget4__text">
                                    Nota Fiscal Avulsa Pública - SEFAZ
                                </span>
                            </div>
                            <div class="m-widget4__ext">
                                <a href="http://aplicacoes.ma.gov.br/nfae/jsp/login/login.jsf" class="m-btn m-btn--pill btn btn-sm btn-primary" target="_blank">
                                    Visitar
                                </a>
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
        name: 'consultas',
        data () {
            return {
            }
        },
        methods : {
        },
    };
</script>

<style scoped>
</style>
