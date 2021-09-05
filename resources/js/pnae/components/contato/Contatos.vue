<template>
    <div id="contatos">
        <div class="m-form__seperator m-form__seperator--dashed"></div>
        <div class="m-form__section m-form__section">
            <div class="m-form__heading">
                <h3 class="m-form__heading-title">
                    4. Contato:
                </h3>
            </div>
            <div class="form-group m-form__group row">
                <div class="col-lg-5">
                    <label class="">
                        Tipo Contato:
                    </label>
                    <select class="form-control m-input" id="tipo_contato" v-model="contato.tipo_contato_id" name="tipo_contato" @change="atualizarTipoContato()">
                        <option value="" selected>Selecione</option>
                        <template v-for="tipo_contato in tipos_contato">
                            <option :value="tipo_contato.tipo_contato_id"> {{ tipo_contato.nome }} </option>
                        </template>
                    </select>
                    <span class="m-form__help">
                        Por favor, selecione o tipo de contado
                    </span>
                </div>
                <div class="col-lg-5">
                    <label class="">
                        Contato:
                    </label>
                        <input type="text" class="form-control m-input" v-model="contato.contato" :placeholder="tipo_contato_aux.nome">
                    <span class="m-form__help">
                        Por favor, digite o contatos
                    </span>
                </div>
                <div class="col-lg-2 text-center">
                    <label class="">
                        Adicionar
                    </label>
                    <button type="button" title="Adicionar contato" class="btn btn-success" @click="addContato()">
                        <i class="fa fa-plus"></i> Adicionar
                    </button>
                </div>

                <br><br><br><br><br>

                <div class="col-lg-12">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>
                                        Tipo de Contato
                                    </th>
                                    <th>
                                        Contato
                                    </th>
                                    <th class="text-center">
                                        Opções
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-if="contatos.length < 1">
                                    <td colspan="4">
                                        <p class="text-center">
                                            Adicione Contatos!
                                        </p>
                                    </td>
                                </tr>
                                <tr v-else v-for="(contato, index) in contatos">
                                    <td class="align-middle">
                                        {{ contato.tipo_contato.nome }}
                                    </td>
                                    <td class="align-middle">
                                        {{ contato.contato }}
                                    </td>
                                    <td class="text-center">
                                        <button type="button" title="Descartar este contato" @click="descartarContato(index)" class="btn btn-danger m-btn m-btn--icon m-btn--icon-only m-btn--custom m-btn--pill">
                                            <i class="la la-trash"></i>
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
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
                contatos : [],
            	contato: {
                    contato_id : '',
                    tipo_contato_id : '',
                    contato : '',
                    tipo_contato : {},
                },
                tipos_contato: [],
                tipo_contato_aux : {
                    tipo_contato_id   : '',
                    nome              : '',
                },
            }
        },
        methods : {
            addContato() {
                if (this.contato.tipo_contato_id && this.contato.contato) {
                    this.contatos.push({
                        contato_id: this.contato.contato_id,
                        tipo_contato_id: this.contato.tipo_contato_id,
                        contato: this.contato.contato,
                        tipo_contato: this.tipo_contato_aux,
                    });

                    this.contato = {
                        contato_id : '',
                        tipo_contato_id : '',
                        contato : '',
                        tipo_contato: {},
                    };

                    this.tipo_contato_aux = {
                        tipo_contato_id : '',
                        nome : '',
                    };

                    this.emitirContatos();
                }
            },
            descartarContato(index) {
                this.contatos.splice(index, 1);

                this.emitirContatos();
            },
            atualizarTipoContato() {
                this.tipo_contato_aux = this.tipos_contato.find(obj => obj.tipo_contato_id === this.contato.tipo_contato_id);
            },
            getTiposContatos() {
                this.loading = true;
                
                var url = urlBase + '/pnae/tipos-de-contato/recuperar-todos';
                
                this.$http.get(url).then((response) => {
                    this.tipos_contato = response.body;

                    this.loading = false;
                }, response => {
                    this.loading = false;
                    
                    return Swal({
                        type: 'error',
                        title: 'Ocorreu um erro. Tente atualizar a página!',
                    });
                });
            },
            emitirContatos() {
              this.$emit('input',  this.contatos );
            },
            checkEdit() {
                var dados = null;

                if (this.dados) {
                    dados = this.dados;
                    
                    this.contatos = this.dados;
                }
            }
        },
        mounted() {
            this.checkEdit();
            this.getTiposContatos();
        }
    };
</script>

<style scoped>
    .box-contato {
        padding-bottom: 10px;
    }

    .btn-descartar {
        height: 60px;
        padding-top: 25px;
    }

    .btn-descartar button {
        border: none;
        background-color: #f55d5d;
        color: #ffffff;
    }

    .btn-descartar button:hover {
        background-color: #f31818;
    }

    .div-btn-add-contato {
    	padding-top: 25px;
    }
</style>
