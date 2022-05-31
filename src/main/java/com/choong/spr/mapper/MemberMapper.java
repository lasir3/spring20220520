package com.choong.spr.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.choong.spr.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int conutMemeberEmail(String email);

	int countMemberNickName(String nickName);

	List<MemberDto> selectAllMember();

	MemberDto selectMemberById(String id);

	int deleteMemberById(String id);

	int deleteAuthById(String id);
	
	int updateMember(MemberDto dto);

	int insertAuth(@Param("id") String id, @Param("auth") String string);

	int updateMemberPw(String id);

	int updateMemberPw(@Param("id")String id, @Param("pw")String pw);

}
