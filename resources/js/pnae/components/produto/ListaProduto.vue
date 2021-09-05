<template>
    <div id="lista-produto">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Lista de Produto
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
                                <a :href="urlBase+'/pnae/produtos/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Produto
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
                                                Produto
                                            </th>
                                            <th nowrap="true">
                                                Unidade medida
                                            </th>
                                            <th>
                                                Cotação atual
                                            </th>
                                            <th nowrap="true" class="text-center">
                                                Opções
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="produtos.total < 1">
                                            <td colspan="5">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-for="produto in produtos.data">
                                            <th scope="row">
                                                {{ produto.index }}
                                            </th>
                                            <td>
                                                {{ produto.produto }}
                                            </td>
                                            <td nowrap="true">
                                                {{ produto.has_unidade_medida.nome }} - {{ produto.has_unidade_medida.sigla }}
                                            </td>
                                            <td>
                                                -
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <a :href="urlBase + '/pnae/produtos/editar/' + produto.produto_id" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                									<i class="fa fa-edit"></i>
                								</a>
                                                <button type="button" @click="deletar(produto.produto_id)" title="Desativar Produto" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <pagination :data="produtos" @pagination-change-page="getProdutos"></pagination>
                    
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'lista-produto',
        data () {
            return {
                urlBase: urlBase,
                loading : false,
                titulo: 'Cadastrar produto',
                produtos : {total : 0, data : {}},
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
            }
        },
        methods : {
            getProdutos(page = 1) {
                this.loading = true;

                var url = urlBase + "/pnae/produtos/recuperar-paginado?page=" + page;

                this.$http.get(url).then((response) => {
                    this.produtos = this.countPaginate(response.body);
                    this.loading = false;
                }, response => {
                    this.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            deletar(produto_id) {
                self = this;
                var url = urlBase + "/pnae/produtos/deletar/" + produto_id;

                Swal({
                    title: 'Deletar Produto?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(url).then((response) => {
                            self.getProdutos();
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
        },
        mounted () {
            this.getProdutos();
        },
    };
</script>
