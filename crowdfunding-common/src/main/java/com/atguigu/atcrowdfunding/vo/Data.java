package com.atguigu.atcrowdfunding.vo;


import com.atguigu.atcrowdfunding.bean.MemberCert;

import java.util.ArrayList;
import java.util.List;

public class Data {

    public List<MemberCert> getCertimgs() {
        return certimgs;
    }

    public void setCertimgs(List<MemberCert> certimgs) {
        this.certimgs = certimgs;
    }

    private List<MemberCert> certimgs = new ArrayList<>();

}
