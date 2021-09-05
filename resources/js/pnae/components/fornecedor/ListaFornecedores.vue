<template>
    <div id="lista-fornecedores">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Lista de Fornecedores
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
                                    <div class="col-md-6">
                                        <div class="m-input-icon--left">
                                            <form class="" v-on:submit.prevent="getFornecedores()">
                                                <div class="input-group">
                                                    <div class="input-group-prepend">
                                                        <button class="btn btn-info" title="Buscar fornecedor" type="submit">
                                                            <i class="la la-search"></i>
                                                        </button>
                                                    </div>
                                                    <input type="text" class="form-control" v-model="filtro.string" placeholder="Buscar...">
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4 order-1 order-xl-2 m--align-right">
                                <a :href="urlBase + '/pnae/fornecedores/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Fornecedor
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
                                                Razão Social
                                            </th>
                                            <th nowrap="true">
                                                CPF/CNPJ
                                            </th>
                                            <th nowrap="true">
                                                Tipo Pessoa
                                            </th>
                                            <th>
                                                DAP
                                            </th>
                                            <th nowrap="true" class="text-center">
                                                Opções
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-if="qtdeFornecedores < 1">
                                            <td colspan="6">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-else v-for="fornecedor in listaFornecedores.data">
                                            <th scope="row">
                                                {{ fornecedor.index }}
                                            </th>
                                            <td class="uppercase">
                                                {{ fornecedor.nome }}
                                            </td>
                                            <td nowrap="true">
                                                {{ fornecedor.cpf_cnpj | maskCpfCnpj }}
                                            </td>
                                            <td nowrap="true">
                                                {{ fornecedor.tipo_pessoa == 'PF' ? 'Pessoa Física' : 'Pessoa Jurídica' }}
                                            </td>
                                            <td>
                                                {{ fornecedor.dap_fisica }}
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <a :href="urlBase + '/pnae/fornecedores/editar/' + fornecedor.fornecedor_id" class="btn btn-primary m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-edit"></i>
                                                </a>
                                                <button type="button" @click="deletar(fornecedor.fornecedor_id)" title="Desativar Fornecedor" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <pagination :data="listaFornecedores" @pagination-change-page="getFornecedores"></pagination>

                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: 'lista-fornecedores',
        data() {
            return {
                loading : false,
                urlBase : urlBase,
                listaFornecedores : [],
                filtro : {
                    string : '',
                },
                qtdeFornecedores : 0,
                formRequest : '',
                form_errors: {},
            }
        },
        methods : {
            getFornecedores(page = 1) {
                this.loading = true;
                let string = (this.filtro.string == '' ? 0 : this.filtro.string);

                var url = `${urlBase}/pnae/fornecedores/recuperar-paginado/${string}?page=${page}`;

                this.$http.get(url).then((response) => {
                    this.listaFornecedores = this.countPaginate(response.body);
                    this.qtdeFornecedores = this.listaFornecedores.data.length;

                    this.loading = false;
                }, response => {
                    this.loading = false;

                    return Swal({
                        type: this.response.status,
                        title: this.response.msg,
                    });
                });
            },
            deletar(fornecedor_id) {
                self = this;
                var url = urlBase + "/pnae/fornecedores/deletar/" + fornecedor_id;

                Swal({
                    title: 'Deletar Fornecedor?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(url).then((response) => {
                            self.getFornecedores();
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
            this.getFornecedores();
        },
    };
</script>

<style scoped>

</style>
