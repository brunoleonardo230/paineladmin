<template>
    <div id="form-produto">
        <loading v-show="loading"></loading>
        <div class="m-content">
            <div class="row">
                <div class="col-lg-12">
                    <div class="m-portlet">
                        <div class="m-portlet__head">
                            <div class="m-portlet__head-caption">
                                <div class="m-portlet__head-title">
                                    <span class="m-portlet__head-icon m--hide">
                                        <i class="la la-gear"></i>
                                    </span>
                                    <h3 class="m-portlet__head-text">
                                        Cadastro de Produto
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
                            <div class="m-portlet__body">
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-6 col-xl-6 col-md-12">
                                        <label>
                                            Nome do produto
                                        </label>
                                        <input type="text" v-model="produto.produto" class="form-control m-input" placeholder="Arroz">
                                        <span class="m-form__help">
                                            Digite o nome do produto
                                        </span>
                                    </div>
                                    <div class="col-lg-6 col-xl-6 col-md-12">
                                        <label>
                                            Unidade de medida
                                        </label>
                                        <select id="exampleSelect1" v-model="produto.unidade_medida_id" class="form-control m-input m-input--square ">
                                            <option :value="''">-- Selecione a uniade de medida --</option>
                                            <option v-for="unidade_medida in unidade_medidas" :value="unidade_medida.unidade_medida_id">
                                                {{unidade_medida.nome}} - {{unidade_medida.sigla}}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
                                            Selecione a unidade de medida
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="m-portlet__foot m-portlet__foot--fit">
                                <div class="m-form__actions m-form__actions">
                                    <button type="button" @click="salvar()" class="btn btn-primary">
                                        Salvar
                                    </button>
                                    <button type="reset" class="btn btn-secondary">
                                        Cancelar
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props : ['dados'],
        name: 'edit-produto',
        data () {
            return {
                loading : false,
                urlBase: '',
                titulo: 'Editar Produto',
                btn: {
                    action  : '',
                    icon    : '',
                },
                formRequest : '',
                form_errors: {},
                unidade_medidas : [],
                produto : {
                    produto_id          : '',
                    produto             : '',
                    unidade_medida_id   : '',
                    unidade_venda       : '',
                },
            }
        },
        methods : {
            salvar : function() {
                self = this;

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/produtos/salvar', self.produto).then((response) => {
                            self.retorno = response.body;
                            self.formRequest = {};
                        }, response => {
                            var form = response.body;
                            self.formRequest = form.errors;
                            self.retorno = 0;
                        });
                    },
                    allowOutsideClick: () => !Swal.isLoading()
                }).then((result) => {
                    self.loading = false;
                    
                    if (self.retorno == 0) {
                        self.form_errors = self.mountErrors(self.formRequest);
                        var msg = self.formErros(self.formRequest);

                        return Swal({
                            type: 'error',
                            title: 'Há campos em brancos!',
                            html: msg,
                        });
                    }

                    return Swal({
                        type: self.retorno.status,
                        title: self.retorno.msg,
                    });
                }).catch(Swal.noop)
            },
            getUnidadeMedidas : function() {
                self = this;
                self.loading = true;
                var url = urlBase+'/pnae/unidades-de-medidas/recuperar-todos';

                self.$http.get(url).then((response) => {
                    self.unidade_medidas = response.body;
                    self.loading = false;
                }, response => {
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            checkEdit : function() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.produto.produto_id          = dados.produto_id;
                    this.produto.produto             = dados.produto;
                    this.produto.unidade_medida_id   = dados.unidade_medida_id;
                    this.produto.unidade_venda       = dados.unidade_venda;

                    this.titulo = 'Editar Produto';
                }
            },
        },
        mounted () {
            this.getUnidadeMedidas();
            this.checkEdit();
        },
    };
</script>

<style scoped>
</style>