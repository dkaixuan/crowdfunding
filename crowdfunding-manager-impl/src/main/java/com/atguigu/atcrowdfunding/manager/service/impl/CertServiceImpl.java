package com.atguigu.atcrowdfunding.manager.service.impl;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.MemberCert;
import com.atguigu.atcrowdfunding.manager.dao.CertMapper;
import com.atguigu.atcrowdfunding.manager.service.CertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CertServiceImpl implements CertService {

    @Autowired
    private CertMapper certMapper;


    @Override
    public List<Cert> queryAllCert() {
        return certMapper.selectAll();
    }

    @Override
    public List<Cert> queryCertByAccttype(String accttype) {
        return certMapper.queryCertByAccttype(accttype);
    }

    @Override
    public void saveMemberCert(List<MemberCert> certimgs) {
            certMapper.saveMemberCert(certimgs);
    }
}
