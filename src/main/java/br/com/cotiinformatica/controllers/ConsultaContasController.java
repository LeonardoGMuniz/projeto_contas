package br.com.cotiinformatica.controllers;


import java.text.SimpleDateFormat;
import java.util.List;


import javax.servlet.http.HttpServletRequest;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


import br.com.cotiinformatica.entities.Conta;
import br.com.cotiinformatica.entities.Usuario;
import br.com.cotiinformatica.repositories.ContaRepository;


@Controller
public class ConsultaContasController {


	@RequestMapping(value = "/admin/consulta-contas")
	public ModelAndView consultaContas() {
		ModelAndView modelAndView = new ModelAndView("admin/consulta-contas");
		return modelAndView;
	}
	
	@RequestMapping(value = "/admin/consulta-contas-get", method = RequestMethod.GET)
	public ModelAndView consultaContasGet(HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView("admin/consulta-contas");
		
		try {
			
			//capturar as datas enviadas pelo formulário
			String dataMin = request.getParameter("dataMin");
			String dataFim = request.getParameter("dataFim");
			
			//capturar o usuário autenticado no sistema
			Usuario usuario = (Usuario) request.getSession().getAttribute("usuario_auth");
			
			//fazendo a consulta no banco de dados
			ContaRepository contaRepository = new ContaRepository();
			List<Conta> contas = contaRepository.findByDatas(
					new SimpleDateFormat("yyyy-MM-dd").parse(dataMin),
					new SimpleDateFormat("yyyy-MM-dd").parse(dataFim),
					usuario.getIdUsuario()
					);
			
			//enviando a lista de contas para a página
			modelAndView.addObject("contas", contas);
			
			//enviando as datas selecionadas de volta para a página
			modelAndView.addObject("dataMin", dataMin);
			modelAndView.addObject("dataFim", dataFim);
		}
		catch(Exception e) {
			modelAndView.addObject("mensagem_erro", e.getMessage());
		}
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/admin/excluir-conta", method = RequestMethod.GET)
	public ModelAndView excluirConta(HttpServletRequest request) {
		
		ModelAndView modelAndView = new ModelAndView("admin/consulta-contas");
	
		try {
			
			//capturar os campos enviados pela querystring
			Integer idConta = Integer.parseInt(request.getParameter("id"));
			String dataMin = request.getParameter("dataMin");
			String dataFim = request.getParameter("dataFim");
			
			//capturar o usuário autenticado no sistema
			Usuario usuario = (Usuario) request.getSession().getAttribute("usuario_auth");
			
			//excluindo a conta
			ContaRepository contaRepository = new ContaRepository();
			Conta conta = contaRepository.findById(idConta);
			contaRepository.delete(conta);
			
			//fazendo uma nova consulta no banco de dados
			List<Conta> contas = contaRepository.findByDatas(
					new SimpleDateFormat("yyyy-MM-dd").parse(dataMin),
					new SimpleDateFormat("yyyy-MM-dd").parse(dataFim),
					usuario.getIdUsuario()
					);
			
			//enviando a lista de contas para a página
			modelAndView.addObject("contas", contas);
			
			//enviando as datas selecionadas de volta para a página
			modelAndView.addObject("dataMin", dataMin);
			modelAndView.addObject("dataFim", dataFim);		
			
			modelAndView.addObject("mensagem_sucesso", "Conta excluída com sucesso.");
		}
		catch(Exception e) {
			modelAndView.addObject("mensagem_erro", e.getMessage());
		}
		
		return modelAndView;
	}	
}































