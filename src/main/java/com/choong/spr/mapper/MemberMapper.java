package com.choong.spr.mapper;

import com.choong.spr.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int conutMemeberEmail(String email);

	int countMemberNickName(String nickName);

}
