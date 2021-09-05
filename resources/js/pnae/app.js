import Vue from 'vue'
import VueResource from 'vue-resource'
import moment from 'moment'
import localization from 'moment/locale/pt-br'
import Mixins from './Mixin.js'
import money from 'v-money'
import VueTheMask from 'vue-the-mask'
import Pagination from 'laravel-vue-pagination'
import Loading from './components/Loading.vue'


Vue.use(Pagination)
Vue.use(money, {precision: 4})
Vue.use(VueTheMask)
Vue.use(VueResource)
Vue.mixin(Mixins)
Vue.use(VueTheMask)
Vue.component('pagination', Pagination)
Vue.component('loading', Loading)

window.moment = moment;

//Home
import Dashboard from './components/Dashboard.vue'

//Auxiliares
import SubHeader from './components/SubHeader.vue'
import Contatos from './components/contato/Contatos.vue'
import Endereco from './components/endereco/Endereco.vue'
import Conta from './components/conta/Conta.vue'

//Componentes de Fornecedor
import FormFornecedor from './components/fornecedor/FormFornecedor.vue'
import ListaFornecedores from './components/fornecedor/ListaFornecedores.vue'
import EditFornecedor from './components/fornecedor/EditFornecedor.vue'

//Componentes de Unidade medida (Configurações)
import FormUnidadeMedida from './components/unidade-medida/FormUnidadeMedida.vue'
import ListaUnidadeMedida from './components/unidade-medida/ListaUnidadeMedida.vue'
import EditUnidadeMedida from './components/unidade-medida/EditUnidadeMedida.vue'

//Componentes de Unidade operacional (Configurações)
import FormUnidadeOperacional from './components/unidade-operacional/FormUnidadeOperacional.vue'
import ListaUnidadeOperacional from './components/unidade-operacional/ListaUnidadeOperacional.vue'
import EditUnidadeOperacional from './components/unidade-operacional/EditUnidadeOperacional.vue'

//Componentes de Unidade medida (Configurações)
import FormTipoContato from './components/tipo-contato/FormTipoContato.vue'
import ListaTipoContato from './components/tipo-contato/ListaTipoContato.vue'
import EditTipoContato from './components/tipo-contato/EditTipoContato.vue'

//Componentes de Unidade medida (Configurações)
import FormEntidade from './components/entidade/FormEntidade.vue'
import ListaEntidade from './components/entidade/ListaEntidade.vue'
import EditEntidade from './components/entidade/EditEntidade.vue'

//Componentes de Representante Legal (Configurações)
import FormRepresentanteLegal from './components/representante-legal/FormRepresentanteLegal.vue'
import ListaRepresentanteLegal from './components/representante-legal/ListaRepresentanteLegal.vue'
import EditRepresentanteLegal from './components/representante-legal/EditRepresentanteLegal.vue'

//Componentes de Técnico (Configurações)
import FormTecnico from './components/tecnico/FormTecnico.vue'
import ListaTecnicos from './components/tecnico/ListaTecnicos.vue'
import FormEditTecnico from './components/tecnico/FormEditTecnico.vue'

//Componentes de Banco (Configurações)
import FormBanco from './components/banco/FormBanco.vue'
import ListaBanco from './components/banco/ListaBanco.vue'
import EditBanco from './components/banco/EditBanco.vue'

//Componentes de Agência (Configurações)
import FormAgencia from './components/agencia/FormAgencia.vue'
import ListaAgencia from './components/agencia/ListaAgencia.vue'
import EditAgencia from './components/agencia/EditAgencia.vue'

//Componentes de Usuario (Configurações)
import FormUsuario from './components/usuario/FormUsuario.vue'
import ListaUsuario from './components/usuario/ListaUsuario.vue'
import EditUsuario from './components/usuario/EditUsuario.vue'

//Componentes de Cronograma (Configurações)
import ListaCronograma from './components/cronograma/ListaCronograma.vue'
import FormCronograma from './components/cronograma/FormCronograma.vue'
import EditCronograma from './components/cronograma/EditCronograma.vue'

//Componentes de Produto
import ListaProduto from './components/produto/ListaProduto.vue'
import FormProduto from './components/produto/FormProduto.vue'
import EditProduto from './components/produto/EditProduto.vue'

//Componentes de Levantamento
import ListaLevantamentos from './components/levantamento/ListaLevantamentos.vue'
import FormLevantamento from './components/levantamento/FormLevantamento.vue'
import EditLevantamento from './components/levantamento/EditLevantamento.vue'

//Componentes de Edital
import ListaEditais from './components/edital/ListaEditais.vue'
import FormEdital from './components/edital/FormEdital.vue'
import FormEditEdital from './components/edital/FormEditEdital.vue'

//Componentes de Projeto
import ListaProjeto from './components/projeto/ListaProjeto.vue'
import AjusteProjeto from './components/projeto/AjusteProjeto.vue'
import FormProjeto from './components/projeto/FormProjeto.vue'
import FormEditarProjeto from './components/projeto/FormEditarProjeto.vue'

//Componentes de Consulta
import Consultas from './components/consultas/Consultas.vue'

//Componentes de EntradaMercadoria
import ListaEntradaMercadoria from './components/entrada-mercadoria/ListaEntradaMercadoria.vue'
import FormEntradaMercadoria from './components/entrada-mercadoria/FormEntradaMercadoria.vue'

//Componentes de Relatorios
import RelatorioProdutos from './components/relatorios/projeto/RelatorioProdutos.vue'
import RelatorioEntrada from './components/relatorios/entrada-mercadoria/RelatorioEntrada.vue'

Vue.http.headers.common['X-CSRF-TOKEN'] = document.querySelector('#csrf-token').getAttribute('content');

window.onload = function () {
    var main = new Vue({ // eslint-disable-line no-new
        el: '#app',
        components: {
            SubHeader,
            Dashboard,
            Contatos,
            Endereco,
            Conta,
            FormFornecedor,
            ListaFornecedores,
            EditFornecedor,
            FormUnidadeMedida,
            ListaUnidadeMedida,
            EditUnidadeMedida,
            FormUnidadeOperacional,
            ListaUnidadeOperacional,
            EditUnidadeOperacional,
            FormTipoContato,
            ListaTipoContato,
            EditTipoContato,
            FormEntidade,
            ListaEntidade,
            EditEntidade,
            FormRepresentanteLegal,
            ListaRepresentanteLegal,
            EditRepresentanteLegal,
            FormTecnico,
            ListaTecnicos,
            FormEditTecnico,
            FormUsuario,
            ListaUsuario,
            EditUsuario,
            FormBanco,
            ListaBanco,
            EditBanco,
            FormAgencia,
            ListaAgencia,
            EditAgencia,
            ListaProduto,
            FormProduto,
            EditProduto,
            FormLevantamento,
            ListaLevantamentos,
            EditLevantamento,
            FormEdital,
            ListaEditais,
            FormEditEdital,
            ListaProjeto,
            FormProjeto,
            FormEditarProjeto,
            Consultas,
            ListaEntradaMercadoria,
            FormEntradaMercadoria,
            ListaCronograma,
            FormCronograma,
            EditCronograma,
            RelatorioProdutos,
            RelatorioEntrada,
            AjusteProjeto,
        },
    });
}
