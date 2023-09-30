package br.com.cotiinformatica.controllers;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class EdicaoContasController {
	@RequestMapping(value = "/admin/edicao-contas")
	public ModelAndView edicaoContas() {
		ModelAndView modelAndView = new ModelAndView("admin/edicao-contas");
		return modelAndView;
	}
}

