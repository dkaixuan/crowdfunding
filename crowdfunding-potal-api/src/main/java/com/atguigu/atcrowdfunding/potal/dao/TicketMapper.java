package com.atguigu.atcrowdfunding.potal.dao;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Ticket;

import java.util.List;

public interface TicketMapper {

    int deleteByPrimaryKey(Integer id);

    int insert(Ticket record);

    Ticket selectByPrimaryKey(Integer id);

    List<Ticket> selectAll();

    int updateByPrimaryKey(Ticket record);

    Ticket getTicketByMemberId(Integer id);

    void saveTicket(Ticket ticket);

    void updatePstep(Ticket ticket);

    void update(Ticket ticket);

    Member getMemberByPiid(String processInstanceId);

    void updateStatus(Member member);
}
