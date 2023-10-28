package br.com.cotiinformatica.controllers;


import java.text.SimpleDateFormat;


import javax.servlet.http.HttpServletRequest;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


import br.com.cotiinformatica.entities.Conta;
import br.com.cotiinformatica.entities.Usuario;
import br.com.cotiinformatica.repositories.ContaRepository;


@Controller
public class EdicaoContasController {


	/*
	 * Método executado quando a página de edição
	 * é aberta pelo navegador
	 */
	@RequestMapping(value = "/admin/edicao-contas")
	public ModelAndView edicaoContas(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("admin/edicao-contas");
		
		try {
			
			//resgatar o ID enviado na URL
			Integer id = Integer.parseInt(request.getParameter("id"));
			
			//capturar o usuário autenticado na sessão
			Usuario usuario = (Usuario) request.getSession().getAttribute("usuario_auth");
			
			//consultando a conta no banco de dados
			ContaRepository contaRepository = new ContaRepository();
			Conta conta = contaRepository.findById(id);
			
			//verificar se a conta foi encontrada e se a conta é do usuário autenticado
			if(conta != null && conta.getIdUsuario() == usuario.getIdUsuario()) {				
				//enviando os dados da conta para a página
				modelAndView.addObject("conta", conta);
			}
			else {
				//redirecionar de volta para a página de consulta
				modelAndView.setViewName("redirect:/admin/consulta-contas");
			}
		}
		catch(Exception e) {
			modelAndView.addObject("mensagem_erro", e.getMessage());
		}
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/admin/edicao-contas-post", method = RequestMethod.POST)
	public ModelAndView edicaoContasPost(HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView("admin/edicao-contas");
		
		try {
			
			Conta conta = new Conta();
			
			conta.setIdConta(Integer.parseInt(request.getParameter("idConta")));
			conta.setNome(request.getParameter("nome"));
			conta.setData(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("data")));
			conta.setValor(Double.parseDouble(request.getParameter("valor")));
			conta.setTipo(Integer.parseInt(request.getParameter("tipo")));
			conta.setDescricao(request.getParameter("descricao"));
			
			ContaRepository contaRepository = new ContaRepository();
			contaRepository.update(conta);
			
			modelAndView.addObject("mensagem_sucesso", "Conta '"+ conta.getNome() +"', atualizada com sucesso!");
			modelAndView.addObject("conta", conta);
		}
		catch(Exception e) {
			modelAndView.addObject("mensagem_erro", e.getMessage());
		}
		
		return modelAndView;
	}	
}

















