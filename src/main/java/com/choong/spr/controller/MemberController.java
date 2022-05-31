package com.choong.spr.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.MemberDto;
import com.choong.spr.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	
	@Autowired
	private MemberService service;

	// TODO : MemberService 작성
	//		  		addMember method 작성
	//        MemberMapper.java, xml 작성
	// 				insertMember method 작성
	
	@GetMapping("signup")
	public void signupForm() {
		
	}
	
	@PostMapping("signup")
	public String signupProcess(MemberDto member, RedirectAttributes rttr) {
		boolean success = service.addMember(member);
		if (success) {
			System.out.println("회원가입 성공...");
			rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
			return "redirect:/board/list";
		} else {
			System.out.println("회원가입 실패...");
			rttr.addFlashAttribute("message", "회원가입을 실패했습니다.");
			rttr.addFlashAttribute("member", member); // 적었던 값을 다시 적용
			return "redirect:/member/signup";
		}
	}
	
	@GetMapping(path = "check", params = "id")
	@ResponseBody
	public String idCheck(String id) {
		boolean exist = service.hasMemberId(id);
		
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@GetMapping(path = "check", params = "email")
	@ResponseBody
	public String emailCheck(String email) {
		boolean exist = service.hasMemberEmail(email);
		
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@GetMapping(path = "check", params = "nickName")
	@ResponseBody
	public String nickNameCheck(String nickName) {
		boolean exist = service.hasMemberNickName(nickName);
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@GetMapping("list")
	// jsp (id, password, email, nickName, inserted) table로 보여주세요.
	// ORDER BY inserted DESC
	public void list(Model model) {
		List<MemberDto> list = service.listMember();
		model.addAttribute("memberList", list);
	}
	
	@GetMapping("get")
	public String getMember(String id,
			Principal principal,
			HttpServletRequest request,
			Model model) {
		
		// 본인 정보 확인
		if (hasAuthOrAdmin(id, principal, request)) { 
			MemberDto member = service.getMemberById(id);
			model.addAttribute("member", member);
			
			return null;
		}
		
		return "redirect:/member/login";
	}
	// HttpServletRequest에서 isUserInRole 메소드 사용
	// admin 권한 부여
	private boolean hasAuthOrAdmin(String id, Principal principal, HttpServletRequest req) {
		return (req.isUserInRole("ROLE_ADMIN") || 
				(principal != null && principal.getName().equals(id)));
	}
	
	@PostMapping("remove")
	public String removeMember(MemberDto dto,
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {
		
		if (hasAuthOrAdmin(dto.getId(), principal, req)) {
			boolean success = service.removeMember(dto);
			
			if (success) {
				rttr.addFlashAttribute("message", "회원 탈퇴되었습니다.");
				return "redirect:/board/list";
			} else {
				rttr.addAttribute("id", dto.getId());
				return "redirect:/member/get";
			}
			
		} else {
			return "redirect:/member/login";
		}
	}
	
	@PostMapping("modify")
	public String modifyMember(MemberDto dto,
			String oldPassword,
			Principal principal,
			HttpServletRequest req,
			RedirectAttributes rttr) {
		
		if(hasAuthOrAdmin(dto.getId(), principal, req)) {
			boolean success = service.modifyMember(dto, oldPassword);
			
			if (success) {
				rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
			}
			
			rttr.addFlashAttribute("member", dto); // model object
			rttr.addAttribute("id", dto.getId()); // query string
			
		return "redirect:/member/get";
		} else {
			return "redirect:/member/login";
		}
	}
	
	// 로그인 화면
	@GetMapping("login")
	public void loginPage() {
		
	}
	
	// 비밀번호 초기화
	@GetMapping("initpw")
	public void initpwPage() {
		
	}
	
}
