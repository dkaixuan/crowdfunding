package com.atguigu.atcrowdfunding.manager.service;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface AccountTypeCertService {
    List<Map<String, Object>> queryCertAccttype();
    

    void deleteAcctTypeCert(Map<String, Object> paramMap);

    void insertAcctTypeCert(Map<String, Object> paramMap);
}
