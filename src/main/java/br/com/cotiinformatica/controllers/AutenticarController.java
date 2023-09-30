package br.com.cotiinformatica.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import br.com.cotiinformatica.entities.Usuario;
import br.com.cotiinformatica.helpers.EncryptHelper;
import br.com.cotiinformatica.repositories.UsuarioRepository;

@Controller
public class AutenticarController {

	//definindo a rota para abrir a página no navegador
	@RequestMapping(value = "/") //página raiz (inicial) do projeto
	public ModelAndView autenticar() {
		
		//definindo qual página será aberta no navegador:
		//WEB-INF/views/autenticar.jsp
		ModelAndView modelAndView = new ModelAndView("autenticar");
		return modelAndView;
	}
	
	//mapeamento para que o método possa receber a requisição POST
	//do formulário para o action /autenticar-post
	@RequestMapping(value = "/autenticar-post", method = RequestMethod.POST)
	public ModelAndView autenticarPost(HttpServletRequest request) {
	
		ModelAndView modelAndView = new ModelAndView("autenticar");
		
		try {
			
			//resgatar o email e senha enviados pelo formulário
			String email = request.getParameter("email");
			String senha = EncryptHelper.encryptToSHA1(request.getParameter("senha"));
			
			//buscando o usuário no banco de dados através do email e da senha
			UsuarioRepository usuarioRepository = new UsuarioRepository();
			Usuario usuario = usuarioRepository.find(email, senha);
			
			//verificar se o usuário foi encontrado
			if(usuario != null) {

				//gravar os dados do usuário em sessão
				request.getSession().setAttribute("usuario_auth", usuario);
				
				//redirecionar para a página principal da áres restrita
				modelAndView.setViewName("redirect:/admin/dashboard");
			}
			else {
				throw new Exception("Acesso negado. Usuário inválido.");
			}
		}
		catch(Exception e) {
			modelAndView.addObject("mensagem_erro", e.getMessage());
		}
		
		return modelAndView;
	}
	
	@RequestMapping (value="/logout")
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().removeAttribute("usuario_auth");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/");
		return modelAndView;
		
	}
	
	
}






