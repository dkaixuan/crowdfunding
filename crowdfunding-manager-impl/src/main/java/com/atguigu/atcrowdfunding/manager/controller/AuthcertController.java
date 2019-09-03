package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Member;
import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.potal.service.MemberService;
import com.atguigu.atcrowdfunding.potal.service.TicketService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.task.Task;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/authcert")
public class AuthcertController {
    @Autowired
    private TaskService taskService;

    @Autowired
    private RepositoryService repositoryService;

    @Autowired
    private TicketService ticketService;

    @Autowired
    private MemberService memberService;


    @RequestMapping("/index")
    public String index() {
        return "authcert/index";
    }


    @ResponseBody
    @RequestMapping("/pass")
    public Msg pass(String taskid,Integer memberid) {

        taskService.setVariable(taskid, "flag", true);
        taskService.setVariable(taskid, "memberid", memberid);
        taskService.complete(taskid);

        return Msg.success();
    }


    @ResponseBody
    @RequestMapping("/refuse")
    public Msg refuse(String taskid,Integer memberid) {

        taskService.setVariable(taskid, "flag", false);
        taskService.setVariable(taskid, "memberid", memberid);
        taskService.complete(taskid);

        return Msg.success();
    }




    @RequestMapping("/show")
    public String show(Integer memberid,Map map) {
       Member member= memberService.getMemberById(memberid);

       List<Map<String,Object>>list=memberService.queryCertByMemberId(memberid);

        map.put("member", member);
        map.put("certimgs", list);


        return "authcert/show";
    }



    @ResponseBody
    @RequestMapping("/queryAll")
    public Msg queryAll(@RequestParam(value = "pn",defaultValue ="1") Integer pn) {
        PageHelper.startPage(pn, 6);

        //1.查询后台委托组的任务
       List<Task> listPage=taskService.createTaskQuery().processDefinitionKey("auth")
                .taskCandidateGroup("backuser").list();

        List<Map<String, Object>> data = new ArrayList<>();

        for (Task task : listPage) {
            Map<String, Object> map = new HashMap<>();
            map.put("taskId", task.getId());
            map.put("taskName", task.getName());

            //2.根据任务查询流程定义（流程定义名称，流程定义版本（
            ProcessDefinition processDefinition = repositoryService
                    .createProcessDefinitionQuery()
                    .processDefinitionId(task.getProcessDefinitionId())
                    .singleResult();
            map.put("procDeName", processDefinition.getName());
            map.put("procDefVersion", processDefinition.getVersion());
           Member member=ticketService.getMemberByPiid(task.getProcessInstanceId());

            //3.根据任务查询流程实例（根据流程实例的id查询流程单，查询用互信息）
            map.put("member", member);
            data.add(map);
        }

        PageInfo pageInfo = new PageInfo(data,7);

        return Msg.success().add("pageInfo",pageInfo);
    }



}
