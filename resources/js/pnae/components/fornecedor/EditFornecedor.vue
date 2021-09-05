<template>
    <div id="form-fornecedor">
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
                                            1. Informações Pessoais:
                                        </h3>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-6">
                                            <label>
                                                Tipo Pessoa:
                                            </label>
                                            <div class="m-radio-inline">
                                                <label class="m-radio m-radio--solid">
                                                    <input type="radio" v-model="fornecedor.tipo_pessoa" value="PF">
                                                    Pessoa Física
                                                    <span></span>
                                                </label>
                                                <label class="m-radio m-radio--solid">
                                                    <input type="radio" v-model="fornecedor.tipo_pessoa" value="PJ">
                                                    Pessoa Jurídica
                                                    <span></span>
                                                </label>
                                            </div>
                                            <span class="m-form__help">
                                                Por favor, selecione um tipo de pessoa
                                            </span>
                                        </div>
                                        <div class="col-lg-6">
                                            <label class="">
                                                CPF/CNPJ:
                                            </label>
                                            <input type="text" v-mask="['###.###.###-##', '##.###.###/####-##']" class="form-control m-input" v-model="fornecedor.cpf_cnpj" placeholder="Digite o CPF/CNPJ">
                                            <span class="m-form__help">
                                                Por favor, digite o CPF/CNPJ
                                            </span>
                                        </div>
                                    </div>
                                    <div class="form-group m-form__group row">
                                        <div class="col-lg-6">
                                            <label>
                                                Razão Social:
                                            </label>
                                            <input type="text" class="form-control m-input" v-model="fornecedor.nome" placeholder="Digite a Razão Social">
                                            <span class="m-form__help">
                                                Por favor, digite a Razão Social
                                            </span>
                                        </div>
                                        <div class="col-lg-6">
                                            <label>
                                                DAP:
                                            </label>
                                            <input type="text" class="form-control m-input" v-model="fornecedor.dap_fisica" placeholder="Digite a DAP">
                                            <span class="m-form__help">
                                                Por favor, digite a DAP
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <endereco v-model="fornecedor.endereco" :dados="fornecedor.endereco" titulo="2. Endereço"></endereco>

                                <br><br>

                                <endereco v-model="fornecedor.endereco_produtivo" :dados="fornecedor.endereco_produtivo" titulo="3. Endereço Produtivo"></endereco>

                                <br><br>
                                
                                <contatos v-model="fornecedor.contatos" :dados="fornecedor.contatos"></contatos>

                                <br><br>

                                <conta v-model="fornecedor.conta" :dados="fornecedor.conta"></conta>

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
    import Conta from '../conta/Conta.vue'
    import Endereco from '../endereco/Endereco.vue'
    import Contatos from '../contato/Contatos.vue'

    export default {
    	props : ['dados'],
        components: { Endereco, Contatos, Conta  },
        name: 'edit-fornecedor',
        data () {
            return {
                urlBase: urlBase,
                titulo: 'Editar Fornecedor',
                formRequest : '',
                form_errors: {},
                fornecedor: {
                    fornecedor_id : '',
                    nome : '',
                    cpf_cnpj : '',
                    conta : {},
                    endereco : {},
                    endereco_produtivo : {},
                    contatos : [],
                    dap_fisica : '',
                    tipo_pessoa : '',
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
                        return self.$http.post(urlBase + '/pnae/fornecedores/salvar', self.fornecedor).then((response) => {
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
            },
            checkEdit : function() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.fornecedor.fornecedor_id       = dados.fornecedor_id;
                    this.fornecedor.nome                = dados.nome;
                    this.fornecedor.cpf_cnpj            = dados.cpf_cnpj;
                    this.fornecedor.dap_fisica          = dados.dap_fisica;
                    this.fornecedor.tipo_pessoa         = dados.tipo_pessoa;
                    this.fornecedor.endereco            = dados.endereco;
                    this.fornecedor.endereco_produtivo  = dados.enderecos_produtivos[0];
                    this.fornecedor.contatos            = dados.contatos;
                    this.fornecedor.conta               = dados.contas[0];
                }
            },
        },
        created () {
            this.checkEdit();
        },
    };
</script>

<style scoped>
</style>
