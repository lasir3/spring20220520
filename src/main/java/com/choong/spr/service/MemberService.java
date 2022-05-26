package com.choong.spr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.choong.spr.domain.MemberDto;
import com.choong.spr.mapper.MemberMapper;

@Service
public class MemberService {

	@Autowired
	private MemberMapper mapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public boolean addMember(MemberDto member) {
		
		// 평문 암호를 암호화(encoding)
		String encodedPassword = passwordEncoder.encode(member.getPassword());
		
		// 암호화된 암호를 다시 세팅
		member.setPassword(encodedPassword);
		
		return mapper.insertMember(member) == 1;
	}

	public boolean hasMemberId(String id) {
		return mapper.countMemberId(id) > 0;
	}

	public boolean hasMemberEmail(String email) {
		return mapper.conutMemeberEmail(email) > 0;
	}

	public boolean hasMemberNickName(String nickName) {
		return mapper.countMemberNickName(nickName) > 0;
	}

	public List<MemberDto> listMember() {
		return mapper.selectAllMember();
	}

	public MemberDto getMemberById(String id) {
		return mapper.selectMemberById(id);
	}

	public boolean removeMember(MemberDto dto) {
		MemberDto member = mapper.selectMemberById(dto.getId());
		
		if (member.getPassword().equals(dto.getPassword())) {
			return mapper.deleteMemberById(dto.getId()) == 1;
		}
		return false;
	}

	public boolean modifyMember(MemberDto dto, String oldPassword) {
		// db에서 member 읽어서
		MemberDto oldMember = mapper.selectMemberById(dto.getId());
		
		// 기존 password가 일치할때만 계속 진행
		if (oldMember.getPassword().equals(oldPassword)) {
			return mapper.updateMember(dto) == 1;
		}	
			
		return false;
	}

}
