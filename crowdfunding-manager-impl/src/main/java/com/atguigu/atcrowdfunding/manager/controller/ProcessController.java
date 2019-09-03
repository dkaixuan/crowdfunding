package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/process")
public class ProcessController {

    @Autowired
    private RepositoryService repositoryService;



    @RequestMapping("/index")
    public String index() {
        return "process/index";
    }

    @ResponseBody
    @RequestMapping("/doIndex")
    public Msg doIndex(@RequestParam(value = "pn",defaultValue ="1") Integer pn) {
        PageHelper.startPage(pn, 5);
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
        List<ProcessDefinition> list = processDefinitionQuery.list();

        List<Map<String, Object>> mylistPage = new ArrayList<>();
        for (ProcessDefinition processDefinition : list) {
            Map<String, Object> pd = new HashMap<>();
            pd.put("id", processDefinition.getId());
            pd.put("name", processDefinition.getName());
            pd.put("key", processDefinition.getKey());
            pd.put("version", processDefinition.getVersion());
            mylistPage.add(pd);
        }

        long totalsize = processDefinitionQuery.count();

        PageInfo pageInfo = new PageInfo(mylistPage,6);

        return Msg.success().add("pageInfo",pageInfo);
    }


    @ResponseBody
    @RequestMapping("/deploy")
    public Msg deplot(MultipartHttpServletRequest multipartHttpServletRequest) throws IOException {

       MultipartFile multipartFile=multipartHttpServletRequest.getFile("processDefFile");

        repositoryService.createDeployment()
                .addInputStream(multipartFile.getOriginalFilename(),multipartFile.getInputStream()).deploy();
        return Msg.success();
    }
    @ResponseBody
    @RequestMapping("/doDelete")
    public Msg doDelete(String id) {

        ProcessDefinition processDefinition= repositoryService.createProcessDefinitionQuery().processDefinitionId(id).singleResult();
        repositoryService.deleteDeployment(processDefinition.getDeploymentId(),true);
        return Msg.success();
    }


    @RequestMapping("/showimg")
    public String showImg()  {


        return "process/showimg";
    }


    @RequestMapping("/showimgProDef")
    public  void showImg(String id, HttpServletResponse response) throws IOException {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(id).singleResult();
        InputStream resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), processDefinition.getDiagramResourceName());
        ServletOutputStream outputStream = response.getOutputStream();
        IOUtils.copy(resourceAsStream, outputStream);
    }




}
