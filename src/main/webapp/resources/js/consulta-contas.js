$(document).ready(function(){
	
	//criando o datatable
	$("#tabela-contas").DataTable({		
		language: {
			url: '//cdn.datatables.net/plug-ins/1.13.6/i18n/pt-BR.json'
		}		
	});
	
	//aplicando as validações no formulário
	$("#formConsulta").validate({
		rules: {
			'dataMin' : {
				required: true
			},
			'dataFim' : {
				required: true
			}
		}
	});
	
});



