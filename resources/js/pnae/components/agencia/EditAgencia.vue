<template>
    <div id="edit-agencia">
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
                        <form class="m-form m-form--fit m-form--label-align-right m-form--group-seperator-dashed">
                            <div class="m-portlet__body">
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-6 col-xl-6 col-md-12">
                                        <label>
                                            Banco
                                        </label>
                                        <select class="form-control m-input" id="banco_id" v-model="agencia.banco_id" name="banco_id">
                                            <option value="" selected>Selecione um Banco</option>
                                            <option v-for="banco in bancos" :value="banco.banco_id">
                                                {{ banco.nome }}
                                            </option>
                                        </select>
                                        <span class="m-form__help">
                                            Por favor, selecione o banco
                                        </span>
                                    </div>
                                    <div class="col-lg-4 col-xl-4 col-md-12 form-group">
                                        <label>
                                            Número da Agência
                                        </label>
                                        <input type="number" v-model="agencia.numero" @input="calcularDigitoVerificador" class="form-control m-input" placeholder="Digite o número da agência">
                                        <span class="m-form__help">
                                            Por favor, digite o número
                                        </span>
                                    </div>
                                    <div class="col-lg-2 col-xl-2 col-md-12 form-group">
                                        <label>
                                            Dígito Verificador
                                        </label>
                                        <input type="text" v-mask="'####'" v-model="agencia.digito" class="form-control m-input" placeholder="Dígito Verificador" disabled="">
                                        <span class="m-form__help">
                                            Dígito Verificador
                                        </span>
                                    </div>
                                </div>
                                <div class="form-group m-form__group row">
                                    <div class="col-lg-12 col-xl-12 col-md-12">
                                        <label>
                                            Descrição
                                        </label>
                                        <input type="text" v-model="agencia.nome" class="form-control m-input" placeholder="Ex: Cidade, Bairro da Agência">
                                        <span class="m-form__help">
                                            Por favor, digite o local da descrição
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
        name: 'edit-agencia',
        data () {
            return {
                urlBase : '',
                titulo : 'Editar Agência',
                btn : {
                    action : '',
                    icon : '',
                },
                formRequest : '',
                form_errors : {},
                agencia : {
                    agencia_id : '',
                    nome : '',
                    numero : '',
                    banco_id : '',
                    digito : '',
                },
                bancos : [],
            }
        },
        methods : {
            salvar() {
                self = this;

                Swal({
                    title: this.titulo + '?',
                    type: 'question',
                    showCancelButton: true,
                    showLoaderOnConfirm: true,
                    preConfirm: () => {
                        return self.$http.post(urlBase + '/pnae/agencias/salvar', self.agencia).then((response) => {
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
            getBancos() {
                self = this;
                self.loading = true;
                
                var url = urlBase + '/pnae/bancos/recuperar-todos';
                
                self.$http.get(url).then((response) => {
                    self.bancos = response.body;

                    self.loading = false;
                }, response => {
                    self.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            calcularDigitoVerificador() {
                this.loading = true;

                if (this.agencia.numero != '') {
                    var url = `${urlBase}/pnae/agencias/calcular-digito/${this.agencia.numero}`;
                
                    this.$http.get(url).then((response) => {
                        this.agencia.digito = response.body;

                        this.loading = false;
                    }, response => {
                        this.loading = false;
                        
                        return Swal({
                            type: 'error',
                            title: 'Ocorreu um erro. Tente atualizar a página!',
                        });
                    });
                } else {
                    this.agencia.digito = '';

                    this.loading = false;
                }
            },
            checkEdit() {
                var dados = null;

                if (this.dados) {
                    dados = JSON.parse(this.dados);

                    this.agencia.agencia_id = dados.agencia_id;
                    this.agencia.banco_id   = dados.banco_id;
                    this.agencia.nome       = dados.nome;
                    this.agencia.numero     = dados.numero;
                    this.agencia.digito     = this.calcularDigitoVerificador();
                    
                    this.titulo = 'Editar Agência';

                    this.btn.action = "Salvar";
                    this.btn.icon   = "fa fa-check";
                }
            },
        },
        mounted () {
            this.checkEdit();
            this.getBancos();
        },
    };
</script>

<style scoped>
</style>
