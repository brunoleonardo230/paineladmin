<template>
    <div id="endereco">
        <div class="m-form__seperator m-form__seperator--dashed"></div>
        <div class="m-form__section m-form__section">
            <div class="m-form__heading">
                <h3 class="m-form__heading-title">
                    {{ titulo }}
                </h3>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label class="">
                        CEP:
                    </label>
                    <input type="text" v-mask="'#####-###'" class="form-control m-input" v-model="endereco.cep" @input="emitirEndereco" placeholder="Digite o CEP">
                    <span class="m-form__help">
                        Por favor, digite o CEP
                    </span>
                </div>
                <div class="col-lg-6">
                    <label class="">
                        Estado:
                    </label>
                    <select class="form-control m-input" v-model="endereco.estado_id" @change="getCidades" @input="emitirEndereco">
                        <option value="0" selected>{{ estado.msg }}</option>
                        <template v-for="estado in estados">
                            <option :value="estado.estado_id"> {{ estado.estado }} </option>
                        </template>
                    </select>
                    <span class="m-form__help">
                        Por favor, selecione o estado
                    </span>
                </div>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label class="">
                        Cidade:
                    </label>
                    <select class="form-control m-input" v-model="endereco.cidade_id" @input="emitirEndereco">
                        <option value="0">{{ cidade.msg }}</option>
                        <template v-for="cidade in cidades">
                            <option :value="cidade.cidade_id"> {{ cidade.cidade }} </option>
                        </template>
                    </select>
                    <span class="m-form__help">
                        Por favor, selecione a cidade
                    </span>
                </div>
                <div class="col-lg-6">
                    <label class="">
                        Rua:
                    </label>
                    <input type="text" class="form-control m-input" v-model="endereco.rua" @input="emitirEndereco" placeholder="Digite a rua">
                    <span class="m-form__help">
                        Por favor, digite a rua
                    </span>
                </div>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label class="">
                        Bairro:
                    </label>
                    <input type="text" class="form-control m-input" v-model="endereco.bairro" @input="emitirEndereco" placeholder="Digite o bairro">
                    <span class="m-form__help">
                        Por favor, digite o bairro
                    </span>
                </div>
                <div class="col-lg-6">
                    <label class="">
                        Número:
                    </label>
                    <input type="text" class="form-control m-input" v-model="endereco.numero" @input="emitirEndereco" placeholder="Digite o número">
                    <span class="m-form__help">
                        Por favor, digite o número
                    </span>
                </div>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-6">
                    <label class="">
                        Complemento:
                    </label>
                    <input type="text" class="form-control m-input" v-model="endereco.complemento" @input="emitirEndereco" placeholder="Digite o complemento">
                    <span class="m-form__help">
                        Por favor, digite o complemento
                    </span>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props : ['dados', 'titulo'],
        data () {
            return {
                endereco: {
                    endereco_id : '',
                    cep : '',
                    estado_id : 0,
                    cidade_id : 0,
                    rua : '',
                    bairro : '',
                    numero : '',
                    complemento : '',
                    zona : ''
                },
                cidade: {
                    msg: '',
                },
                estado: {
                    msg: '',
                },
                estados: [],
                cidades: [],
            }
        },
        methods: {
            emitirEndereco() {
                this.$emit('input', this.endereco);
            },
            getEstados() {
                this.estado.msg = "Carregando..."

                this.loading = true;

                this.$http.get(urlBase + '/pnae/estados/recuperar-todos').then(response => {
                    this.estados = response.data;
                    this.estado.msg = "Selecione um estado";

                    this.loading = false;
                });
            },
            getCidades(dados) {
                this.loading = true;

                if (this.endereco.estado_id == 0) {
                    this.cidade.msg = "Selecione um estado";
                    this.endereco.cidade_id = 0;
                    this.cidades = [];

                    return false;
                }

                this.cidade.msg = "Carregando..."
                this.$http.get(urlBase + '/pnae/cidades/recuperar-por-estado/' + this.endereco.estado_id).then(response => {
                    this.cidades = response.data;
                    this.cidade.msg = "Selecione uma cidade";

                    this.loading = false;
                }, response => {
                    this.endereco.cidade_id = 0;
                    this.cidade.msg = "Erro ao carregar as cidades";

                    this.loading = false;
                });

            },
            checkEdit() {
                var dados = null;

                if (this.dados) {
                    dados = this.dados;

                    this.endereco.endereco_id   = dados.endereco_id;
                    this.endereco.cep           = dados.cep;
                    this.endereco.estado_id     = dados.cidade.estado_id;
                    this.endereco.cidade_id     = dados.cidade_id;
                    this.endereco.rua           = dados.rua;
                    this.endereco.bairro        = dados.bairro;
                    this.endereco.numero        = dados.numero;
                    this.endereco.complemento   = dados.complemento;
                    this.endereco.zona          = dados.zona;
                }
            }
        },
        mounted () {
            this.checkEdit();
            this.getEstados();
            this.getCidades();
        }
    };
</script>

<style scoped>

</style>
