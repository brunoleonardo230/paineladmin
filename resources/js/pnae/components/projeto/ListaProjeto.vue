<template>
    <div id="lista-produto">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="m-portlet m-portlet--mobile">
                <div class="m-portlet__head">
                    <div class="m-portlet__head-caption">
                        <div class="m-portlet__head-title">
                            <h3 class="m-portlet__head-text">
                                Lista de Projeto
                            </h3>
                        </div>
                    </div>
                    <div class="m-portlet__head-tools">
                        <ul class="m-portlet__nav">
                            <li class="m-portlet__nav-item">
                                <div class="m-dropdown m-dropdown--inline m-dropdown--arrow m-dropdown--align-right m-dropdown--align-push" m-dropdown-toggle="hover" aria-expanded="true">
                                    <a @click="getProjetos()" href="#" class="m-portlet__nav-link btn btn-lg btn-secondary  m-btn m-btn--icon m-btn--icon-only m-btn--pill  m-dropdown__toggle">
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
                                    <div class="col-md-6">
                                        <label>
                                            Buscar por fornecedor
                                        </label>

                                        <select id="fornecedor" v-model="filtro.fornecedor_id" @change="getProjetos()" class="form-control m-input m-input--square ">
                                            <option :value="0">-- Todos os fornecedores --</option>
                                            <option v-for="fornecedor in fornecedores" :value="fornecedor.fornecedor_id">
                                                {{fornecedor.nome}} - {{fornecedor.cpf_cnpj | maskCpfCnpj}}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label>
                                            Buscar por edital
                                        </label>

                                        <select id="edital" v-model="filtro.edital_id" @change="getProjetos()" class="form-control m-input m-input--square ">
                                            <option :value="0">-- Todos os editais --</option>
                                            <option v-for="edital in editais" :value="edital.edital_id">
                                                {{edital.titulo}}
                                            </option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-4 order-1 order-xl-2 m--align-right">
                                <a :href="urlBase+'/pnae/projetos/cadastrar'" class="btn btn-primary m-btn m-btn--custom m-btn--icon m-btn--air m-btn--pill">
                                    <span>
                                        <i class="la la-plus"></i>
                                        <span>
                                            Novo Projeto
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
                                                Cod.
                                            </th>
                                            <th>
                                                Fornecedor
                                            </th>
                                            <th nowrap="true">
                                                CPF/CNPJ
                                            </th>
                                            <th nowrap="true">
                                                Valor total
                                            </th>
                                            <th nowrap="true">
                                                Data do projeto
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
                                        <tr v-if="!qtd_projetos">
                                            <td colspan="7">
                                                <p class="text-center">
                                                    Nenhum registro encontrado!
                                                </p>
                                            </td>
                                        </tr>
                                        <tr v-else v-for="projeto in projetos.data">
                                            <td>
                                                {{ projeto.index }}
                                            </td>
                                            <td>
                                                {{ projeto.has_fornecedor.nome }}
                                            </td>
                                            <td nowrap="true">
                                                {{ projeto.has_fornecedor.cpf_cnpj | maskCpfCnpj }}
                                            </td>
                                            <td nowrap="true">
                                                R$ {{ projeto.totalProjeto | formaMoeda }}
                                            </td>
                                            <td nowrap="true">
                                                {{ projeto.data_projeto | date }}
                                            </td>
                                            <td>
                                                {{ projeto.has_edital.titulo }}
                                            </td>
                                            <td nowrap="true" class="text-center">
                                                <div class="btn-group btn-group" role="group">
                                                    <button id="btnGroupVerticalDrop1" type="button" class="btn btn-success dropdown-toggle m-btn m-btn--icon m-btn--icon-only m-btn--pill" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <i class="fa fa-print"></i>
                                                    </button>
                                                    <div class="dropdown-menu" aria-labelledby="btnGroupVerticalDrop1">
                                                        <a class="dropdown-item" :href="urlBase+'/pnae/projetos/imprimir/'+projeto.projeto_id" target="_blank">
                                                            <i class="fa fa-print"></i> Projeto
                                                        </a>
                                                        <a class="dropdown-item" :href="urlBase+'/pnae/projetos/contrato/imprimir/'+projeto.projeto_id" target="_blank">
                                                            <i class="fa fa-print"></i> Contrato
                                                        </a>
                                                    </div>
                                                </div>

                                                <a :href="urlBase+'/pnae/projetos/editar/'+projeto.projeto_id" class="btn btn-info m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                									<i class="fa fa-edit"></i>
                								</a>
                                                <button type="button" @click="deletar(projeto.projeto_id)" title="Desativar fornecedor produto" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--pill">
                                                    <i class="fa fa-trash"></i>
                								</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <pagination :data="projetos" @pagination-change-page="getProjetos"></pagination>
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
                loading : false,
                urlBase: urlBase,
                fornecedores:  [],
                editais     :   [],
                projetos    : [],
                money: {
                    decimal: ',',
                    thousands: '.',
                    precision: 2,
                    masked: false
                },
                filtro : {
                    fornecedor_id : 0,
                    edital_id     : 0,
                },
                titulo: 'Cadastrar produto',
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
            }
        },
        methods : {
            deletar(projeto_id) {
                self = this;
                var url = urlBase + "/pnae/projetos/deletar/" + projeto_id;

                Swal({
                    title: 'Deletar projeto?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(url).then((response) => {
                            self.getProjetos();
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
            getProjetos(page = 1) {
                this.loading = true;
                let fornecedor_id   = this.filtro.fornecedor_id;
                let edital_id   = this.filtro.edital_id;
                
                let url = `${urlBase}/pnae/projetos/recuperar-paginado/${fornecedor_id}/${edital_id}?page=${page}`;

                this.$http.get(url).then((response) => {
                    this.projetos = this.countPaginate(response.body);

                    if(this.projetos.data) {
                        this.qtd_projetos = this.projetos.data.length;
                    }

                    this.loading = false;
                }, response => {
                    this.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            getFornecedores : function() {
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/fornecedores/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.fornecedores = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;

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
                    self.loading = false;

                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
        },
        mounted() {
            this.getProjetos();
            this.getFornecedores();
            this.getEdital();
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
    .dropdown-menu{
        padding: 0;
    }
</style>
