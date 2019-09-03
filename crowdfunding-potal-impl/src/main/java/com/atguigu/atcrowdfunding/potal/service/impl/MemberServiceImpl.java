package com.atguigu.atcrowdfunding.potal.service.impl;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.potal.dao.MemberMapper;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.util.exception.LoginFailException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Override
    public Member queryMemberLogin(Map<String, Object> paramMap) {
       Member member= memberMapper.queryMebmerlogin(paramMap);
        if (member == null) {
            throw new LoginFailException("用户账号或密码不正确");
        }
        return member;
    }

    @Override
    public void updateAcctType(Member member) {
        memberMapper.updateAcctType(member);

    }

    @Override
    public void updateBasicinfo(Member loginMember) {
        memberMapper.updateBasicinfo(loginMember);
    }

    @Override
    public void updateAuthstatus(Member loginMember) {
        memberMapper.updateAuthstatus(loginMember);
    }

    @Override
    public Member getMemberById(Integer memberid) {
        return memberMapper.getMemberById(memberid);
    }

    @Override
    public List<Map<String, Object>> queryCertByMemberId(Integer memberid) {
        return memberMapper.queryCertByMemberId(memberid);
    }

}
