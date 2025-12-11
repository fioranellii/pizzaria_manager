package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Cliente;
import model.Funcionario;
import model.Ingrediente;
import model.Produto;
import model.Pedido;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Arrays;
import logtrack.ExceptionLogTrack;

public class FrontController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) {
            task = "";
        }

        try {
            List<String> cargosGerais = Arrays.asList("Gerente", "Atendente", "Pizzaiolo");
            List<String> cargosVendas = Arrays.asList("Gerente", "Atendente");
            List<String> cargosProducao = Arrays.asList("Gerente", "Pizzaiolo");
            List<String> cargosAdm = Arrays.asList("Gerente");

            boolean accessGranted = true;

            switch (task) {
                case "clientes":
                    accessGranted = checkAccess(request, cargosGerais);
                    if (accessGranted) {
                        doGetClientes(request, response);
                    }
                    break;

                case "produtos":
                case "pedidos":
                    accessGranted = checkAccess(request, cargosVendas);
                    if (accessGranted) {
                        doGetVendas(request, response, task);
                    }
                    break;

                case "funcionarios":
                    accessGranted = checkAccess(request, cargosAdm);
                    if (accessGranted) {
                        doGetFuncionarios(request, response);
                    }
                    break;

                case "ingredientes":
                    accessGranted = checkAccess(request, cargosProducao);
                    if (accessGranted) {
                        doGetIngredientes(request, response);
                    }
                    break;

                case "logout":
                    doGetLogout(request, response);
                    return;

                default:
                    doDefault(request, response);
                    return;
            }

            if (!accessGranted) {
                response.sendRedirect(request.getContextPath() + "/home/app/acesso_negado.jsp");
            }

        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) {
            task = "";
        }

        try {
            switch (task) {

                case "clientes":
                    doPostClientes(request, response);
                    break;

                case "produtos":
                    doPostProdutos(request, response);
                    break;

                case "funcionarios":
                    doPostFuncionarios(request, response);
                    break;

                case "ingredientes":
                    doPostIngredientes(request, response);
                    break;

                case "pedidos":
                    doPostPedidos(request, response);
                    break;

                case "login":
                    doPostLogin(request, response);
                    break;

                default:
                    doDefault(request, response);
            }

        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
        }

    }

    private void doGetClientes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ((action != null) && action.equals("delete")) {
            int id = Integer.valueOf(request.getParameter("id"));
            Cliente cli = new Cliente();
            cli.setIdCliente(id);
            cli.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/geral/clientes.jsp");
    }

    private void doGetFuncionarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ((action != null) && action.equals("delete")) {
            int id = Integer.valueOf(request.getParameter("id"));
            Funcionario func = new Funcionario();
            func.setIdFuncionario(id);
            func.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/adm/funcionarios.jsp");
    }

    private void doGetIngredientes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        if ((action != null) && action.equals("delete")) {
            int id = Integer.valueOf(request.getParameter("id"));
            Ingrediente ing = new Ingrediente();
            ing.setIdIngrediente(id);
            ing.delete();
        }
        response.sendRedirect(request.getContextPath() + "/home/app/producao/ingredientes.jsp");
    }

    private void doGetVendas(HttpServletRequest request, HttpServletResponse response, String task) throws Exception {
        String action = request.getParameter("action");

        if ((action != null) && action.equals("delete")) {
            int id = Integer.valueOf(request.getParameter("id"));

            if (task.equals("produtos")) {
                Produto prod = new Produto();
                prod.setIdProduto(id);
                prod.delete();
            } else if (task.equals("pedidos")) {
                Pedido ped = new Pedido();
                ped.setIdPedido(id);
                ped.delete();
            }
        }

        response.sendRedirect(request.getContextPath() + "/home/app/vendas/" + task + ".jsp");
    }

    private void doGetLogout(HttpServletRequest request, HttpServletResponse response) throws Exception {
        HttpSession sessao = request.getSession(false);
        if (sessao != null) {
            sessao.invalidate();
        }
        response.sendRedirect("home/login.jsp");
    }

    private void doPostClientes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        int id = Integer.valueOf(request.getParameter("id_cliente"));
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String telefone = request.getParameter("telefone");
        String endereco = request.getParameter("endereco");
        Cliente cli = new Cliente();
        cli.setIdCliente(id);

        if (action.equals("update")) {
            cli.load();
        }
        cli.setNome(nome);
        cli.setEmail(email);
        cli.setTelefone(telefone);
        cli.setEndereco(endereco);
        cli.save();
        response.sendRedirect(request.getContextPath() + "/home/app/geral/clientes.jsp");
    }

    private void doPostProdutos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        int id = Integer.valueOf(request.getParameter("id_produto"));
        String nome = request.getParameter("nome");
        String precoStr = request.getParameter("preco");
        String categoria = request.getParameter("categoria");
        Produto prod = new Produto();
        prod.setIdProduto(id);

        if (action.equals("update")) {
            prod.load();
        }
        prod.setNome(nome);
        prod.setPreco(new BigDecimal(precoStr));
        prod.setCategoria(categoria);
        prod.save();
        response.sendRedirect(request.getContextPath() + "/home/app/vendas/produtos.jsp");
    }

    private void doPostFuncionarios(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        int id = Integer.valueOf(request.getParameter("id_funcionario"));
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf");
        String senha = request.getParameter("senha");
        String cargo = request.getParameter("cargo");
        Funcionario func = new Funcionario();
        func.setIdFuncionario(id);

        String mensagemErro = null;

        if (action.equals("update")) {
            func.load();
        } else if (action.equals("create")) {
            if (func.load()) {
                mensagemErro = "Erro: O ID do Funcionário (" + id + ") já está cadastrado no sistema. Por favor, escolha outro ID.";
            }
        }
        if (mensagemErro != null) {
            request.setAttribute("msg_erro", mensagemErro);
            request.setAttribute("func_dados", func);

            request.getRequestDispatcher("/home/app/adm/funcionario_form.jsp").forward(request, response);
            return;
        }
        func.setNome(nome);
        func.setCpf(cpf);
        func.setCargo(cargo);

        if (action.equals("create") || (senha != null && !senha.trim().isEmpty())) {
            func.setSenha(senha);
        }

        func.save();
        response.sendRedirect(request.getContextPath() + "/home/app/adm/funcionarios.jsp");
    }

    private void doPostIngredientes(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String action = request.getParameter("action");
        int id = Integer.valueOf(request.getParameter("id_ingrediente"));
        String nome = request.getParameter("nome");
        int quantidade = Integer.valueOf(request.getParameter("quantidade_estoque"));
        String unidade = request.getParameter("unidade_medida");
        Ingrediente ing = new Ingrediente();
        ing.setIdIngrediente(id);

        if (action.equals("update")) {
            ing.load();
        }
        ing.setNome(nome);
        ing.setQuantidadeEstoque(quantidade);
        ing.setUnidadeMedida(unidade);
        ing.save();
        response.sendRedirect(request.getContextPath() + "/home/app/producao/ingredientes.jsp");
    }

    private void doPostPedidos(HttpServletRequest request, HttpServletResponse response) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        String action = request.getParameter("action");
        int id = Integer.valueOf(request.getParameter("id_pedido"));

        int idCliente = Integer.valueOf(request.getParameter("id_cliente"));
        int idFuncionario = Integer.valueOf(request.getParameter("id_funcionario"));

        String dtHoraStr = request.getParameter("dt_hora");
        String valorTotalStr = request.getParameter("valor_total");
        String status = request.getParameter("status");

        Cliente cli = new Cliente();
        cli.setIdCliente(idCliente);
        boolean clienteExiste = cli.load();

        Funcionario func = new Funcionario();
        func.setIdFuncionario(idFuncionario);
        boolean funcionarioExiste = func.load();

        String mensagemErro = null;

        if (!clienteExiste) {
            mensagemErro = "Erro: O ID do Cliente (" + idCliente + ") não foi encontrado no sistema.";
        } else if (!funcionarioExiste) {
            mensagemErro = "Erro: O ID do Funcionário (" + idFuncionario + ") não foi encontrado no sistema.";
        }

        if (mensagemErro != null) {
            request.setAttribute("msg_erro", mensagemErro);

            request.getRequestDispatcher("/home/app/vendas/pedido_form.jsp").forward(request, response);
            return;
        }

        Pedido ped = new Pedido();
        ped.setIdPedido(id);

        if (action.equals("update")) {
            ped.load();
        }

        Date dtHora = sdf.parse(dtHoraStr);
        BigDecimal valorTotal = new BigDecimal(valorTotalStr);

        ped.setIdCliente(idCliente);
        ped.setIdFuncionario(idFuncionario);

        ped.setDtHora(dtHora);
        ped.setValorTotal(valorTotal);
        ped.setStatus(status);
        ped.save();

        response.sendRedirect(request.getContextPath() + "/home/app/vendas/pedidos.jsp");
    }

    private boolean checkAccess(HttpServletRequest request, List<String> allowedRoles) {
        HttpSession sessao = request.getSession(false);

        if (sessao == null || sessao.getAttribute("cargo") == null) {
            return false;
        }

        String userCargo = (String) sessao.getAttribute("cargo");

        return allowedRoles.contains(userCargo);
    }

    private void doPostLogin(HttpServletRequest request, HttpServletResponse response) throws Exception {

        int id = -1;
        String senha = request.getParameter("senha");

        try {
            id = Integer.valueOf(request.getParameter("id"));
        } catch (NumberFormatException ex) {
            request.setAttribute("msg", "ID inválido.");
            request.getRequestDispatcher("/home/login.jsp").forward(request, response);
            return;
        }

        Funcionario func = new Funcionario();
        func.setIdFuncionario(id);

        boolean status = func.load();

        String senhaBD = func.getSenha();
        func.setSenha(senha);
        String senhaTentativa = func.getSenha();

        if ((status == true) && (senhaBD.equals(senhaTentativa))) {

            HttpSession sessao = request.getSession(false);
            if (sessao != null) {
                sessao.invalidate();
            }

            sessao = request.getSession(true);

            sessao.setAttribute("id_funcionario", func.getIdFuncionario());
            sessao.setAttribute("usuario_nome", func.getNome());
            sessao.setAttribute("cargo", func.getCargo());

            sessao.setMaxInactiveInterval(60 * 60 * 48);

            Cookie cookie = new Cookie("id", String.valueOf(id));
            cookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cookie);

            response.sendRedirect(request.getContextPath() + "/home/app/menu.jsp");

        } else {

            request.setAttribute("msg", "ID e/ou senha incorreto(s).");
            request.getRequestDispatcher("/home/login.jsp").forward(request, response);

        }
    }

    private void doDefault(HttpServletRequest request, HttpServletResponse response) throws Exception {

        response.sendRedirect("home/login.jsp");

    }

}
