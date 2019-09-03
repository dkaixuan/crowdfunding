package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.AccountTypeCert;
import com.atguigu.atcrowdfunding.manager.dao.AccountTypeCertMapper;
import com.atguigu.atcrowdfunding.manager.service.AccountTypeCertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AccountTypeCertServiceImpl implements AccountTypeCertService {

    @Autowired
    private AccountTypeCertMapper accountTypeCertMapper;


    @Override
    public List<Map<String, Object>> queryCertAccttype() {
        return accountTypeCertMapper.queryCertAccttype();
    }

    @Override
    public void deleteAcctTypeCert(Map<String, Object> paramMap) {
        accountTypeCertMapper.deleteAcctTypeCert(paramMap);
    }
    @Override
    public void insertAcctTypeCert(Map<String, Object> paramMap) {
        accountTypeCertMapper.insertAcctTypeCert(paramMap);
    }
}
