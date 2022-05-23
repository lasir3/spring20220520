package com.choong.spr.controller.ex02;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.choong.spr.domain.ex02.Book;

@Controller
@RequestMapping("ex03")
@ResponseBody // 컨트롤러 안의 모든 메소드에 적용
public class Ex03Controller {
	
	@RequestMapping("sub01")
	public String method01() {
		return "string data";
	}
	
	@RequestMapping("sub02")
	public Book method02() {
		Book b = new Book();
		b.setTitle("soccer");
		b.setWriter("jimin");
		
		return b;
	}
	
	@RequestMapping("sub03")
	public String method03() {
		System.out.println("ex03/sub03 일함");
		
		return "hello ajax";
	}
	
	@RequestMapping("sub04")
	public String method04() {
		System.out.println("ex03/sub04 일함");
		
		return null;
	}
	
	@RequestMapping("sub05")
	public String method05() {
		System.out.println("get방식 요청");
		return null;
	}
	
	@RequestMapping("sub06")
	public String method06() {
		System.out.println("post방식 요청");
		return null;
	}
	
//	@RequestMapping(method = RequestMethod.DELETE, value = "sub07")
	@DeleteMapping("sub07")
	public String method07() {
		System.out.println("ex03/sub07 delete 방식 일함!!!");
		
		return null;
	}
	
	@PutMapping("sub08")
	public String method08() {
		System.out.println("ex03/sub08 put 방식 일함@@@@");
		
		return null;
	}
	
	@GetMapping("sub09")
	public String method09(String title, String writer) {
		System.out.println("##받은 데이터 ");
		System.out.println("title:" + title);
		System.out.println("writer:" + writer);
		
		return null;
	}
	
	@PostMapping("sub10")
	public String method10(String name, String address) {
		System.out.println("name:" + name);
		System.out.println("address:" + address);
		
		return "Data Received!";
	}
	
	@PostMapping("sub11")
	public String method11(Book book) {
		System.out.println(book);
		
		return book.toString();
	}
}
