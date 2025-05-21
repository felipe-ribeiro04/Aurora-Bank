<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Cadastro de Usuário</title>
</head>
<body>
<%
    String nome_login = request.getParameter("nome_login");
    String sobrenome_login = request.getParameter("sobrenome_login");
    String cpf = request.getParameter("cpf");
    String telefone = request.getParameter("telefone");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    Connection conecta = null;
    PreparedStatement st = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/aurora_pay", "root", "teste");

        String sql = "INSERT INTO usuario (cpf, nome, sobrenome, telefone, email, senha) VALUES (?, ?, ?, ?, ?, ?)";
        st = conecta.prepareStatement(sql);
        st.setString(1, cpf);
        st.setString(2, nome_login);
        st.setString(3, sobrenome_login);
        st.setString(4, telefone);
        st.setString(5, email);
        st.setString(6, senha);

        int linhasAfetadas = st.executeUpdate();

        if (linhasAfetadas > 0) {
            out.println("Usuário cadastrado com sucesso!");
        } else {
            out.println("Erro ao cadastrar o usuário.");
        }
    } catch (Exception e) {
        out.println("<p>Erro: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try {
            if (st != null) st.close();
            if (conecta != null) conecta.close();
        } catch (SQLException ex) {
            out.println("<p>Erro ao fechar a conexão.</p>");
        }
    }
%>
</body>
</html>
