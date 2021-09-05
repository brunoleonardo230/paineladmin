<template>
    <div id="edit-unidade-operacional">
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
                                        Cadastro de Unidade de Operacional
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
                            <div class="m-portlet__body">
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-8 col-xl-8 col-md-12">
                                        <label>
                                            Entidade Executora
                                        </label>
                                        <select class="form-control m-input" id="entidade_id" v-model="unidade_operacional.entidade_id" name="entidade_id">
                                            <option value="" selected>Selecione uma entidade executora</option>
                                            <option v-for="entidade in entidades" :value="entidade.entidade_id">
                                                {{ entidade.nome }}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
                                            Por favor, selecione a entidade executora
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-8 col-xl-8 col-md-12">
                                        <label>
                                            Unidade de Operacional
                                        </label>
                                        <input type="text" v-model="unidade_operacional.nome" class="form-control m-input" placeholder="Digite o nome">
                                        <span class="m-form__help">
                                            Digite o nome
                                        </span>
                                    </div>
                                    <div class="col-lg-4 col-xl-4 col-md-12">
                                        <label>
                                            Sigla
                                        </label>
                                        <input type="text" v-model="unidade_operacional.sigla" class="form-control m-input" placeholder="Digite o sigla">
                                        <span class="m-form__help">
                                            Digite a sigla
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="m-portlet__foot m-portlet__foot--fit">
                                <div class="m-form__actions m-form__actions">
                                    <button type="button" @click="salvarUnidade()" class="btn btn-primary">
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
        name: 'edit-unidade-operacional',
        data () {
            return {
                urlBase: '',
                titulo: 'Cadastrar Unidade de Operacional',
                formRequest : '',
                form_errors: {},
                unidade_operacional : {
                    unidade_operacional_id : '',
                    nome : '',
                    sigla : '',
                    entidade_id : '',
                },
                entidades : [],
            }
        },
        methods : {
            salvarUnidade : function() {
                self = this;

                Swal({
                    title: this.titulo+'?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/unidades-operacionais/salvar', self.unidade_operacional).then((response) => {
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
            getEntidades() {
                self = this;
                self.loading = true;
                
                var url = urlBase + '/pnae/entidades/recuperar-todos';
                
                self.$http.get(url).then((response) => {
                    self.entidades = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;
                    
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

                    this.unidade_operacional.unidade_operacional_id   = dados.unidade_operacional_id;
                    this.unidade_operacional.nome                     = dados.nome;
                    this.unidade_operacional.sigla                    = dados.sigla;
                    this.unidade_operacional.entidade_id              = dados.entidade_id;

                    this.titulo = 'Editar Unidade de Operacional';
                }
            },
        },
        mounted () {
            this.checkEdit();
            this.getEntidades();
        },
    };
</script>

<style scoped>
</style>
