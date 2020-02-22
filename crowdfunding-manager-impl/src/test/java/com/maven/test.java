package com.maven;

/**
 * @author kaixuan
 * @version 1.0
 * @date 2020/2/21 14:51
 */
public class test {
    public static void main(String[] args) {
        test test = new test();
         int s= test.f(50);
        System.out.println(s);
    }


    public int f(int n) {
        if (n == 1||n==2) {
            return n;
        }

        return f(n-2)+f(n - 1);
    }



}
