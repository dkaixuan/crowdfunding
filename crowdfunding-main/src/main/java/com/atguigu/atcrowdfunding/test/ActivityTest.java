package com.atguigu.atcrowdfunding.test;

import org.activiti.engine.ProcessEngine;
import org.activiti.engine.RepositoryService;

import org.activiti.engine.repository.Deployment;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

public class ActivityTest {



        ApplicationContext ioc = new ClassPathXmlApplicationContext("spring/spring-*.xml");

        ProcessEngine processEngine = (ProcessEngine) ioc.getBean("processEngine");


        @Test
        public void test01() {
                ProcessEngine processEngine = (ProcessEngine) ioc.getBean("processEngine");
        }


        //部署

        @Test
        public void test02() {
                RepositoryService repositoryService = processEngine.getRepositoryService();
                Deployment deploy= repositoryService.createDeployment().addClasspathResource("test/MyProcess1.bpmn").deploy();
        }

        //查询部署

        @Test
        public void test03() {
                RepositoryService repositoryService = processEngine.getRepositoryService();
                ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery();
                List<ProcessDefinition> list = processDefinitionQuery.list();
                for (ProcessDefinition processDefinition : list) {
                        System.out.println(processDefinition.getId());
                        System.out.println(processDefinition.getName());
                        System.out.println(processDefinition.getKey());

                }

        }
}
