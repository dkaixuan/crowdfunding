package com.atguigu.atcrowdfunding.potal.controller;

import com.atguigu.atcrowdfunding.bean.*;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import com.atguigu.atcrowdfunding.potal.listener.PassListener;
import com.atguigu.atcrowdfunding.potal.listener.RefuseListener;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.TicketService;
import com.atguigu.atcrowdfunding.util.Const;
import com.atguigu.atcrowdfunding.vo.Data;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.apache.commons.mail.Email;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/member")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private TicketService tickService;

    @Autowired
    private CertService certService;

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private TaskService taskService;


    @RequestMapping("/accttype")
    public String accttype() {
        return "member/accttype";
    }


    @RequestMapping("/uploadcert")
    public String uploadcert() {
        return "member/uploadcert";
    }


    @RequestMapping("/basicinfo")
    public String basicinfo() {
        return "member/basicinfo";
    }


    @RequestMapping("/checkemail")
    public String checkemail() {

        return "member/checkemail";
    }
    @RequestMapping("/checkauthcode")
    public String checkauthcode() {
        return "member/checkauthcode";
    }





    @ResponseBody
    @RequestMapping("/updateAcctType")
    public Msg updateAcctType(HttpSession session,String accttype) {

       Member member= (Member) session.getAttribute(Const.LOGIN_MEMBER);
        member.setAccttype(accttype);
        memberService.updateAcctType(member);
        return Msg.success();
    }

    @ResponseBody
    @RequestMapping("/updateBasicinfo")
    public Msg updateBasicinfo(HttpSession session,Member member) {
        Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
        loginMember.setRealname(member.getRealname());
        loginMember.setCardnum(member.getCardnum());
        loginMember.setTel(member.getTel());
        Ticket ticket= tickService.getTicketByMemberId(loginMember.getId());
        ticket.setPstep("basicinfo");
        tickService.updatePstep(ticket);


        memberService.updateBasicinfo(loginMember);

        return Msg.success();
    }




    @RequestMapping("/apply")
    public String apply(HttpSession session,Member member) {

        Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);

      Ticket ticket= tickService.getTicketByMemberId(loginMember.getId());
        if (ticket == null) {
            ticket = new Ticket();
            ticket.setMemberid(loginMember.getId());
            ticket.setPstep("apply");
            ticket.setStatus("0");

            tickService.saveTicket(ticket);
        }else{
            String pstep = ticket.getPstep();
            if("accttype".equals(pstep)){
                return "redirect:/member/basicinfo.htm";
            } else if ("basicinfo".equals(pstep)) {

                String accttype = loginMember.getAccttype();
                List<Cert>certList=certService.queryCertByAccttype(accttype);
                session.setAttribute("certList",certList);
                return "redirect:/member/uploadcert.htm";
            }else if ("uploadcert".equals(pstep)) {
                return "redirect:/member/checkemail.htm";
            }else if ("checkemail".equals(pstep)) {

                return "redirect:/member/checkauthcode.htm";
        }
        }
        return "member/accttype";
    }



    @ResponseBody
    @RequestMapping("/doUploadCert")
    public Msg doUploadCert(HttpSession session, Data data) throws IOException {
        Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
        //保存会员与资质关系数据
        String realPath=session.getServletContext().getRealPath("/pics");
        //资质文件上传
        List<MemberCert> certimgs = data.getCertimgs();
        for (MemberCert memberCert : certimgs) {
            MultipartFile fileImg = memberCert.getFileImg();
            String extName=fileImg.getOriginalFilename().substring(fileImg.getOriginalFilename().lastIndexOf("."));

            String tmpName = UUID.randomUUID().toString() + extName;

            String filename=realPath + "/cert"+"/" +tmpName;
            fileImg.transferTo(new File(filename));
            //封装数据，保存数据库
            memberCert.setIconpath(tmpName);
            memberCert.setMemberid(loginMember.getId());
        }

        certService.saveMemberCert(certimgs);

        Ticket ticket= tickService.getTicketByMemberId(loginMember.getId());
        ticket.setPstep("uploadcert");
        tickService.updatePstep(ticket);
        return Msg.success();
    }





        @ResponseBody
        @RequestMapping("/startProcess")
        public Msg startProcess(String email,HttpSession session){
        Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);
        //启动实名认证流程- 系统自动发送邮件，生成验证码，验证邮箱地址是否正确
            // ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId("auth").singleResult();

            StringBuilder authcode = new StringBuilder();
            for (int i = 1; i <= 4; i++) {
                authcode.append(new Random().nextInt(10));
            }

            Map<String, Object> variables = new HashMap<>();
            //toEmail、auyhcode、loginacct、flag、passListener
            variables.put("toEmail", email);
            variables.put("authcode", authcode);
            variables.put("loginacct", loginMember.getLoginacct());
            variables.put("passListener", new PassListener());
            variables.put("refuseListener", new RefuseListener());


            ProcessInstance auth = runtimeService.startProcessInstanceByKey("auth",variables);


            Ticket ticket= tickService.getTicketByMemberId(loginMember.getId());
            ticket.setPstep("checkemail");
            ticket.setPiid(auth.getId());
            ticket.setAuthcode(authcode.toString());
            //更新流程单中的步骤、流程ID、验证码
            tickService.update(ticket);
            return Msg.success();

        }

    @ResponseBody
    @RequestMapping("/finishApply")
    public Msg finishApply(String authcode,HttpSession session){
        Member loginMember= (Member) session.getAttribute(Const.LOGIN_MEMBER);

        Ticket ticket= tickService.getTicketByMemberId(loginMember.getId());

        if (ticket.getAuthcode().equals(authcode)) {
            //完成审核验证码任务
            Task task = taskService.createTaskQuery().processInstanceId(ticket.getPiid()).taskAssignee(loginMember.getLoginacct()).singleResult();
            taskService.complete(task.getId());
            loginMember.setAuthstatus("1");
            memberService.updateAuthstatus(loginMember);
            ticket.setPstep("finishapply");
            tickService.updatePstep(ticket);
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }





        }


