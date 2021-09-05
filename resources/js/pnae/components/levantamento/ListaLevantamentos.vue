<template>
    <div id="lista-levantamentos">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Lista de Levantamentos
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
                    <div class="m-form m-form--label-align-right m--margin-top-20 m--margin-bottom-30">
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
                                <a :href="urlBase + '/pnae/levantamentos-produtivos/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Levantamento
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
                                            <th>
                                                Técnico
                                            </th>
                                            <th nowrap="true">
                                                Data Levantamento
                                            </th>
                                            <th nowrap="true" class="text-center">
                                                Opções
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="qtdeLevantamentos < 1">
                                            <td colspan="5">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-else v-for="levantamento in listaLevantamentos.data">
                                            <th scope="row">
                                                {{ levantamento.index }}
                                            </th>
                                            <td class="uppercase">
                                                {{ levantamento.fornecedor.cpf_cnpj | maskCpfCnpj }} - {{ levantamento.fornecedor.nome }}
                                            </td>
                                            <td>
                                                {{ levantamento.tecnico.cpf | maskCpfCnpj }} - {{ levantamento.tecnico.nome }}
                                            </td>
                                            <td>
                                                {{ levantamento.created_at | date }}
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <a :href="urlBase + '/pnae/levantamentos-produtivos/editar/' + levantamento.levantamento_produtivo_id" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-edit"></i>
                                                </a>
                                                <button type="button" @click="deletar(levantamento.levantamento_produtivo_id)" title="Desativar Levantamento" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <pagination :data="listaLevantamentos" @pagination-change-page="getLevantamentos"></pagination>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'lista-levantamentos',
        data() {
            return {
                loading : false,
                urlBase : urlBase,
                listaLevantamentos : [],
                qtdeLevantamentos : 0,
                formRequest : '',
                form_errors: {},
            }
        },
        methods : {
            getLevantamentos(page = 1) {
                this.loading = true;

                var url = urlBase + '/pnae/levantamentos-produtivos/recuperar-paginado?page=' + page;

                this.$http.get(url).then((response) => {
                    this.listaLevantamentos = this.countPaginate(response.body);
                    this.qtdeLevantamentos = this.listaLevantamentos.data.length;

                    this.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: this.response.status,
                        title: this.response.msg,
                    });
                });
            },
            deletar(levantamento_produtivo_id) {
                self = this;
                var url = urlBase + "/pnae/levantamentos-produtivos/deletar/" + levantamento_produtivo_id;

                Swal({
                    title: 'Deletar Levantamento?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(url).then((response) => {
                            self.getLevantamentos();
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
            this.getLevantamentos();
        },
    };
</script>

<style scoped>

</style>
