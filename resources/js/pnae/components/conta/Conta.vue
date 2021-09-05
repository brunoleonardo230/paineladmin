<template>
    <div id="conta">
        <div class="m-form__seperator m-form__seperator--dashed"></div>
        <div class="m-form__section m-form__section">
            <div class="m-form__heading">
                <h3 class="m-form__heading-title">
                    5. Conta:
                </h3>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label>
                        Tipo Conta:
                    </label>
                    <div class="m-radio-inline">
                        <label class="m-radio m-radio--solid">
                            <input type="radio" v-model="conta.tipo_conta" value="C" @input="emitirConta">
                            Conta Corrente
                            <span></span>
                        </label>
                        <label class="m-radio m-radio--solid">
                            <input type="radio" v-model="conta.tipo_conta" value="P" @input="emitirConta">
                            Conta Poupança
                            <span></span>
                        </label>
                    </div>
                    <span class="m-form__help">
                        Por favor, selecione um tipo de conta
                    </span>
                </div>
                <div class="col-lg-6">
                    <label class="">
                        Agência:
                    </label>
                    <select class="form-control m-input" v-model="conta.agencia_id" @input="emitirConta">
                        <option value="" selected>Selecione uma Agência</option>
                        <template v-for="agencia in agencias">
                            <option :value="agencia.agencia_id"> {{ agencia.numero }} - {{ agencia.nome }} </option>
                        </template>
                    </select>
                    <span class="m-form__help">
                        Por favor, selecione uma agência
                    </span>
                </div>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label class="">
                        Número da Conta:
                    </label>
                    <input type="text" v-mask="'########'" class="form-control m-input" v-model="conta.numero_conta" @input="emitirConta" placeholder="Digite o número da conta">
                    <span class="m-form__help">
                        Por favor, digite o número da conta
                    </span>
                </div>
                <div class="col-lg-6">
                    <label class="">
                        Dígito Verificador:
                    </label>
                    <input type="text" v-mask="'#'" class="form-control m-input" v-model="conta.digito_verificador" @input="emitirConta" placeholder="Digite o dígito verificador">
                    <span class="m-form__help">
                        Por favor, digite o dígito verificador
                    </span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props : ['dados'],
        data () {
            return {
                conta: {
                    conta_id : '',
                    agencia_id : '',
                    numero_conta : '',
                    digito_verificador: '',
                    tipo_conta : '',
                },
                agencias : [],
            }
        },
        methods : {
            emitirConta() {
                this.$emit('input', this.conta);
            },
            getAgencias() {
                this.loading = true;
                
                var url = urlBase + '/pnae/agencias/recuperar-todos';
                
                this.$http.get(url).then((response) => {
                    this.agencias = response.body;

                    this.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            checkEdit() {
                var dados = null;

                if (this.dados) {
                    dados = this.dados;

                    this.conta.conta_id             = dados.conta_id;
                    this.conta.agencia_id           = dados.agencia_id;
                    this.conta.numero_conta         = dados.numero_conta;
                    this.conta.digito_verificador   = dados.digito_verificador;
                    this.conta.tipo_conta           = dados.tipo_conta;
                }
            }
        },
        mounted () {
            this.checkEdit();
            this.getAgencias();
        },
    };
</script>

<style scoped>
</style>
