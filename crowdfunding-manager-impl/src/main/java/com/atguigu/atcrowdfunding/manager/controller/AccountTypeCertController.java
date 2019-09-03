package com.atguigu.atcrowdfunding.manager.controller;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.Msg;
import com.atguigu.atcrowdfunding.manager.service.AccountTypeCertService;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/certtype")
public class AccountTypeCertController {

    @Autowired
    private AccountTypeCertService accountTypeCertService;

    @Autowired
    private CertService certService;

    @RequestMapping("/index")
    public String index(Map<String,Object> map) {
        //查询所有资质
        List<Cert> certList = certService.queryAllCert();
        map.put("certList", certList);
        //查询资质与账户类型之间关系
        List<Map<String,Object>> CertAccttypelist=accountTypeCertService.queryCertAccttype();
        map.put("CertAccttypelist", CertAccttypelist);

        return "certtype/index";
    }


    @ResponseBody
    @RequestMapping("/insertAcctTypeCert")
    public Msg insertAcctTypeCert(String certid,String accttype) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("certid", certid);
        paramMap.put("accttype", accttype);
        accountTypeCertService.insertAcctTypeCert(paramMap);
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping("/deleteAcctTypeCert")
    public Msg deleteAcctTypeCert(String certid,String accttype) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("certid", certid);
        paramMap.put("accttype", accttype);

        accountTypeCertService.deleteAcctTypeCert(paramMap);
        return Msg.success();
    }







}
