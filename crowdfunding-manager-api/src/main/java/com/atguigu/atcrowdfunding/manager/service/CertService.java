package com.atguigu.atcrowdfunding.manager.service;

import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.MemberCert;

import java.util.List;

public interface CertService {
    List<Cert> queryAllCert();

    List<Cert> queryCertByAccttype(String accttype);

    void saveMemberCert(List<MemberCert> certimgs);
}
