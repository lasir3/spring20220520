package com.choong.spr.controller.ex02;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.choong.spr.domain.ex02.Book;

@Controller
@RequestMapping("ex02")
public class Ex02Controller {
	
	@RequestMapping("sub01")
	public String method01() {
		return "hello"; // html을 불러온다
	}
	
	@RequestMapping("sub02")
	@ResponseBody // html이 아닌 값 자체를 불러온다
	public String method02() {
		return "hello";
	}
	
	@RequestMapping("sub03")
	@ResponseBody
	public String method03() {
		
		return "{\"title\": \"java\", \"writer\": \"son\"}";
	}
	
	@RequestMapping("sub04")
	@ResponseBody
	public Book method04() {
		Book b = new Book();
		b.setTitle("Spring");
		b.setWriter("son");
		
		return b;
	}
}
