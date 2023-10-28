package br.com.cotiinformatica.controllers;
import java.util.Calendar;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import br.com.cotiinformatica.entities.Conta;
import br.com.cotiinformatica.entities.Usuario;
import br.com.cotiinformatica.repositories.ContaRepository;
@Controller
public class DashboardController {
	/*
	 * Método executado quando a página dashboard é aberta
	 */
	@RequestMapping(value = "/admin/dashboard")
	public ModelAndView dashboard(HttpServletRequest request) {
		ModelAndView modelAndView = new ModelAndView("admin/dashboard");
		
		try {
			
			//capturando o usuário autenticado na sessão
			Usuario usuario = (Usuario) request.getSession().getAttribute("usuario_auth");
			
			//capturando o mes e o ano atual
			Calendar calendar = Calendar.getInstance();
			Integer mes = calendar.get(Calendar.MONTH) + 1;
			Integer ano = calendar.get(Calendar.YEAR);
			
			//verificando se foi enviado um mes e ano selecionado na página
			if(request.getParameter("mes") != null && request.getParameter("ano") != null) {
				mes = Integer.parseInt(request.getParameter("mes"));
				ano = Integer.parseInt(request.getParameter("ano"));
			}
			
			//capturando a data do primeiro dia do mês atual
			Calendar primeiroDia = Calendar.getInstance();
			primeiroDia.set(ano, mes - 1, 1);
			
			Calendar ultimoDia = Calendar.getInstance();
			ultimoDia.set(ano, mes - 1, primeiroDia.getActualMaximum(Calendar.DAY_OF_MONTH));
			
			//consultar as contas do usuário no periodo definido
			ContaRepository contaRepository = new ContaRepository();
			List<Conta> contas = contaRepository.findByDatas
					(primeiroDia.getTime(), ultimoDia.getTime(), usuario.getIdUsuario());
			
			//somar contas a pagar e contas a receber
			Double totalContasAReceber = 0.0;
			Double totalContasAPagar = 0.0;
			
			for(Conta conta : contas) {
				if(conta.getTipo() == 1) totalContasAReceber += conta.getValor();
				else if(conta.getTipo() == 2) totalContasAPagar += conta.getValor();
			}
			
			//enviando os dados para a página:
			modelAndView.addObject("mesAtual", mes);
			modelAndView.addObject("anoAtual", ano);			
			
			modelAndView.addObject("totalContasAReceber", totalContasAReceber);
			modelAndView.addObject("totalContasAPagar", totalContasAPagar);
		}
		catch(Exception e) {
			modelAndView.addObject("mensagem_erro", e.getMessage());
		}
		
		return modelAndView;
	}
	
}



