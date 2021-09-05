<template>
    <div id="lista-agencia">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Lista de Agências
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
                                <a :href="url + '/pnae/agencias/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Agência
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
                                                Banco
                                            </th>
                                            <th>
                                                Local
                                            </th>
                                            <th>
                                                Agência
                                            </th nowrap="true">
                                            <th class="text-center">
                                                Opções
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="qtdeAgencias < 1">
                                            <td colspan="5">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-else v-for="agencia in agencias.data">
                                            <th scope="row">
                                                {{ agencia.index }}
                                            </th>
                                            <td>
                                                {{ agencia.banco.nome }}
                                            </td>
                                            <td>
                                                {{ agencia.nome }}
                                            </td>
                                            <td>
                                                {{ agencia.numero }}
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <a :href="url + '/pnae/agencias/editar/' + agencia.agencia_id" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                									<i class="fa fa-edit"></i>
                								</a>
                                                <button type="button" @click="deletar(agencia.agencia_id)" title="Desativar Agência" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <pagination :data="agencias" @pagination-change-page="getAgencias"></pagination>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'lista-agencia',
        data () {
            return {
                loading : false,
                url: urlBase,
                agencias : [],
                qtdeAgencias : 0,
                formRequest : '',
                form_errors: {},
            }
        },
        methods : {
            getAgencias(page = 1) {
                this.loading = true;
                var url = urlBase + '/pnae/agencias/recuperar-paginado?page=' + page;

                this.$http.get(url).then((response) => {
                    this.agencias = this.countPaginate(response.body);
                    this.qtdeAgencias = this.agencias.data.length;
                    
                    this.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            deletar(agencia_id) {
                self = this;
                var url = urlBase + "/pnae/agencias/deletar/" + agencia_id;

                Swal({
                    title: 'Deletar Agência?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(url).then((response) => {
                            self.getAgencias();
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
            this.getAgencias();
        },
    };
</script>
