package com.atguigu.atcrowdfunding.manager.dao;


import com.atguigu.atcrowdfunding.bean.Cert;
import com.atguigu.atcrowdfunding.bean.MemberCert;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CertMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Cert record);

    Cert selectByPrimaryKey(Integer id);

    List<Cert> selectAll();

    int updateByPrimaryKey(Cert record);

    List<Cert> queryCertByAccttype(String accttype);

    void saveMemberCert(@Param("certimgs") List<MemberCert> certimgs);
}