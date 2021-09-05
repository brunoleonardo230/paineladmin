<template>
    <div id="form-entidade">
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
                                        {{ titulo }}
                                    </h3>
                                </div>
                            </div>
                        </div>
                        <form class="m-form m-form--fit">
                            <div class="m-portlet__body">
                                <div class="m-form__section m-form__section--first">
                                    <div class="m-form__heading">
                                        <h3 class="m-form__heading-title">
                                            1. Informações Gerais:
                                        </h3>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-6">
                                            <label class="">
                                                Nome:
                                            </label>
                                            <input type="text" class="form-control m-input" v-model="entidade.nome" placeholder="Digite o nome">
                                            <span class="m-form__help">
                                                Por favor, digite o nome
                                            </span>
                                        </div>
                                        <div class="col-lg-6">
                                            <label class="">
                                                CNPJ:
                                            </label>
                                            <input type="text" v-mask="['##.###.###/####-##']" class="form-control m-input" v-model="entidade.cnpj" placeholder="Digite o CPF/CNPJ">
                                            <span class="m-form__help">
                                                Por favor, digite o CNPJ
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <endereco v-model="entidade.endereco" titulo="2. Endereço"></endereco>

                                <br><br>
                                
                                <contatos v-model="entidade.contatos"></contatos>

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
    import Endereco from '../endereco/Endereco.vue'
    import Contatos from '../contato/Contatos.vue'

    export default {
        components: { Endereco, Contatos },
        name: 'form-entidade',
        data () {
            return {
                urlBase: urlBase,
                titulo: 'Cadastro de Entidade',
                formRequest : '',
                form_errors: {},
                entidade: {
                    entidade_id : '',
                    nome : '',
                    cnpj : '',
                    endereco : {},
                    contatos : [],
                },
            }
        },
        methods : {
            salvar : function() {
                self = this;

                Swal({
                    title: this.titulo + '?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/entidades/salvar', self.entidade).then((response) => {
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
            }
        },
    };
</script>

<style scoped>
</style>
