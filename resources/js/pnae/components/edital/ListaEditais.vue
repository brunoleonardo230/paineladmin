<template>
    <div id="lista-editais">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Lista de Editais
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
                                <a :href="urlBase + '/pnae/editais/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Edital
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
                                                Titulo
                                            </th>
                                            <th>
                                                Descrição
                                            </th>
                                            <th nowrap="true" class="text-center">
                                                Opções
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="qtdeEditais < 1">
                                            <td colspan="4">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-else v-for="edital in editais.data">
                                            <th scope="row">
                                                {{ edital.index }}
                                            </th>
                                            <td class="uppercase">
                                                {{ edital.titulo }}
                                            </td>
                                            <td>
                                                {{ edital.descricao }}
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <a :href="urlBase+'/pnae/editais/editar/' + edital.edital_id" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                									<i class="fa fa-edit"></i>
                								</a>
                                                <button type="button" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                								</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <pagination :data="editais" @pagination-change-page="getEditais"></pagination>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'lista-editais',
        data() {
            return {
                loading : false,
                urlBase : urlBase,
                editais : [],
                qtdeEditais : 0,
                formRequest : '',
                form_errors: {},
            }
        },
        methods : {
            getEditais(page = 1) {
                self = this;
                self.loading = true;

                var url = urlBase + '/pnae/editais/recuperar-paginado?page=' + page;

                self.$http.get(url).then((response) => {
                    this.editais = this.countPaginate(response.body);
                    self.qtdeEditais = self.editais.data;

                    self.loading = false;
                }, response => {
                    self.loading = false;

                    return Swal({
                        type: self.response.status,
                        title: self.response.msg,
                    });
                });
            },
        },
        mounted () {
            this.getEditais();
        },
    };
</script>

<style scoped>

</style>
