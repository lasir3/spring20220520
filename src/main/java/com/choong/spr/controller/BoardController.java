package com.choong.spr.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.choong.spr.domain.BoardDto;
import com.choong.spr.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
	
	@Autowired
	private BoardService service;

	@RequestMapping("list")
	public void list(@RequestParam(name = "keyword", defaultValue = "") String keyword,
					 @RequestParam(name = "type", defaultValue = "") String type,
			         Model model) {
		List<BoardDto> list = service.listBoard(type, keyword);
		model.addAttribute("boardList", list);
	}
	
	@GetMapping("insert")
	public void insert() {
		
	}
	
	// Principal : 권한 정보에 대한 내용 저장
	@PostMapping("insert")
	public String insert(BoardDto board, 
			MultipartFile[] file, 
			Principal principal, 
			RedirectAttributes rttr) {

//		if (file.getSize() > 0) {
//			board.setFileName(file.getOriginalFilename());
//		}
		
		if (file != null) {
			List<String> fileList = new ArrayList<String>();
			for (MultipartFile f : file) {
				fileList.add(f.getOriginalFilename());
			}
			board.setFileName(fileList);
		}
		
		board.setMemberId(principal.getName()); // 작성하는 멤버의 id값 불러옴
		boolean success = service.insertBoard(board, file);
		
		if (success) {
			rttr.addFlashAttribute("message", "새 글이 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "새 글이 등록되지 않았습니다.");
		}
		
		return "redirect:/board/list";
	}
	
	@GetMapping("get")
	public void get(int id, Model model) {
		BoardDto dto = service.getBoardById(id);
		model.addAttribute("board", dto);
		
		/* ajax로 처리하기 위해 삭제 */
		// List<ReplyDto> replyList = replyService.getReplyByBoardId(id);
		// model.addAttribute("replyList", replyList);
		
	}
	
	// 여러파일 업로드 수정, 삭제
	@PostMapping("modify")
	public String modify(BoardDto dto,
			@RequestParam(name = "removeFileList", required = false) ArrayList<String> removeFileList,
			MultipartFile[] addFileList,
			Principal principal,
			RedirectAttributes rttr) {
		BoardDto oldBoard = service.getBoardById(dto.getId());
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.updateBoard(dto, removeFileList, addFileList);
			
			if (success) {
				rttr.addFlashAttribute("message", "글이 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "글이 수정되지 않았습니다.");
			}
		} else {
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		rttr.addAttribute("id", dto.getId());
		
		return "redirect:/board/get";
	}
	
	@PostMapping("remove")
	public String remove(BoardDto dto, Principal principal, RedirectAttributes rttr) {
		
		// 게시물 정보 얻고
		BoardDto oldBoard = service.getBoardById(dto.getId());
		// 게시물 작성자(memberId)와 principal의 name과 비교해서 같을 때만 진행.
		if (oldBoard.getMemberId().equals(principal.getName())) {
			boolean success = service.deleteBoard(dto.getId());
		
			if (success) {
				rttr.addFlashAttribute("message", "글이 삭제 되었습니다.");
				
			} else {
				rttr.addFlashAttribute("message", "글이 삭제 되지않았습니다.");
			}
			
		} else { 
			rttr.addFlashAttribute("message", "권한이 없습니다.");
		}
		// 아니면 리턴.
		return "redirect:/board/list";
	}
}










