package com.dawn.barona.controller.m;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/m")
public class HomeControllerM {
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String main() {
		return "mobile/main";
	}

}