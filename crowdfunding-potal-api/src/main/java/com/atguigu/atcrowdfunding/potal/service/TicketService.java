package com.atguigu.atcrowdfunding.potal.service;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Ticket;
import org.apache.ibatis.annotations.Param;

public interface TicketService {

    Ticket getTicketByMemberId(Integer id);

    void saveTicket(Ticket ticket);

    void updatePstep(Ticket ticket);

    void update(Ticket ticket);

    Member getMemberByPiid(@Param("processInstanceId") String processInstanceId);

    void updateStatus(Member member);
}
