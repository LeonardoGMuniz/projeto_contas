$(document).ready(function(){
	
	//validação do formulário
	$("#formEdicao").validate({
		rules: {
			"nome": {
				required: true,
				minlength: 8,
				maxlength: 100
			},
			"data": {
				required: true
			},
			"valor" : {
				required: true,
				min: 1
			},
			"tipo" : {
				required: true
			},
			"descricao" : {
				required: true,
				minlength: 8,
				maxlength: 500
			}
		},
	});	
})



