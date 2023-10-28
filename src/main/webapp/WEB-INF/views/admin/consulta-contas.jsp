<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Projeto Contas - Consulta de Contas</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- DataTable CSS -->
<link href="//cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css" rel="stylesheet"/>
<!-- Folha de estilos CSS -->
<link href="../resources/style.css" rel="stylesheet"/>
</head>
<body>
	<!-- menu navbar -->
	<jsp:include page="/WEB-INF/views/admin/components/navbar.jsp"></jsp:include>
	<div class="container mt-3">
	
		<h4>Consulta de Contas</h4>
		<p>Pesquise as contas dentro do período desejado:</p>
		<hr/>
		
		<div class="text-success mb-2">
			<h5>${mensagem_sucesso}</h5>
		</div>
		
		<div class="text-danger mb-2">
			<h5>${mensagem_erro}</h5>
		</div>
				
		<form id="formConsulta" action="consulta-contas-get" method="get">
		
			<div class="row mb-2">
				<div class="col-md-2">
					<label>Data de início:</label>
					<input type="date"
						id="dataMin" name="dataMin" value="${dataMin}"
						class="form-control"/>
				</div>
				<div class="col-md-2">
					<label>Data de fim:</label>
					<input type="date"
						id="dataFim" name="dataFim" value="${dataFim}"
						class="form-control"/>
				</div>
				<div class="col-md-8">
					<input type="submit" class="btn btn-primary mt-4" value="Pesquisar Contas"/>
				</div>
			</div>
		
		</form>
		
		<c:if test="${contas.size() == 0}">
			<div class="alert alert-warning mt-3">
				<strong>Nenhum registro foi encontrado.</strong>
			</div>
		</c:if>
		
		<c:if test="${contas.size() > 0}">
			
			<div class="table-responsive">
			<table id="tabela-contas" class="table table-sm table-hover">
				<thead>
					<tr>
						<th>Data</th>
						<th>Valor</th>
						<th>Tipo</th>
						<th>Nome da Conta</th>
						<th>Descrição</th>
						<th>Operações</th>
					</tr>
				</thead>
				<tbody>
				
					<c:forEach items="${contas}" var="conta">
						
						<tr>
							<td>
								<fmt:formatDate value="${conta.data}" pattern="dd/MM/yyyy"/>
							</td>
							<td>
								<fmt:formatNumber value="${conta.valor}" type="currency" currencySymbol="R$"/>
							</td>
							<td>
								<c:choose>
								<c:when test="${conta.tipo == 1}">
								<span class="badge bg-success">RECEBER</span>
								</c:when>
								<c:otherwise>
								<span class="badge bg-danger">PAGAR</span>
								</c:otherwise>
								</c:choose>								
							</td>
							<td>${conta.nome}</td>
							<td>${conta.descricao}</td>
							<td>
								<a href="/projeto_contas/admin/edicao-contas?id=${conta.idConta}"
									class="btn btn-sm btn-outline-primary me-2">
									Editar
								</a>
								<a href="/projeto_contas/admin/excluir-conta?id=${conta.idConta}&dataMin=${dataMin}&dataFim=${dataFim}"
									onclick="return confirm('Deseja excluir o registro ${conta.nome}?')"
									class="btn btn-sm btn-outline-danger">
									Excluir
								</a>
							</td>
						</tr>
						
					</c:forEach>				
				</tbody>
			</table>
			</div>
			
		</c:if>	
		
	</div>
	<!-- Bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- JQuery -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<!-- JQuery DataTables -->
	<script src="//cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
	
	<!-- JQuery Validate JS -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/additional-methods.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/localization/messages_pt_BR.min.js"></script>
		
	<!-- Arquivo JS -->
	<script src="../resources/js/consulta-contas.js"></script>
	
</body>
</html>

